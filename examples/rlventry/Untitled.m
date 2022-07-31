figure(8);
pp = plot(mesh(1).cumfraction,mesh(1).sizecumfraction,marks{1},mesh(2).cumfraction,mesh(2).sizecumfraction,marks{2},mesh(3).cumfraction,mesh(3).sizecumfraction,marks{3});
yl = xlabel('Location of Mesh Points (Percent)');
xl = ylabel('Mesh Refinement Iteration Number');
set(xl,'FontSize',18);
set(yl,'FontSize',18);
set(gca,'FontSize',16);
set(gca,'YTick',0:1:length(output.meshhistory));
axis([0 1 0 3]);
grid on
print -depsc2 rlvMeshHistory.png
print -dpng rlvMeshHistory.png