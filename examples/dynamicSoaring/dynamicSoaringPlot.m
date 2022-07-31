t = solution.phase(1).time;
x = solution.phase(1).state(:,1);
y = solution.phase(1).state(:,2);
z = solution.phase(1).state(:,3);
v = solution.phase(1).state(:,4);
gamma = solution.phase(1).state(:,5);
psi = solution.phase(1).state(:,6);
CL = solution.phase(1).control(:,1);
bank = solution.phase(1).control(:,2);
figure(1);
pp = plot3(x,y,z,'-o');
xl = xlabel('X (ft)');
yl = ylabel('Y (ft)');
zl = zlabel('Altitude (ft)');
set(xl,'FontSize',18);
set(yl,'FontSize',18);
set(zl,'FontSize',18);
set(gca,'FontSize',16);
set(pp,'LineWidth',1.25);
grid on;
print -depsc2 dynamicSoaringxyh.eps
print -dpng dynamicSoaringxyh.png

figure(2);
pp = plot(t,v,'-o');
xl = xlabel('Time (s)');
yl = ylabel('Speed (ft/s)');
set(xl,'FontSize',18);
set(yl,'FontSize',18);
set(gca,'FontSize',16,'YTick',40:40:240);
set(pp,'LineWidth',1.25);
grid on;
print -depsc2 dynamicSoaringSpeed.eps
print -dpng dynamicSoaringSpeed.png

figure(3);
pp = plot(t,gamma*180/pi,'-o');
xl = xlabel('Time (s)');
yl = ylabel('Flight Path Angle (deg)');
set(xl,'FontSize',18);
set(yl,'FontSize',18);
set(gca,'FontSize',16);
set(pp,'LineWidth',1.25);
grid on;
print -depsc2 dynamicSoaringFlightPathAngle.eps
print -dpng dynamicSoaringFlightPathAngle.png

figure(4);
pp = plot(t,psi*180/pi,'-o');
xl = xlabel('Time (s)');
yl = ylabel('Azimuth (deg)');
set(xl,'FontSize',18);
set(yl,'FontSize',18);
set(gca,'FontSize',16);
set(pp,'LineWidth',1.25);
grid on;
print -depsc2 dynamicSoaringAzimuth.eps
print -dpng dynamicSoaringAzimuth.png

figure(5);
pp = plot(t,CL,'-o');
xl = xlabel('Time (s)');
yl = ylabel('CL (dimensionless)');
set(xl,'FontSize',18);
set(yl,'FontSize',18);
set(gca,'FontSize',16);
set(pp,'LineWidth',1.25);
grid on;
print -depsc2 dynamicSoaringCL.eps
print -dpng dynamicSoaringCL.png

figure(6);
pp = plot(t,bank*180/pi,'-o');
xl = xlabel('Time (s)');
yl = ylabel('Bank Angle (deg)');
set(xl,'FontSize',18);
set(yl,'FontSize',18);
set(gca,'FontSize',16);
set(pp,'LineWidth',1.25);
grid on;
print -depsc2 dynamicSoaringBankAngle.eps
print -dpng dynamicSoaringBankAngle.png
