%------------------------- Bryson-Denham Problem -------------------------%
% This problem is taken from the following reference:                     %
% Bryson, A. E. and Ho, Y-C, "Applied Optimal Control:  Optimization,     %
% Estimation, and Control," Hemisphere Publishing, 1975.                  %
%-------------------------------------------------------------------------%
clear all
close all
clc

setup.name = 'BrysonDenham';

setup.functions.continuous = @BrysonDenhamContinuous;
setup.functions.endpoint = @BrysonDenhamEvents;

setup.nlp.solver = 'snopt';
setup.derivatives.supplier = 'sparseCD';
setup.derivatives.derivativelevel = 'second';
%setup.scales.method = 'automatic-bounds';

setup.method = 'RPMintegration';

setup.mesh.method = 'hp';
setup.mesh.tolerance = 1e-6; % default 1e-3

N = 1;
setup.mesh.phase.colpoints = 4*ones(1,N);
setup.mesh.phase.fraction   = ones(1,N)/N;

%--Problem Setup--
%state 1
x10 = 0;
x1f = 0;
x1min = 0;
x1max = 1/9;

%state 2
x20 = 1;
x2f = -1;
x2min = -10;
x2max = 10;

%state 3
x30 = 0;
x3min = -10;
x3max = 10;

%control
umin = -10;
umax = 5;

%time
t0 = 0;
tmax = 50;

%--Initial Guess--
x1_guess = [x10; x1f];
x2_guess = [x20; x2f];
x3_guess = [x30; x3max];

u_guess = [-10; 0];

t_guess = [t0; tmax];

%--Bounds & Guess--
%--State, Control, Time--
setup.bounds.phase.initialstate.lower = [x10, x20, x30];
setup.bounds.phase.initialstate.upper = [x10, x20, x30];
setup.bounds.phase.state.lower = [x1min, x2min, x3min];
setup.bounds.phase.state.upper = [x1max, x2max, x3max];
setup.bounds.phase.finalstate.lower = [x1f, x2f, x3min];
setup.bounds.phase.finalstate.upper = [x1f, x2f, x3max];

setup.bounds.phase.control.lower = [umin];
setup.bounds.phase.control.upper = [umax];

setup.bounds.phase.initialtime.lower = t0;
setup.bounds.phase.initialtime.upper = t0;

setup.bounds.phase.finaltime.lower = t0;
setup.bounds.phase.finaltime.upper = tmax;

%--No Path Constraints--

%--Guess--
setup.guess.phase(1).state = [x1_guess, x2_guess, x3_guess];
setup.guess.phase(1).control = u_guess;
setup.guess.phase(1).time = t_guess;

%setup.auxdata = 10;


%--Call the Solver--
output = gpops2(setup);

solution = output.result.solution;

figure(1)
plot(solution.phase(1).time,solution.phase(1).state,'-o', 'markersize', 7, 'linewidth', 1.5);
grid on

figure(2)
plot(solution.phase(1).time,solution.phase(1).control,'-o', 'markersize', 7, 'linewidth', 1.5);
grid on

figure(3)
plot(solution.phase(1).time,solution.phase(1).costate,'-o', 'markersize', 7, 'linewidth', 1.5);
grid on