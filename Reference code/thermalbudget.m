% Thermal budget simulator
% It takes the available solar power from SPENVIS simulations for the
% different satellite axis and computes the average incoming heat and 
% determines the equilibrium temperature and the temperature swing
%
% Author: Stefano Speretta <s.speretta@tudelft.nl>
%
close all
clearvars
clc

% load phisycal constants needed for simulation
constants

% load illumination profile from SPENVIS files
%loadISSorbit;
loadFUNcubeorbit;

% load satellite configuration
pocketqube3U;
%funcube;

points = size(inputE, 2);

% spinX = 15; % degrees/second
% spinY = 12; % degrees/second
% spinZ = 22; % degrees/second

spinX = 0; % degrees/second
spinY = 0; % degrees/second
spinZ = 0; % degrees/second

t0 = 4.2 - T0;

b = zeros(size(SolverMatrix, 2), points);
states = zeros(size(SolverMatrix, 1), points);

t = zeros(length(hc), points);
t(:,1) = t0;
t(7,1) = 17-T0;
% 3-axis rotation angles (all initialized to 0)
xAngle = 0;
yAngle = 0;
zAngle = 0;

% heat per simulation node
heat = zeros(length(hc), points);
heat(1:6, 1) =    alphaSolarCells * rotateZ(rotateY(rotateX(inputT(:, 1)', xAngle), yAngle), zAngle) .* sa ...
                - rotateZ(rotateY(rotateX(inputE(:, 1)', xAngle), yAngle), zAngle) .* sa * efficiency ...
                + alphaPanels * rotateZ(rotateY(rotateX(inputT(:, 1)', xAngle), yAngle), zAngle) .* panelarea;
heat(7,:) = constantHeat;

% create the arrays used to store the average surfaces
% area covered by silar cells
surfaceSA = zeros(size(inputE, 1), size(inputE, 2));
% solar panel area not covered by solar cells
surfaceSP = zeros(size(inputE, 1), size(inputE, 2));

avgHpower = sum(heat(1:6, 1));

for h = 2 : points
    % calculate the incoming heat power
    heat(1:6, h) =    alphaSolarCells * rotateZ(rotateY(rotateX(inputT(:, h)', xAngle), yAngle), zAngle) .*  sa ...
                    - rotateZ(rotateY(rotateX(inputE(:, h)', xAngle), yAngle), zAngle) .* sa * efficiency ...
                    + alphaPanels * rotateZ(rotateY(rotateX(inputT(:, h)', xAngle), yAngle), zAngle) .* panelarea;
    
    % keep track of the current position 
    xAngle = xAngle + spinX;
    yAngle = yAngle + spinY;
    zAngle = zAngle + spinZ;
    
    % calculate the total heat and normalize to account for 50%
    % illumination over the orbit
    %heat(1:6,h) = (output(:, h)) / mean(x(:,1)) * 0.5;
    avgHpower = avgHpower + sum(heat(1:6, h));
    
    surfaceSA(:,h) = rotateZ(rotateY(rotateX(sa, xAngle), yAngle), zAngle)';
    surfaceSP(:,h) = rotateZ(rotateY(rotateX(panelarea, xAngle), yAngle), zAngle)';
    
    % subtract the heat radiated (Stefan Boltzman law) by the solar cells
    heat(1:6,h) = heat(1:6,h) - sa' * sigma * epsilonSolarCells .* t(1:6, h - 1).^4;
    
    % subtract the heat radiated (Stefan Boltzman law) by the rest of the
    % solar panel area
    heat(1:6,h) = heat(1:6,h) - panelarea' * sigma * epsilonPanels .* t(1:6, h - 1).^4;

    % only take into account the lines that describe states (that also have
    % an incoming heat)
    b(1:length(hc), h) = heat(:,h) +  hc(:) / dt .* t(:,h - 1);     

    states = max(0, SolverMatrix \ b(:,h));
    
    % the first states are temperatures, the others are fluxes
    t(:, h) = states(1:length(hc));
end

if (0)

figure
plot(output(1, :));
hold on
plot(output(2, :), 'r')
grid on
title('X')
%xlim([0 1000])

figure
plot(output(3, :));
hold on
plot(output(4, :), 'r')
grid on
title('Y')
%xlim([0 1000])

figure
plot(output(5, :));
hold on
plot(output(6, :), 'r')
grid on
title('Z')
%xlim([0 1000])
end

range = 1:size(t, 2);
%range = 1e4:1.3e4;

plotAverage = mean(t(7,range))+T0

avgHpower = avgHpower / points;
avgSurfaceSA = mean(sum(surfaceSA, 1));
avgSurfaceSP = mean(sum(surfaceSP, 1));
equilibriumT = ((avgHpower + constantHeat) / (epsilonSolarCells * avgSurfaceSA + ...
    epsilonPanels * avgSurfaceSP) / sigma)^(1/4) + T0

figure
plot(t(1,range)+T0-plotAverage+equilibriumT, 'LineWidth', 2)
hold on
plot(t(2,range)+T0-plotAverage+equilibriumT, 'r', 'LineWidth', 2)
plot(t(3,range)+T0-plotAverage+equilibriumT, 'g', 'LineWidth', 2)
plot(t(4,range)+T0-plotAverage+equilibriumT, 'k', 'LineWidth', 2)
plot(t(5,range)+T0-plotAverage+equilibriumT, 'm', 'LineWidth', 2)
plot(t(6,range)+T0-plotAverage+equilibriumT, 'c', 'LineWidth', 2)
plot(t(7,range)+T0-plotAverage+equilibriumT, 'b--', 'LineWidth', 2)
grid on
legend('X+', 'X-', 'Y+', 'Y-', 'Z+', 'Z-', 'Payload');
title('Thermal Simulation')
xlabel('Time - s')
ylabel('Temperature - degC')
axis tight


