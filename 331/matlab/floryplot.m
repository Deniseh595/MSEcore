clear all
close all
figformat
fmix=@(chi,phib,na,nb) chi*phib.*(1-phib)+phib.*log(phib)/nb+(1-phib).*log(1-phib)/na;
phivals=linspace(0.01,0.99,100);
phib=[0,phivals,1];
chi=[0 1 2 3 4];
na=1;
nb=1;
hold on
for i=1:length(chi);
    fvals{i}=fmix(chi(i),phivals,na,nb);
    fvals{i}=[0,fvals{i},0];
    plot(phib,fvals{i})
    legendtext{i}=['\chi=' num2str(chi(i))];
end
legend(legendtext,'location','best')
xlabel('\phi_b')
ylabel('\Deltaf_{mix}v_{0}/k_{B}T')
title(['N_a=' num2str(na) ' N_b=' num2str(nb)])
print(gcf,'../figures/floryplotsna1nb1.svg','-dsvg')
%% now repeat for asymmetric case
figure
chi=chi/200;
na=200;
nb=500;
hold on
for i=1:length(chi);
    fvals{i}=fmix(chi(i),phivals,na,nb);
    fvals{i}=[0,fvals{i},0];
    plot(phib,fvals{i})
    legendtext{i}=['\chi=' num2str(chi(i))];
end
legend(legendtext,'location','best')
xlabel('\phi_b')
ylabel('\Deltaf_{mix}v_{0}/k_{B}T')
title(['N_a=' num2str(na) ' N_b=' num2str(nb)])
print(gcf,'../figures/floryplotsna200nb500.svg','-dsvg')