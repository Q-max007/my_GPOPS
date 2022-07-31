%---------------------------------------------------%
% Classical Brachistochrone Problem:                %
%---------------------------------------------------%
% The problem solved here is given as follows:      %
%   Minimize t_f                                    %
% subject to the dynamic constraints                %
%    dx/dt =  v*sin(u)                              %
%    dy/dt = -v*cos(u)                              %
%    dv/dt =  g*cos(u)                              %
% and the boundary conditions                       %
%    x(0) = 0, y(0) = 0, v(0) = 0                   %
%    x(t_f) = 2, y(t_f) = -2, v(t_f) = FREE         %
%---------------------------------------------------%

clear all; close all; clc

global CONSTANTS 

auxdata.g = 10;
t0 = 0; 
tfmin = 0; tfmax = 100;
x0 = 0; y0 = 0; v0 = 0;
xf = 2; yf = -2;
xmin = -50; xmax =  50;
ymin = -50; ymax =   0;
vmin = xmin; vmax = xmax;
umin = -pi/2; umax = pi/2;

%-------------------------------------------------------------------------%
%----------------------- Setup for Problem Bounds ------------------------%
%-------------------------------------------------------------------------%
iphase = 1;
bounds.phase.initialtime.lower = t0; 
bounds.phase.initialtime.upper = t0;
bounds.phase.finaltime.lower = tfmin; 
bounds.phase.finaltime.upper = tfmax;
bounds.phase.initialstate.lower = [x0,y0,v0]; 
bounds.phase.initialstate.upper = [x0,y0,v0]; 
bounds.phase.state.lower = [xmin,ymin,vmin]; 
bounds.phase.state.upper = [xmax,ymax,vmax]; 
bounds.phase.finalstate.lower = [xf,yf,vmin]; 
bounds.phase.finalstate.upper = [xf,yf,vmax]; 
bounds.phase.control.lower = umin; 
bounds.phase.control.upper = umax;

%-------------------------------------------------------------------------%
%---------------------- Provide Guess of Solution ------------------------%
%-------------------------------------------------------------------------%
guess.phase.time    = [t0; tfmax]; 
guess.phase.state   = [[x0; xf],[y0; yf],[v0; v0]];
guess.phase.control = [0; 0];

%-------------------------------------------------------------------------%
%------------- Assemble Information into Problem Structure ---------------%        
%-------------------------------------------------------------------------%
setup.name = 'Brachistochrone-Problem';
setup.functions.continuous = @brachistochroneContinuous;
setup.functions.endpoint = @brachistochroneEndpoint;
setup.auxdata = auxdata;
setup.bounds = bounds;
setup.guess = guess;
setup.nlp.solver = 'snopt';
setup.derivatives.supplier = 'sparseCD';
setup.derivatives.derivativelevel = 'second';
setup.mesh.method = 'hp1';
setup.mesh.tolerance = 1e-6;
setup.mesh.maxiteration = 45;
setup.mesh.colpointsmax = 4;
setup.mesh.colpointsmin = 10;
setup.mesh.phase.colpoints = 4*ones(1,10);
setup.mesh.phase.fraction =  0.1*ones(1,10);
setup.method = 'RPMintegration';

%-------------------------------------------------------------------------%
%------------------------- Solve Problem Using GPOP2 ---------------------%
%-------------------------------------------------------------------------%
output = gpops2(setup);
solution = output.result.solution;

%--------------------------------------------------------------------------%
%------------------------------- Plot Solution ----------------------------%
%--------------------------------------------------------------------------%
figure(1)
pp = plot(solution.phase(1).time,solution.phase(1).state,'-o');
xl = xlabel('time');
yl = ylabel('state');
set(pp,'LineWidth',1.25,'MarkerSize',8);
set(xl,'FontSize',18);
set(yl,'FontSize',18);
set(gca,'FontSize',16);
grid on
print -depsc2 brachistochroneState.eps
print -dpng brachistochroneState.png

figure(1)
pp = plot(solution.phase(1).time,solution.phase(1).control,'-o');
xl = xlabel('time');
yl = ylabel('control');
set(pp,'LineWidth',1.25,'MarkerSize',8);
set(xl,'FontSize',18);
set(yl,'FontSize',18);
set(gca,'FontSize',16);
grid on
print -depsc2 brachistochroneControl.eps
print -dpng brachistochroneControl.png

