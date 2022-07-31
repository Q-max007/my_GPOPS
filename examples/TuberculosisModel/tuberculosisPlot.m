%-------------------------------------------------------------------%
%-------------------------- Plot Solution --------------------------%
%-------------------------------------------------------------------%
time = solution.phase(1).time;
S    = solution.phase(1).state(:,1);
L1   = solution.phase(1).state(:,2);
L2   = solution.phase(1).state(:,3);
I1   = solution.phase(1).state(:,4);
I2   = solution.phase(1).state(:,5);
T    = solution.phase(1).state(:,6);
u1   = solution.phase(1).control(:,1);
u2   = solution.phase(1).control(:,2);

figure(1);
pp = plot(time,S/1000,'-o');
xl = xlabel('Time (s)');
yl = ylabel('S x 1000');
set(xl,'FontSize',18);
set(yl,'FontSize',18);
set(gca,'FontSize',16);
set(pp,'LineWidth',1.25);
grid on;
print -depsc2 tuberculosisS.eps

figure(2);
pp = plot(time,L1/1000,'-o');
xl = xlabel('Time (s)');
yl = ylabel('L1 x 1000');
set(xl,'FontSize',18);
set(yl,'FontSize',18);
set(gca,'FontSize',16);
set(pp,'LineWidth',1.25);
grid on;
print -depsc2 tuberculosisL1.eps

figure(3);
pp = plot(time,L2/1000,'-o');
xl = xlabel('Time (s)');
yl = ylabel('L2 x 1000');
set(xl,'FontSize',18);
set(yl,'FontSize',18);
set(gca,'FontSize',16);
set(pp,'LineWidth',1.25);
grid on;
print -depsc2 tuberculosisL2.eps

figure(4);
pp = plot(time,I1,'-o');
xl = xlabel('Time (s)');
yl = ylabel('I1');
set(xl,'FontSize',18);
set(yl,'FontSize',18);
set(gca,'FontSize',16);
set(pp,'LineWidth',1.25);
grid on;
print -depsc2 tuberculosisI1.eps

figure(5);
pp = plot(time,I2/1000,'-o');
xl = xlabel('Time (s)');
yl = ylabel('I2 x 1000');
set(xl,'FontSize',18);
set(yl,'FontSize',18);
set(gca,'FontSize',16);
set(pp,'LineWidth',1.25);
grid on;
print -depsc2 tuberculosisI2.eps

figure(6);
pp = plot(time,T,'-o');
xl = xlabel('Time (s)');
yl = ylabel('T');
set(xl,'FontSize',18);
set(yl,'FontSize',18);
set(gca,'FontSize',16);
set(pp,'LineWidth',1.25);
grid on;
print -depsc2 tuberculosisT.eps

figure(7);
pp = plot(time,u1,'-o');
xl = xlabel('Time (s)');
yl = ylabel('U1');
set(xl,'FontSize',18);
set(yl,'FontSize',18);
set(gca,'FontSize',16);
set(pp,'LineWidth',1.25);
grid on;
print -depsc2 tuberculosisU1.eps

figure(8);
pp = plot(time,u2,'-o');
xl = xlabel('Time (s)');
yl = ylabel('U2');
set(xl,'FontSize',18);
set(yl,'FontSize',18);
set(gca,'FontSize',16);
set(pp,'LineWidth',1.25);
grid on;
print -depsc2 tuberculosisU2.eps


