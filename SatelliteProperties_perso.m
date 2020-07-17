
% Satellite orbital parameters

%% Funcube
% %Day of the simulation
% day = 4 ;
% year = 2016 ;
% month = 2 ; 
% day = 35;
% 
% % Orbital parameters
% Mean_anomaly = 283.694 *pi/180 ; %Mean anomaly of funcube at the begining 
% h = 630E3 ; %altitude
% LTAN = 10+30/60+0/3600 ; %Local time of the ascending node (for sun synchronous orbit) (in hours)
% RAAN = 94.3150 *pi/180 ;
% i = 97.004 *pi/180 ; %inclination (in rad)
% beta = BetaAngle_perso(35,RAAN,i) ; %beta angle (in rad)

%% QB50 P1
% % Day of the simulation
% day = 7 ;
% year = 2015 ;
% month = 5 ; 
% day = 127 ;
% 
% % Orbital parameters
% h = 604.2E3 ; %altitude (m)
% Mean_anomaly = 30.8695 *pi/180 ; %Mean anomaly (in rad)
% LTAN = 6+0/60+0/3600 ; %Local time of the ascending node (for sun synchronous orbit) (in hours)
% RAAN = 25.42 *pi/180 ;
% i = 97.96 *pi/180 ; %inclination (in rad)
% beta = BetaAngle_perso(127,RAAN,i) ; %beta angle (in rad)
% % beta=pi/2;

%% DelfiPQ Cold case scenario
% %Day of the simulation
% day = 4 ;
% year = 2019 ;
% month = 10 ; 
% day = 277 ;
% 
% % day = 1 ;
% % year = 2014 ;
% % month = 7 ;
% % day = 182 ;
% 
% % Orbital parameters
% Mean_anomaly = 326.0640 *pi/180 ; %Mean anomaly of funcube at the begining
% %Mean_anomaly = 14.78336100 *pi/180 ;
% h = 630E3 ; %altitude
% LTAN = 10+30/60+0/3600 ; %Local time of the ascending node (for sun synchronous orbit) (in hours)
% RAAN = 287.2153 *pi/180 ;
% i = 97.004 *pi/180 ; %inclination (in rad)
% beta = 1.5405 ; %beta angle for the coldest scenario (in rad)
% %beta=0.4428 ;

%% DelfiPQ hot case scenario
%Day of the simulation
day = 26 ;
year = 2018 ;
month = 1 ; 
day = 26 ;

% Orbital parameters
Mean_anomaly = 105.0112 *pi/180 ; %Mean anomaly of funcube at the begining
h = 630E3 ; %altitude
LTAN = 10+30/60+0/3600 ; %Local time of the ascending node (for sun synchronous orbit) (in hours)
RAAN = 63.9847 *pi/180 ;
i = 97.004 *pi/180 ; %inclination (in rad)
beta = 1.1448 ; %beta angle for the coldest scenario (in rad)

%% Initial orientation of the satellite faces
pol_X = pi/2 ; %nadir facing plate
azi_X = pi ;
% pol_X = pi/2 ; %zenith facing plate
% azi_X = 0 ;
pol_Xm = pi-pol_X ;
if azi_X == 0 && pol_X == 0
    azi_Xm = 0;
elseif azi_X == 0 && pol_X == pi
    aziXm = 0;
else
    azi_Xm = mod(azi_X+pi,2*pi) ;
end

pol_Y = 0 ; %forward facing plate
azi_Y = 0 ;
% pol_Y = pi ; %aft facing plate
% azi_Y = 0 ;
pol_Ym = pi-pol_Y ;
if azi_Y == 0 && pol_Y == 0
    azi_Ym=0 ;
elseif azi_Y == 0 && pol_Y == pi
    azi_Ym = 0;
else
    azi_Ym = mod(azi_Y+pi,2*pi) ;    
end

pol_Z = pi/2 ; %South facing plate
azi_Z = pi/2 ;
pol_Zm = pi-pol_Z ;
if azi_Z == 0 && pol_Z == 0
    azi_Zm = 0 ;
elseif azi_Z == 0 && pol_Z == pi
    azi_Zm = 0 ;
else
    azi_Zm = mod(azi_Z+pi,2*pi) ;
end

% Orientation array for the faces
orientation = [pol_X azi_X ; pol_Xm azi_Xm ; pol_Y azi_Y ; pol_Ym azi_Ym ; pol_Z azi_Z ; pol_Zm azi_Zm] ;




