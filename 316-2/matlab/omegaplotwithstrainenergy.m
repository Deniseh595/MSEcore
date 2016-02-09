clear all
set(0, 'DefaultAxesFontSize', 16);
set(0, 'DefaultLineLineWidth', 2);
xdata=linspace(70,80,100);
ydata=1e33*exp(-xdata);
fig = figure('Visible','on',...
'PaperPosition',[0 0 5 5],...
'PaperSize',[5 5]);

plot(xdata,ydata);
xlabel('W_{R}^{*}/k_{B}T')
ylabel('N_v (cm^{-3}s^{-1})')
print(gcf,'-depsc2','../316-2_figures/nvplot.eps')