close all % close all the existing plot windows to clean things up a bit
clear all % clear all defined variables

% the following are optional commands, used here to set the font
% size and width of the plotted lines so that the plots look good
set(0,'defaultaxesfontsize',16)
set(0,'defaultlinelinewidth',2)
set(0,'defaultfigurepapersize',[5 5])
set(0,'defaultfigurepaperposition',[0 0 5 5])

na=150;
nb=100;

% solution for equilibrium phase compositions
tcrit=350; % critical temperature
chimaxratio=1.5; % this is maximum chi for phase diagram, normalized by chicrit
npoints=1000; % number of different chi points to include in diagram
chicrit=(na+nb+2*(na*nb)^0.5)/(2*na*nb);
phicrit=na^0.5/(na^0.5+nb^0.5);
chimax=chicrit*chimaxratio;
chimin=chicrit*(1+chimaxratio/(npoints-1));

%{
Now we determine the rest of the phase diagram, starting from the largest
values of chi and working toward the critical point
%}
j=0;
phib=[0.01 0.99]; % initial guess for solution at highest chi
for chi=linspace(chimax, chimin, npoints);
    j=j+1
    % define all the necessary equations
    fv=@(phi) phi.*log(phi)/nb+(1-phi).*log(1-phi)./na+chi.*phi.*(1-phi);
    mua=@(phi) log(1-phi)+phi*(1-na/nb)+chi*na*phi.^2;
    mub=@(phi) log(phi)+(1-phi)*(1-nb/na)+chi*nb*(1-phi)^2;
    ftosolve=@(phi) [mua(phi(1))-mua(phi(2));
        mub(phi(1))-mub(phi(2))];
    chiplot(j)=chi;
    a=0.5-1/(4*chi*na)+1/(4*chi*nb);
    phis1(j)=a-(a^2-1/(2*nb*chi))^0.5;
    phis2(j)=a+(a^2-1/(2*nb*chi))^0.5; %#ok<*SAGROW>
    phib = fsolve(ftosolve,phib); % previous solution is used as guess for
    % this value of chi
    phib1(j)=phib(1);
    phib2(j)=phib(2);
end

% now we generate the chi-based phase diagram
figure
plot(phis1,chiplot, 'r');
xlabel('\phi_{b}')
ylabel('\chi')
hold on
plot(phis2,chiplot, 'r')
plot(phib1,chiplot)
plot(phib2,chiplot)
plot(phicrit,chicrit,'r+','markersize',18)
hold off
title(['N_{a}=' num2str(na) '; N_{b}=' num2str(nb)])
pause(1) % not sure why this is needed, but the svg file isn't always generated correctly without it
print(gcf,'-dsvg','flory_chi_diagram')

% now plot temeprature curve - we just need to convert chi values to Temp.
% values
figure % make a new figure
t=tcrit*chicrit./chiplot;
plot(phis1,t, 'r');
xlabel('\phi_{b}')
ylabel('T (K)')
hold on
plot(phis2,t, 'r')
plot(phib1,t)
plot(phib2,t)
plot(phicrit,tcrit,'r+','markersize',18)
hold off
title(['N_{a}=' num2str(na) '; N_{b}=' num2str(nb) '; T_{crit}=' num2str(tcrit) 'K'])

%  now write the file
print(gcf,'-dsvg','flory_t_diagram')
