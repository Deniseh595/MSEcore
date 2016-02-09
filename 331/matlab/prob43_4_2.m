t=[130 140 160 180 200];
at=[100 18 1 0.11 0.022];
logat=log10(at);
set(0,'defaultaxesfontsize',18)
plot(t,logat,'b+','markersize',18)
xlabel('T (^{\circ}C)','fontsize',16)
ylabel('log(a_{T})','fontsize',16)
xlim([125 205])
ylim([-2 3])
parm0(3)=0; % initial guess for T infinity
parm0(2)=700;  % initial guess for B
parm0(1)=logat(1)-parm0(2)/(t(1)-parm0(3));  % to force fit through first data point
vogel=inline('parm(1)+parm(2)./(t-parm(3))','parm','t');
yfit=lsqcurvefit(vogel,parm0,t,logat);
xforplot=linspace(min(t),max(t),100);
yforplot=vogel(yfit,xforplot);
hold on
plot(xforplot,yforplot,'-b')
hold off



