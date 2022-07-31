%----------------------- Moon-Lander Problem -----------------------------%
% This example can be found in the following reference:                   %
% Meditch, J., "On the Problem of Optimal Thrust Programming for a Soft   %
% Lunar Landing," IEEE Transactions on Automatic Control, Vol. 9,% No. 4, %
% 1964, pp. 477-484.                                                      %
%-------------------------------------------------------------------------%


clear all
close all
clc


% OptimalPrime setup
setup.name = 'moonlander';

setup.functions.endpoint   = @moonlanderEndpoint;
setup.functions.continuous = @moonlanderContinuous;

setup.nlp.solver = 'ipopt';
setup.derivatives.supplier = 'sparseCD';
setup.derivatives.derivativelevel = 'second';
setup.scales.method = 'automatic-bounds';

setup.method = 'RPMintegration';

setup.mesh.method = 'hp';
setup.mesh.tolerance = 1e-9; % default 1e-3

N = 1;
setup.mesh.phase.colpoints = 10*ones(1,N);
setup.mesh.phase.fraction   = ones(1,N)/N;

% Problem Setup ----------------------
%-------------------------------------
h0 = 10;
hf = 0;
v0 = -2;
vf = 0;

%state1
hmin = 0;
hmax =  20;

%state2
vmin = -10;
vmax =  10;

%control1
umin = 0;
umax = 3;

%time
t0min = 0;
t0max = 0;
tfmin = 0;
tfmax = 200;

% Initial guess-------
h_guess = [h0; hf];
v_guess = [v0; vf];

u_guess = [umin; umin];

t_guess = [t0min; 5];


% bounds and guess --------------------------------------------------------
% state, control, time------------
setup.bounds.phase.initialstate.lower = [h0, v0];
setup.bounds.phase.initialstate.upper = [h0, v0];
setup.bounds.phase.state.lower = [hmin, vmin];
setup.bounds.phase.state.upper = [hmax, vmax];
setup.bounds.phase.finalstate.lower = [hf, vf];
setup.bounds.phase.finalstate.upper = [hf, vf];

setup.bounds.phase.control.lower = [umin];
setup.bounds.phase.control.upper = [umax];

setup.bounds.phase.integral.lower = [-100];
setup.bounds.phase.integral.upper = [100];

setup.bounds.phase.initialtime.lower = t0min;
setup.bounds.phase.initialtime.upper = t0max;

setup.bounds.phase.finaltime.lower = tfmin;
setup.bounds.phase.finaltime.upper = tfmax;

% Guess ----------------------------
setup.guess.phase.state   = [h_guess, v_guess];
setup.guess.phase.control = [u_guess];
setup.guess.phase.time    = [t_guess];
setup.guess.phase.integral = 10;

setup.auxdata.g = 1.6;

% Call Solver, Optimal Prime -------
%-----------------------------------
output = gpops2(setup);
%-----------------------------------
solution = output.result.solution;

figure(1)
plot(solution.phase.time, solution.phase.state,'-o', 'markersize', 7, 'linewidth', 1.5);
grid on

figure(2)
plot(solution.phase.time, solution.phase.control,'-o', 'markersize', 7, 'linewidth', 1.5);
grid on

figure(3)
plot(solution.phase.time, solution.phase.costate,'-o', 'markersize', 7, 'linewidth', 1.5);
grid on

