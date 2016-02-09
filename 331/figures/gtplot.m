clear all
close all
set(0, 'DefaultAxesFontSize', 16);
set(0, 'DefaultLineLineWidth', 2);
set(0, 'DefaultFigurePaperposition',[0 0 5 5])
set(0, 'DefaultFigurePaperSize',[5 5])
xdata=logspace(-8,0,100);
ydata=1e9*exp(-xdata/1e-6)+2e5*exp(-xdata/1e-1);
loglog(xdata,ydata);
xtics=logspace(-8,1,10);
set(gca,'XTick',xtics)
xlabel('t/a_{T} (s)')
ylabel('G(t) (Pa)')
ylim([1e2 1e10])
xlim([1e-8 1])
print(gcf,'-depsc2','gtplot.eps')

figure
xdata=linspace(-80,50,100);
A=-5;
B=700.6;
Tinf=-100;
ydata=10.^(A+B./(xdata-Tinf));
semilogy(xdata,ydata)
ytics=logspace(-1,7,9);
set(gca,'YTick',ytics)
xlabel('T (^{\circ}C)')
ylabel('a_{T}')
xlim([-40 40])
ylim([0.1 10^7])
print(gcf,'-depsc2','atplot.eps')
