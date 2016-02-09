global na nb chi % these values also get used in function definitions
set(0,'defaultaxesfontsize',16)
set(0,'defaultlinelinewidth',2)
phi=linspace(0.001,0.999,1000);  
na=150;
nb=100;
chi=0.02;
% fv is the expression for the free energy of mixing
fv=@(phi) phi.*log(phi)/nb+(1-phi).*log(1-phi)./na+chi.*phi.*(1-phi);

%mua and  mub are the chemical potentials of A and B
mua=@(phi) log(1-phi)+phi*(1-na/nb)+chi*na*phi.^2; 
mub=@(phi) log(phi)+(1-phi)*(1-nb/na)+chi*nb*(1-phi)^2;

% now write the function that is equal to zero when the A and B chemical
% potentials are equal to one another for phi=phi(1) and phi=phi(2)

ftosolve=@(phi) [mua(phi(1))-mua(phi(2));
    mub(phi(1))-mub(phi(2))];

plot(phi,fv(phi));
xlabel('\phi_{b}')
ylabel('G_{v}V_{0}/RT')

% start with a guess for the equilibrium volume fractions
phiguess = [0.2; 0.8];     % Make a starting guess at the equilibrium compositions
[phicalc,fval] = fsolve(ftosolve,phiguess);  % Call solver 

% now we add the tangent line
slope=(fv(phicalc(2))-fv(phicalc(1)))/(phicalc(2)-phicalc(1));
intercept=fv(phicalc(1))-slope*phicalc(1);
tangentline=intercept+slope.*phi;
hold on
plot(phi,tangentline,'r')
hold off
title(['\chi=' num2str(chi) ', N_a=' num2str(na), ', N_b=' num2str(nb)], 'fontsize', 11)

% now save the plot as a jpg file
saveas(gcf,'commontangent.jpg');

% this saves the file a .eps file, used to embed the figure into the
% solution set - students can comment out this next line if they don't wan
% the .svg file
print(gcf,'-dsvg','commontangent.svg')



