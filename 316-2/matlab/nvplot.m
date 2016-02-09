clear all
close all
set(0, 'DefaultAxesFontSize', 16);
set(0, 'DefaultLineLineWidth', 2);
set(0, 'DefaultFigurePaperposition',[0 0 5 5])
set(0, 'DefaultFigurePaperSize',[5 5])
xdata=linspace(70,80,100);
ydata=1e33*exp(-xdata);
semilogy(xdata,ydata);
xlabel('W_{R}^{*}/k_{B}T')
ylabel('N_v (cm^{-3}s^{-1})')
print(gcf,'-depsc2','nvplot.eps')