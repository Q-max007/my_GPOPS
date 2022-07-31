marks = {'-bd','-gs','-r^','-cv','-mo','-kh'};
% Extract the time in each phase of the problem.
time{1} = solution.phase(1).time;
time{2} = solution.phase(2).time;
time{3} = solution.phase(3).time;
timeRadau{1} = solution.phase(1).timeRadau;
timeRadau{2} = solution.phase(2).timeRadau;
timeRadau{3} = solution.phase(3).timeRadau;
for iphase=1:3
  y{iphase} = solution.phase(iphase).state;
  u{iphase} = solution.phase(iphase).control;
  uRadau{iphase} = solution.phase(iphase).controlRadau;
end;
nstates = 6;
ncontrols = 5;
for istate = 1:nstates
  stateString = strcat('Y',num2str(istate));
  figure(istate);
  pp = plot(time{1},y{1}(:,istate),marks{1},time{2},y{2}(:,istate),marks{2},time{3},y{3}(:,istate),marks{3});
  xl = xlabel('time (hours)');
  yl = ylabel(stateString);
  ll = legend('Phase 1','Phase 2','Phase 3','Location','Best');
  set(pp,'LineWidth',1.25,'MarkerSize',8);
  set(xl,'FontSize',18);
  set(yl,'FontSize',18);
  set(ll,'FontSize',18);
  set(gca,'FontSize',16);
  grid on;
  filename = strcat([,'kineticBatchReactor',stateString,'.png']);
  print('-dpng',filename);
end;

for icontrol = 1:ncontrols
  stateString = strcat('U',num2str(icontrol));
  figure(icontrol+nstates);
  pp = plot(timeRadau{1},uRadau{1}(:,icontrol),marks{1},timeRadau{2},uRadau{2}(:,icontrol),marks{2},timeRadau{3},uRadau{3}(:,icontrol),marks{3});
  xl = xlabel('time (hours)');
  yl = ylabel(stateString);
  ll = legend('Phase 1','Phase 2','Phase 3','Location','Best');
  set(pp,'LineWidth',1.25,'MarkerSize',8);
  set(xl,'FontSize',18);
  set(yl,'FontSize',18);
  set(ll,'FontSize',18);
  set(gca,'FontSize',16);
  grid on;
  filename = strcat([,'kineticBatchReactor',stateString,'.png']);
  print('-dpng',filename);
end;
