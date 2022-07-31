%close all
clear all
clc

%-------------------------------------%
%             Problem Setup           %
%-------------------------------------%
auxdata.Rm    = 3386200;                  % Equatorial Radius of Mars (m)
auxdata.gn    =3.71;                      % Mars Gravitational Parameter (m/s^2) 
auxdata.Lsp   =310;                       %(s)
% inital conditions
t0 = 0;
h0 = 1100;
L0 = 0;
Vr0 = 79.56;
Vn0 = 45.13;
m0=764.575;

% terminal conditions
hf=100;
Vrf=0;
Vnf=0;

%----------------------------------------------------%
% Lower and Upper Limits on Time, State, and Control %
%----------------------------------------------------%
tfMin = 0;            tfMax = 3000;
hMin  = 0;            hMax  = h0;
LMin  = 0;            LMax  = 10000;
VrMin = 0;             VrMax= 100;
VnMin= 0;            VnMax= 100;
mMin  = 0;            mMax  = m0;
TMin  = 1200;         TMax  = 7500;
thetaMin=-pi/2;       thetaMax=pi/2;

bounds.phase.initialtime.lower = t0;
bounds.phase.initialtime.upper = t0;
bounds.phase.finaltime.lower = tfMin;
bounds.phase.finaltime.upper = tfMax;
bounds.phase.initialstate.lower = [h0, L0, Vr0, Vn0, m0];
bounds.phase.initialstate.upper = [h0, L0, Vr0, Vn0, m0];
bounds.phase.state.lower = [hMin, LMin, VrMin, VnMin, mMin];
bounds.phase.state.upper = [hMax, LMax, VrMax, VnMax, mMax];
bounds.phase.finalstate.lower = [hf, LMin, Vrf, Vnf, mMin];
bounds.phase.finalstate.upper = [hf, LMax, Vrf, Vnf, mMax];
bounds.phase.control.lower = [TMin, thetaMin];
bounds.phase.control.upper = [TMax, thetaMax];

%----------------------%
% Set up Initial Guess %
%----------------------%
tGuess = [0;1000];
hGuess = [h0;hf];
LGuess = [L0;L0+100];
VrGuess= [Vr0;Vrf];
VnGuess= [Vn0;Vnf];
mGuess = [m0;500];
TGuess = [2000;5000];
thetaGuess=[0;0];

guess.phase.state   = [hGuess, LGuess, VrGuess, VnGuess, mGuess];
guess.phase.control = [TGuess, thetaGuess];
guess.phase.time    = tGuess;

%----------------------%
% Set up Initial mesh  %
%----------------------%

meshphase.colpoints = 4*ones(1,10);
meshphase.fraction = 0.1*ones(1,10);


%-------------------------------------------------------------------%
%---------- Configure Setup Using the information provided ---------%
%-------------------------------------------------------------------%

setup.name = 'Mars-Launch-Vehicle-Entry-Problem';
setup.functions.continuous = @rlvEntryContinuous;
setup.functions.endpoint   = @rlvEntryEndpoint;
setup.auxdata = auxdata;
setup.mesh.phase = meshphase;
setup.bounds = bounds;
setup.guess = guess;
setup.nlp.solver = 'ipopt';
setup.derivatives.supplier = 'sparseCD';
setup.derivatives.derivativelevel = 'second';
setup.scales.method = 'automatic-bounds';
%setup.method = 'RPMintegration';
setup.mesh.method = 'hp1';
setup.mesh.tolerance = 1e-6; % default 1e-3
setup.mesh.colpointsmin = 4;
setup.mesh.colpointsmax = 16;


%----------------------------------%
% Solve Problem Using OptimalPrime %
%----------------------------------%
output = gpops2(setup);
