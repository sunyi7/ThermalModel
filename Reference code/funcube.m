% Satellite description file for a 3U PocketQube

% satellite spin rates per axis
% spinX = 1.5438; % degrees/second
% spinY = 1.2345; % degrees/second
% spinZ = 2.2654; % degrees/second
spinX = 1.5; % degrees/second
spinY = 1.5; % degrees/second
spinZ = 1.5; % degrees/second

% internal average power dissipation
constantHeat = 1.3; % W

% active area of the solar panel in m^2
% use 0.00318 for AzurSpace solar cells
scarea = 0.00318; % m^2
% solar cells conversion efficiency
% use 0.298 for AzurSpace TJ30C solar cells
efficiency = 0.298;

% axis definition: X+ X- Y+ Y- Z+ Z-
% [1 1 1 1 0 0] means that the satellite has 1 solar cell on the
% X+, X-, Y+ and Y- directions

% 1U CubeSat
sa = [2 2 2 2 2 2] * scarea;
SolarArray = 0.106 * 0.106 * [1 1 1 1 1 1];
% thicknessSolarArray = 1e-3;
thicknessSolarArray = 1.65e-3; %To have a 50g panel


contactWidth = 1e-3;
%tcLongSide  = thicknessSolarArray / (0.178 * contactWidth * thermCAl);
%tcShortSide = thicknessSolarArray / (0.05  * contactWidth * thermCAl);

% tcLongSide  = 0.05  / (0.178 * thicknessSolarArray * thermCAl);
% tcShortSide  = (0.178/2 + 0.05/2)  / (0.05 * thicknessSolarArray * thermCAl);
tcLongSide  = 0.106  / (0.106 * thicknessSolarArray * thermCAl); % has to be changed
tcShortSide  = (0.106/2 + 0.106/2)  / (0.106 * thicknessSolarArray * thermCAl); % has to be changed

volumeSolarArray = SolarArray * thicknessSolarArray;

% area not covered by solar cells
panelarea = SolarArray - sa;
% make sure the panel area cannot be negative
if any(sum(panelarea < 0) ~= 0)
    error('One element of panel area is negative')
end

% solar panels mass
massSolarArray = volumeSolarArray * densityAl;

% calculate the heat capacitance
hc = (heatCAl * massSolarArray)';

% absorbptivity of the solar panel surface (anodized alluminum)
% alphaPanels = 0.5;
alphaPanels = 0.42;
% emissivity of the solar panel surface (anodized alluminum)
% epsilonPanels = 0.8;
epsilonPanels = 0.8;
% absorbptivity of AzurSpace solar cells
% alphaSolarCells = 0.91;
alphaSolarCells = 0.84;
% emissivity of solar cells (from Emcore / ClydeSpace datasheet)
% epsilonSolarCells = 0.85;
epsilonSolarCells = 0.90;

t0 = 238;

hcFR4 = heatCFR4 * 0.096 * 0.096 * 0.0016 * 5 * 9.5 * densityFR4; %Volume adapted to have mass = 1.3kg
hc = [hc; hcFR4];

%payload conductance matrix
payloadR  = 0.1 / (4 * 2.5e-3 *  2.5e-3 * pi * thermCBrass);

SolverMatrix = diag(hc) / dt;

% thermal conductance between X+ and the other faces
SolverMatrix = addThermalConnection(SolverMatrix, [1 0 -1 0 0 0], tcLongSide);
SolverMatrix = addThermalConnection(SolverMatrix, [1 0 0 -1 0 0], tcLongSide);
SolverMatrix = addThermalConnection(SolverMatrix, [1 0 0 0 -1 0], tcShortSide);
SolverMatrix = addThermalConnection(SolverMatrix, [1 0 0 0 0 -1], tcShortSide);

% thermal conductance between X- and the remaining faces
SolverMatrix = addThermalConnection(SolverMatrix, [0 1 -1 0 0 0], tcLongSide);
SolverMatrix = addThermalConnection(SolverMatrix, [0 1 0 -1 0 0], tcLongSide);
SolverMatrix = addThermalConnection(SolverMatrix, [0 1 0 0 -1 0], tcShortSide);
SolverMatrix = addThermalConnection(SolverMatrix, [0 1 0 0 0 -1], tcShortSide);

% thermal conductance between Y+ and the remaining faces
SolverMatrix = addThermalConnection(SolverMatrix, [0 0 1 0 -1 0], tcShortSide);
SolverMatrix = addThermalConnection(SolverMatrix, [0 0 1 0 0 -1], tcShortSide);

% thermal conductance between Y- and the remaining faces
SolverMatrix = addThermalConnection(SolverMatrix, [0 0 0 1 -1 0], tcShortSide);
SolverMatrix = addThermalConnection(SolverMatrix, [0 0 0 1 0 -1], tcShortSide);

% thermal conductance between the payload and the Z+ and Z- faces
SolverMatrix = addThermalConnection(SolverMatrix, [0 0 0 0 1 0 -1], payloadR);
SolverMatrix = addThermalConnection(SolverMatrix, [0 0 0 0 0 1 -1], payloadR);

% calculate the effective absorbing and emitting area (weighted by the
% absorption and emission coefficients)
effectiveAbsorbingArea = panelarea' * alphaPanels + sa' * alphaSolarCells;
effectiveEmittingArea = panelarea' * epsilonPanels + sa' * epsilonSolarCells;
