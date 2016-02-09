clear all
set(0, 'DefaultAxesFontSize', 16);
set(0, 'DefaultLineLineWidth', 2);
xdata=linspace(0,180,300);
ydata=0.25*(2+cosd(xdata)).*(1-cosd(xdata)).^2;
fig = figure('Visible','on',...
'PaperPosition',[0 0 5 4],...
'PaperSize',[5 4]);

plot(xdata,ydata);
xlabel('\theta (degrees)')
ylabel('S(\theta)')
xlim([0 180])
print(gcf,'-depsc2','../316-2_figures/stheta.eps')