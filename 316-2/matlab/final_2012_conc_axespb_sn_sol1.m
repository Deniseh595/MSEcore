clear all
close all
size=[6 3];
set(0, 'DefaultAxesFontSize', 16);
set(0, 'DefaultLineLineWidth', 2);
set(0, 'DefaultFigurePaperposition',[0 0 size])
set(0, 'DefaultFigurePaperSize',size)
set(0, 'DefaultTextFontSize',16)
xlim([0 1])
xdata=linspace(0,1,100);
ydata=abs(xdata>0.5).*(0.95+0.01*exp(-6*(xdata-0.5)));
plot(xdata, ydata, 'r--');
set(gca,'xtick',[])
xlabel('distance')
ylabel('at % Sn')
text(0.25, 0.18, 'Sn')
text(0.75, 0.18, 'Pb')
print(gcf,'-depsc2',['../../316-2_figures/' mfilename '.eps'])