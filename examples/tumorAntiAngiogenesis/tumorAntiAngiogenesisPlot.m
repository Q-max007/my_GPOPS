%-------------------------------------------------------------------%
%--------------------------- Plot Solution -------------------------%
%-------------------------------------------------------------------%
for i=1:length(output.meshhistory);
  mesh(i).points = [0 cumsum(output.meshhistory(i).result.setup.mesh.phase.fraction)];
  mesh(i).iteration = i*ones(size(mesh(i).points));
end;

figure(1);
pp = plot(solution.phase(1).time,solution.phase(1).state,'-d');
xl = xlabel('time');
yl = ylabel('state');
set(xl,'FontSize',18);
set(yl,'FontSize',18);
set(gca,'FontSize',16);
set(pp,'LineWidth',1.25,'MarkerSize',8);
grid on;
print -depsc2 tumorAntiAngiogenesisState.eps
print -dpng tumorAntiAngiogenesisState.png

figure(2);
pp = plot(solution.phase(1).time,solution.phase(1).control,'-o');
xl = xlabel('time');
yl = ylabel('control');
set(xl,'FontSize',18);
set(yl,'FontSize',18);
set(gca,'FontSize',16);
set(pp,'LineWidth',1.25,'MarkerSize',8);
grid on;
print -depsc2 tumorAntiAngiogenesisControl.eps
print -dpng tumorAntiAngiogenesisControl.png

figure(3);
pp = plot(solution.phase(1).time,solution.phase(1).costate,'-o');
xl = xlabel('time');
yl = ylabel('costate');
set(xl,'FontSize',18);
set(yl,'FontSize',18);
set(gca,'FontSize',16);
set(pp,'LineWidth',1.25);
grid on;
print -depsc2 tumorAntiAngiogenesisCostate.eps
print -dpng tumorAntiAngiogenesisConstate.png

figure(4);
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
print -depsc2 tumorAntiAngiogenesisMeshRefinement.eps
print -dpng tumorAntiAngiogenesisMeshRefinement.png
