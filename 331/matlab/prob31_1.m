% first we specify the data values
phi=[0.0457 0.0917 0.138 0.185 0.232 0.280 0.329 0.377 0.427 0.476 0.51];
pressure=[0.0411 0.145 0.346 0.685 1.212 2.010 3.161 4.868 7.323 10.77 14.54];

% these are formatting statements for the plot to look pretty
set(0,'defaultaxesfontsize',18)
set(0,'defaultlinelinewidth',2)
semilogy(phi,pressure,'b+','markersize',18)
xlabel('\phi_{p}','fontsize',16)
ylabel('\Pi (MPa)','fontsize',16)
xlim([0 0.6])
ylim([0.01 100])

%these are a few of the constants we'd like to have for the functions
kb=1.38e-23;
T=283; 
vs=30e-30;  % this is the molecular volume of water in cubic meters

% now we get the best fit to the scaling expression
scaling=@(a0,phi) (1e21*kb*T/(a0^3))*phi.^2.25;  % a0 is in nm, pressure in MPa
a0=lsqcurvefit(scaling,0.5,phi,pressure);  % obtains the best fit, using 0.5 nm as the first guess for a0

% now we get the best fit to the Flory-Huggins form
floryhuggins=@(chi,phi) -1e-6*(kb*T/vs)*(log(1-phi)+phi+chi.*phi.^2); 
chi=lsqcurvefit(floryhuggins,0.4,phi,pressure);  % uses 0.4 as initial guess for chi

% nwo we overlay the different curves
hold on % everthing until the 'hold off' command is plotted on the same set of axes
xfit=linspace(0, 0.6, 100); % specifies the phi values used for the plot
semilogy(xfit, scaling(a0,xfit),'b-' )
semilogy(xfit, floryhuggins(chi,xfit),'r-')
legend('Data', ['scaling with a_{0}=' num2str(a0,'%6.3f') ' nm'], ...
    ['Flory-Huggins with \chi=' num2str(chi,'%6.3f')],'location','southeast')
hold off


