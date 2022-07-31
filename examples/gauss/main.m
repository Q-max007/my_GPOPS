% ----------- Reusable Launch Vehicle Entry Example ------------%
% This example is taken verbatim from the following reference: %
% Betts, J. T., Practical Methods for Optimal Control Using %
% Nonlinear Programming, SIAM Press, Philadelphia, 2009. %
% --------------------------------------------------------------%
%close all
clear all
clc
cft2m = 0.3048;
cft2km = cft2m/1000;
cslug2kg = 14.5939029;
%-------------------------------------------------------------------------%
%------------------ Provide Auxiliary Data for Problem -------------------%
%-------------------------------------------------------------------------%
auxdata.Re = 6371203.92; % Equatorial Radius of Earth (m)
auxdata.S = 249.9091776; % Vehicle Reference Area (mˆ2)
auxdata.cl = [-0.2070 1.6756]; % Parameters for Lift Coefficient
auxdata.cd = [0.0785 -0.3529 2.0400]; % Parameters for Drag Coefficient
auxdata.b = [0.07854 -0.061592 0.00621408]; % Parameters for Heat Rate Model
auxdata.H = 7254.24; % Density Scale Height (m)
auxdata.al = [-0.20704 0.029244]; % Parameters for Heat Rate Model
auxdata.rho0 = 1.225570827014494; % Sea Level Atmospheric Density (kg/mˆ3)
auxdata.mu = 3.986031954093051e14; % Earth Gravitational Parameter (mˆ3/sˆ2)
auxdata.mass = 92079.2525560557; % Vehicle Mass (kg)

%-------------------------------------------------------------------%
%----------------------- Boundary Conditions -----------------------%
%-------------------------------------------------------------------%
t0 = 0;
alt0 = 79248;
rad0 = alt0+auxdata.Re;
altf = +24384;
radf = altf+auxdata.Re;
lon0 = 0;
lat0 = 0;
speed0 = +7802.88;
speedf = +762;
fpa0 = -1*pi/180;
fpaf = -5*pi/180;
azi0 = +90*pi/180;
azif = -90*pi/180;
%-------------------------------------------------------------------%
%----------------------- Limits on Variables -----------------------%
%-------------------------------------------------------------------%
tfMin = 0; tfMax = 3000;
radMin = auxdata.Re; radMax = rad0;
lonMin = -pi; lonMax = -lonMin;
latMin = -70*pi/180; latMax = -latMin;
speedMin = 10; speedMax = 45000;
fpaMin = -80*pi/180; fpaMax = 80*pi/180;
aziMin = -180*pi/180; aziMax = 180*pi/180;
aoaMin = -90*pi/180; aoaMax = -aoaMin;
bankMin = -90*pi/180; bankMax = 1*pi/180;
%-------------------------------------------------------------------%
%--------------- Set Up Problem Using Data Provided Above ----------%
%-------------------------------------------------------------------%
bounds.phase.initialtime.lower = t0;
bounds.phase.initialtime.upper = t0;
bounds.phase.finaltime.lower = tfMin;
bounds.phase.finaltime.upper = tfMax;
bounds.phase.initialstate.lower = [rad0, lon0, lat0, speed0, fpa0, azi0];
bounds.phase.initialstate.upper = [rad0, lon0, lat0, speed0, fpa0, azi0];
bounds.phase.state.lower = [radMin, lonMin, latMin, speedMin, fpaMin, aziMin];
bounds.phase.state.upper = [radMax, lonMax, latMax, speedMax, fpaMax, aziMax];
bounds.phase.finalstate.lower = [radf, lonMin, latMin, speedf, fpaf, aziMin];
bounds.phase.finalstate.upper = [radf, lonMax, latMax, speedf, fpaf, aziMax];
bounds.phase.control.lower = [aoaMin, bankMin];
bounds.phase.control.upper = [aoaMax, bankMax];
%-------------------------------------------------------------------------%
%---------------------- Provide Guess of Solution ------------------------%
%-------------------------------------------------------------------------%
tGuess = [0; 1000];
radGuess = [rad0; radf];
lonGuess = [lon0; lon0+10*pi/180];
latGuess = [lat0; lat0+10*pi/180];
speedGuess = [speed0; speedf];
fpaGuess = [fpa0; fpaf];
aziGuess = [azi0; azif];
aoaGuess = [0; 0];
bankGuess = [0; 0];
guess.phase.state = [radGuess, lonGuess, latGuess, speedGuess, fpaGuess, aziGuess];
guess.phase.control = [aoaGuess, bankGuess];
guess.phase.time = tGuess;
%-------------------------------------------------------------------------%
%----------Provide Mesh Refinement Method and Initial Mesh ---------------%
%-------------------------------------------------------------------------%
mesh.method = 'hp-LiuRao-Legendre';
mesh.maxiterations = 2;


