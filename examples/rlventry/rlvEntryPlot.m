%------------------------------%
% Extract Solution from Output %
%------------------------------%
solution  = output.result.solution;
time      = solution.phase(1).time;
h         = solution.phase(1).state(:,1);
L         = solution.phase(1).state(:,2);
Vr        = solution.phase(1).state(:,3);
Vn        = solution.phase(1).state(:,4);
m         = solution.phase(1).state(:,5);
T         = solution.phase(1).control(:,1);
theta     = solution.phase(1).control(:,2)*180/pi;

%---------------%
% Plot Solution %
%---------------%
figure(1)
pp = plot(time,h ,'-o', 'markersize', 7, 'linewidth', 1.5);
xl = xlabel('Time (s)');
yl = ylabel('h (m)');
set(xl,'FontSize',18);
set(yl,'FontSize',18);
set(gca,'FontSize',16);
set(pp,'LineWidth',1.25);
grid on
print -depsc2 rlvh.eps
print -dpng rlvh.png

figure(2)
plot(time,L,'-o', 'markersize', 7, 'linewidth', 1.5);
xl = xlabel('Time (s)');
yl = ylabel('L (m)');
set(xl,'FontSize',18);
set(yl,'FontSize',18);
set(gca,'FontSize',16);
set(pp,'LineWidth',1.25);
grid on
print -depsc2 rlvL.eps
print -dpng rlvL.png

figure(3)
plot(time,Vr,'-o', 'markersize', 7, 'linewidth', 1.5);
xl = xlabel('Time (s)');
yl = ylabel('Vr (m/s)');
set(xl,'FontSize',18);
set(yl,'FontSize',18);
set(gca,'FontSize',16);
set(pp,'LineWidth',1.25);
grid on
print -depsc2 rlvVr.eps
print -dpng rlvVn.png

figure(4)
plot(time,Vn,'-o', 'markersize', 7, 'linewidth', 1.5);
yl = xlabel('Time (s)');
xl = ylabel('Vn (m/s)');
set(xl,'FontSize',18);
set(yl,'FontSize',18);
set(gca,'FontSize',16);
set(pp,'LineWidth',1.25);
grid on
print -depsc2 rlvVn.eps
print -dpng rlvVn.png

figure(5)
plot(time,m,'-o', 'markersize', 7, 'linewidth', 1.5);
yl = xlabel('Time (s)');
xl = ylabel('m (kg)');
set(xl,'FontSize',18);
set(yl,'FontSize',18);
set(gca,'FontSize',16);
set(pp,'LineWidth',1.25);
grid on
print -depsc2 rlvm.eps
print -dpng rlvm.png

figure(6)
plot(time,T,'-o', 'markersize', 7, 'linewidth', 1.5);
yl = xlabel('Time (s)');
xl = ylabel('T (deg)');
set(xl,'FontSize',18);
set(yl,'FontSize',18);
set(gca,'FontSize',16);
set(pp,'LineWidth',1.25);
grid on
print -depsc2 rlvT.eps
print -dpng rlvT.png

figure(7)
plot(time,theta,'-o', 'markersize', 7, 'linewidth', 1.5);
yl = xlabel('Time (s)');
xl = ylabel('theta (deg)');
set(xl,'FontSize',18);
set(yl,'FontSize',18);
set(gca,'FontSize',16);
set(pp,'LineWidth',1.25);
grid on
print -depsc2 rlvtheta.eps
print -dpng rlvtheta.png

for i=1:length(output.meshhistory)
  mesh(i).cumfraction = [0 cumsum(output.meshhistory(i).phase.fraction)];
  mesh(i).sizecumfraction = i*ones(size(mesh(i).cumfraction));
end
marks = {'bd','gs','r^','cv','mo','kh'};


