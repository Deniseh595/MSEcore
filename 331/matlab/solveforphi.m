chi=1.05;  % this is the value of chi we want to use
mus=@(phis)log(phis)+1-phis+chi*(1-phis)^2; % solvent chemical potential expression
phiguess=0.2;  % initial guess for phiguess
phisval=fsolve(mus,phiguess)  % returns the value of phis for which mus=0, with an initial guess for phis of phiguess