mesh.colpointsmin = 3;
mesh.colpointsmax = 20;
mesh.tolerance = 1e-7;
%-------------------------------------------------------------------%
%---------- Configure Setup Using the information provided ---------%
%-------------------------------------------------------------------%
setup.name = 'Reusable-Launch-Vehicle-Entry-Problem';
setup.functions.continuous = @rlvEntryContinuous;
setup.functions.endpoint = @rlvEntryEndpoint;
setup.auxdata = auxdata;
setup.bounds = bounds;
setup.guess = guess;
setup.mesh = mesh;
setup.displaylevel = 2;
setup.nlp.solver = 'ipopt';
setup.nlp.ipoptoptions.linear_solver = 'ma57';
setup.derivatives.supplier = 'adigator';
setup.derivatives.derivativelevel = 'second';
setup.scales.method = 'automatic-bounds';
setup.method = 'RPM-Differentiation';
%-------------------------------------------------------------------%
%------------------- Solve Problem Using GPOPS2 --------------------%
%-------------------------------------------------------------------%
output = gpops2(setup);
function phaseout = rlvEntryContinuous(input)
% ---------------------------------------------------%
% ------ Extract Each Component of the State ------- %
% ---------------------------------------------------%
rad = input.phase.state(:,1);
lon = input.phase.state(:,2);
lat = input.phase.state(:,3);
v = input.phase.state(:,4);
fpa = input.phase.state(:,5);
azi = input.phase.state(:,6);
aoa = input.phase.control(:,1);
bank = input.phase.control(:,2);
% ---------------------------------------------------%
% ------- Compute the Aerodynamic Quantities --------%
% ---------------------------------------------------%
cd0 = input.auxdata.cd(1);
cd1 = input.auxdata.cd(2);
cd2 = input.auxdata.cd(3);
cl0 = input.auxdata.cl(1);
cl1 = input.auxdata.cl(2);
mu = input.auxdata.mu;
rho0 = input.auxdata.rho0;
H = input.auxdata.H;
S = input.auxdata.S;
mass = input.auxdata.mass;
altitude = rad - input.auxdata.Re;
CD = cd0+cd1*aoa+cd2*aoa.ˆ2;
rho = rho0*exp(-altitude/H);
CL = cl0+cl1*aoa;
q = 0.5*rho.*v.ˆ2;
D = q.*S.*CD./mass;
L = q.*S.*CL./mass;
gravity = mu./rad.ˆ2;
% ---------------------------------------------------%
% ---- Evaluate Right-Hand Side of the Dynamics -----%
% ---------------------------------------------------%
raddot = v.*sin(fpa);
londot = v.*cos(fpa).*sin(azi)./(rad.*cos(lat));
latdot = v.*cos(fpa).*cos(azi)./rad;
vdot = -D-gravity.*sin(fpa);
fpadot = (L.*cos(bank)-cos(fpa).*(gravity-v.ˆ2./rad))./v;
azidot = (L.*sin(bank)./cos(fpa)+v.ˆ2.*cos(fpa).*sin(azi).*tan(lat)./rad)./v;
phaseout.dynamics = [raddot, londot, latdot, vdot, fpadot, azidot];
function output = rlvEntryEndpoint(input)
% Inputs
% input.phase(phasenumber).initialstate -- row
% input.phase(phasenumber).finalstate -- row
% input.phase(phasenumber).initialtime -- scalar
% input.phase(phasenumber).finaltime -- scalar
% input.phase(phasenumber).integral -- row
%
% input.parameter -- row
% input.auxdata = auxiliary information
% Output
% output.objective -- scalar
% output.eventgroup(eventnumber).event -- row
latf = input.phase.finalstate(3);
% cost
output.objective = -latf;



