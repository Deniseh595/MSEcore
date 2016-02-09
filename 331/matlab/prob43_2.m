t=[75 85 100 120 140];
at=[1 0.16 2e-2 2.2e-3 4.5e-4];
logat=log10(at);
set(0,'defaultaxesfontsize',18)
plot(t,logat,'b+','markersize',18)
xlabel('T (^{\circ}C)','fontsize',16)
ylabel('log(a_{T})','fontsize',16)
xlim([70 150])
ylim([-4 1])
parm(1)=0; % initial guess for T infinity
parm(2)=700;  % initial guess for B
parm(3)=logat(1)-parm(2)/(t(1)-parm(1));  % to force fit through first data point
vogel=@(parm,t) parm(3)+parm(2)./(t-parm(1));
yfit=lsqcurvefit(vogel,parm,t,logat);
xforplot=linspace(min(t),max(t),100);
yforplot=vogel(yfit,xforplot);
hold on
plot(xforplot,yforplot,'-b')
hold off



