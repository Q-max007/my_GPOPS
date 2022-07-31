%-------------------------------------------------------------------------%
%                             Extract Solution                            %
%-------------------------------------------------------------------------%
solution = output.result.solution;
time = solution.phase(1).time;
state = solution.phase(1).state;
control = solution.phase(1).control;
for i=1:length(output.meshhistory);
  mesh(i).points = [0 cumsum(output.meshhistory(i).phase.fraction)];
  mesh(i).iteration = i*ones(size(mesh(i).points));
end;

%-------------------------------------------------------------------------%
%                              Plot Solution                              %
%-------------------------------------------------------------------------%
figure(1);
pp = plot(time,state,'-o');
xl = xlabel('time');
yl = ylabel('state');
set(xl,'Fontsize',18);
set(yl,'Fontsize',18);
set(gca,'Fontsize',16);
set(pp,'LineWidth',1.25);
grid on
print -depsc2 hyperSensitiveState.eps
print -dpng hyperSensitiveState.png

figure(2);
pp = plot(time,control,'-o');
xl = xlabel('time');
yl = ylabel('control');
set(xl,'Fontsize',18);
set(yl,'Fontsize',18);
set(gca,'Fontsize',16);
set(pp,'LineWidth',1.25);
grid on
print -depsc2 hyperSensitiveControl.eps
print -dpng hyperSensitiveControl.png

figure(3);
for i=1:length(mesh);
  pp = plot(mesh(i).points*tf,mesh(i).iteration,'bo');
  set(pp,'LineWidth',1.25);
  hold on;
end;
xl = xlabel('Mesh Point Location (Fraction of Interval)');
yl = ylabel('Mesh Iteration');
set(xl,'Fontsize',18);
set(yl,'Fontsize',18);
set(gca,'YTick',0:length(mesh),'FontSize',16);
grid on;
print -depsc2 hyperSensitiveMeshRefinement.eps
print -dpng hyperSensitiveMeshRefinement.png
