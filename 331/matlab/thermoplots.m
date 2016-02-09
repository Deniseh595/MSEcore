%% start with the plot of the solvent chemcial potential for infinite molecular weight polymer
figformat
mus=@(chi,phip) log(1-phip)+phip+chi*phip.^2;
phip=linspace(0.01,0.99,100);
chi=[0, 0.5, 1];
axes
hold on
colors={'red','blue','black'};
linestyles={'-','--',':'};
for k=1:length(chi)
    muscalc=mus(chi(k),phip);
    plot([0,phip], [0,muscalc],'linestyle',linestyles{k},'color', colors{k})
    legendtext{k}=['\chi=',num2str(chi(k))];
end
legend(legendtext,'location','southwest')
ylabel('\mu_s^{\infty}/RT')
xlabel('\phi_p')
ylim([-0.4 0.2])
print(gcf,'../figures/musinf.svg','-dsvg')

%% now we generate the plot that compares scaling and Flory Huggins forms of the solvent chemical potential
figformat
chi=0.4;
a03=4;  % this is a0^3/vs
pifh=@(phip) -(log(1-phip)+phip+chi*phip.^2);
piscaling=@(phip) (1/a03)*phip.^2.25;
phip=linspace(0,0.2,100);
plot(phip,pifh(phip),'r-',phip,piscaling(phip),'b--')
xlabel('\phi_p')
ylabel('\Pi V_s/RT')
print(gcf,'../figures/osmoticpressureplots.svg','-dsvg')
legend('Scaling','Flory-Huggins','location','northwest')

%% now we make a plot that shows the equilibrium swelling for a high molecular weight polymer in pure solvent
figformat
chi=@(phip) (-log(1-phip)-phip)./phip.^2;
phip=linspace(0.01,0.99,100);
plot(chi(phip),phip,'-b')
xlabel('\chi')
ylabel('\phi_p')
pause(1)
print(gcf,'../figures/polymerswelling.svg','-dsvg')

