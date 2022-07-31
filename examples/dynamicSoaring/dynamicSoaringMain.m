%------------------- Dynamic Soaring Problem -----------------------------%
% This example is taken from the following reference:                     %
% Zhao, Y. J., "Optimal Pattern of Glider Dynamic Soaring," Optimal       %
% Control Applications and Methods, Vol. 25, 2004, pp. 67-89.             %
%-------------------------------------------------------------------------%
clear all
clc

auxdata.rho=0.002378;
auxdata.CD0 = 0.00873; 
auxdata.K= 0.045;
auxdata.g=32.2;
auxdata.m=5.6;
auxdata.S=45.09703;
auxdata.mu = 3.986e14;

auxdata.mgos=auxdata.m*auxdata.g/auxdata.S;
auxdata.Emax=(1/(4*auxdata.K*auxdata.CD0))^0.5;
auxdata.W0=0;
auxdata.lmin = -2;
auxdata.lmax = 5;

x0 = 0;
y0 = 0;
z0 = 0;
r0 = 0;
rf = 0;
v0=100;
v0=100;

xmin     = -1000;
xmax     = +1000;
ymin     = -1000;
ymax     = +1000;
zmin     =  0;
zmax     = +1000;
vmin     = +10;
vmax     = +350;
gammamin = -75*pi/180;
gammamax =  75*pi/180;
psimin   = -3*pi;
psimax   = +pi/2;
betamin  = 0.005;
betamax  = 0.15;
CLmin    = -0.5;
CLmax    = 1.5;
Phimin   = -75/180*pi;
Phimax   =  75/180*pi;
t0       = 0;
tfmin    = 1;
tfmax    = 30;

% Phase 1 Information
iphase = 1;
bounds.phase(iphase).initialtime.lower  = t0;
bounds.phase(iphase).initialtime.upper  = t0;
bounds.phase(iphase).finaltime.lower    = tfmin;
bounds.phase(iphase).finaltime.upper    = tfmax;
bounds.phase(iphase).initialstate.lower = [x0, y0, z0, vmin, gammamin, psimin];
bounds.phase(iphase).initialstate.upper = [x0, y0, z0, vmax, gammamax, psimax];
bounds.phase(iphase).state.lower        = [xmin, ymin, zmin, vmin, gammamin, psimin];
bounds.phase(iphase).state.upper        = [xmax, ymax, zmax, vmax, gammamax, psimax];
bounds.phase(iphase).finalstate.lower   = [x0, y0, z0, vmin, gammamin, psimin];
bounds.phase(iphase).finalstate.upper   = [x0, y0, z0, vmax, gammamax, psimax];
bounds.phase(iphase).control.lower      = [CLmin, Phimin];
bounds.phase(iphase).control.upper      = [CLmax, Phimax];
bounds.phase(iphase).path.lower         = auxdata.lmin;
bounds.phase(iphase).path.upper         = auxdata.lmax;
bounds.eventgroup(1).lower              = zeros(1,3);
bounds.eventgroup(1).upper              = zeros(1,3);
bounds.parameter.lower                  = betamin;
bounds.parameter.upper                  = betamax;

N                           = 100;
CL0                         = CLmax;
basetime                    = linspace(0,24,N).';
xguess                      = 500*cos(2*pi*basetime/24)-500;
yguess                      = 300*sin(2*pi*basetime/24);
zguess                      = -400*cos(2*pi*basetime/24)+400;
vguess                      = 0.8*v0*(1.5+cos(2*pi*basetime/24));
gammaguess                  = pi/6*sin(2*pi*basetime/24);
psiguess                    = -1-basetime/4;
CLguess                     = CL0*ones(N,1)/3;
phiguess                    = -ones(N,1);
betaguess                   = 0.08;
guess.phase(iphase).time    = [basetime];
guess.phase(iphase).state   = [xguess, yguess, zguess, vguess, gammaguess, psiguess];
guess.phase(iphase).control = [CLguess, phiguess];
guess.parameter             = [betaguess];

setup.name                             = 'Dynamic-Soaring-Problem';
setup.functions.continuous             = @dynamicSoaringContinuous;
setup.functions.endpoint               = @dynamicSoaringEndpoint;
setup.nlp.solver                       = 'snopt';
setup.bounds                           = bounds;
setup.guess                            = guess;
setup.auxdata                          = auxdata;
setup.derivatives.supplier             = 'sparseCD';
setup.derivatives.derivativelevel      = 'second';
setup.scales.method                    = 'automatic-bounds';
%setup.method = 'RPMintegration';
setup.mesh.method            = 'hp1';
setup.mesh.tolerance = 1e-6;

output = gpops2(setup);
solution = output.result.solution;
