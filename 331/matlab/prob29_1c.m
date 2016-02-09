phi=linspace(0.001,0.999,1000);
set(0,'defaultaxesfontsize',18)
%plot(t,logat,'b+','markersize',18)
N=10000;
chicrit=(N+1+2*N^0.5)/(2*N);
chiratio=[0.9 1 1.2 1.5];
plottypes={'r+', 'b+', 'g+', 'k+'};
parm(1)=N;  % degree of polymerization
chempot=inline('log(1-phi)+phi*(1-1/parm(1))+parm(2)*phi.^2','parm','phi');
for numplot=1:4
    parm(2)=chiratio(numplot)*chicrit;
    plot(phi,chempot(parm,phi),plottypes{numplot});
    hold on
end
yaxis=0.*phi;
plot(phi,yaxis,'k-')
hold off
xlabel('\phi_{p}','fontsize',16)
ylabel('\mu_{s}/k_{B}T','fontsize',16)
xlim([0 1])
ylim([-0.1 0.02])
legend('\chi/\chi_{crit}=0.9','\chi/\chi_{crit}=1','\chi/\chi_{crit}=1.2',...
    '\chi/\chi_{crit}=1.5','location','northeast')

