% curvefitting script
xdata=[75 85 100 120 140];
ydata=[1 0.16 2e-2 2.2e-3 4.5e-4];
plot(xdata,logydata,'b+','markersize',18)
xlabel('T (^{\circ}C)','fontsize',16)
ylabel('log(a_{T})','fontsize',16)
tref=75;
p(1)=0;
p(2)=700;
vogel=@(p,x) -p(2)./(tref-p(1))+p(2)./(x-p(1)); 
pfit=lsqcurvefit(vogel,p,xdata,logydata); 
xfit=linspace(min(xdata),max(xdata),100); 
yfit=vogel(pfit,xfit);
hold on 
plot(xfit,yfit,'-b')
legend('data','fit','location','best')
print(gcf,'atplot.eps','-depsc2')
saveas(gcf,'atplot.jpg')


