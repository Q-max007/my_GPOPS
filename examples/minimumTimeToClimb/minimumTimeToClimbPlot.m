%-------------------------------------------------------------------%
%---------------------------- Plot Solution ------------------------%
%-------------------------------------------------------------------%
solution        = output.result.solution;
time            = solution.phase(1).time;
altitude        = solution.phase(1).state(:,1);
speed           = solution.phase(1).state(:,2);
flightPathAngle = solution.phase(1).state(:,3)*180/pi;
mass            = solution.phase(1).state(:,4);
angleofAttack   = solution.phase(1).control*180/pi;
density         = interp1(us1976(:,1),us1976(:,2),altitude,'spline');
speedofSound    = interp1(us1976(:,1),us1976(:,3),altitude,'spline');
machNumber      = speed./speedofSound;
for i=1:length(output.meshhistory);
  mesh(i).points = [0 cumsum(output.meshhistory(i).result.setup.mesh.phase.fraction)];
  mesh(i).iteration = i*ones(size(mesh(i).points));
end;

figure(1);
pp = plot(time,altitude/1000,'-o');
xl = xlabel('Time (s)');
yl = ylabel('Altitude (km)');
set(xl,'FontSize',18);
set(yl,'FontSize',18);
set(gca,'FontSize',16);
set(pp,'LineWidth',1.25);
grid on;
print -depsc2 minimumTimeToClimbAltitude.eps
print -dpng minimumTimeToClimbAltitude.png

figure(2);
pp = plot(speed/1000,altitude/1000,'-o');
xl = xlabel('Speed (km/s)');
yl = ylabel('Altitude (km)');
set(xl,'FontSize',18);
set(yl,'FontSize',18);
set(gca,'FontSize',16);
set(pp,'LineWidth',1.25);
grid on;
print -depsc2 minimumTimeToClimbAltitudevsSpeed.eps
print -dpng minimumTimeToClimbAltitudevsSpeed.png

figure(3);
pp = plot(time,flightPathAngle,'-o');
xl = xlabel('Time (s)');
yl = ylabel('Flight Path Angle (deg)');
set(xl,'FontSize',18);
set(yl,'FontSize',18);
set(gca,'FontSize',16);
set(pp,'LineWidth',1.25);
grid on;
print -depsc2 minimumTimeToClimbFlightPathAngle.eps
print -dpng minimumTimeToClimbFlightPathAngle.png

figure(4);
pp = plot(time,mass/1000,'-o');
xl = xlabel('Time (s)');
yl = ylabel('Mass (kg) x 1000');
set(xl,'FontSize',18);
set(yl,'FontSize',18);
set(gca,'FontSize',16);
set(pp,'LineWidth',1.25);
grid on;
print -depsc2 minimumTimeToClimbMass.eps
print -dpng minimumTimeToClimbMass.png

figure(5);
pp = plot(time,angleofAttack,'-o');
xl = xlabel('Time (s)');
yl = ylabel('Angle of Attack (deg)');
set(xl,'FontSize',18);
set(yl,'FontSize',18);
set(gca,'FontSize',16);
set(pp,'LineWidth',1.25);
grid on;
print -depsc2 minimumTimeToClimbAngleofAttack.eps
print -dpng minimumTimeToClimbAngleofAttack.png

figure(6);
for i=1:length(mesh);
  pp = plot(mesh(i).points,mesh(i).iteration,'bo');
  set(pp,'LineWidth',1.25);
  hold on;
end;
xl = xlabel('Mesh Point Location (Fraction of Interval)');
yl = ylabel('Mesh Iteration');
set(xl,'Fontsize',18);
set(yl,'Fontsize',18);
set(gca,'YTick',0:length(mesh),'FontSize',16);
grid on;
print -depsc2 minimumTimeToClimbMeshRefinement.eps
print -dpng minimumTimeToClimbMeshRefinement.png
