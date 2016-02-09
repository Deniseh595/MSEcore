go=30; gow=50; gw=72;  % specify the different interfacial energies
verticalforce=@(theta) go*sind(theta(1))-gow*sind(theta(2)); % this is the net force in the vertical direction
horizontalforce=@(theta) gw-go*cosd(theta(1))-gow*cosd(theta(2));
ftosolve=@(theta) [verticalforce(theta), horizontalforce(theta)]; % write the function so that it returns the two components of the net force that both must be zero
thetaguess=[10,10]; % initial guess for theta1 and theta2
thetasolution=fsolve(ftosolve, thetaguess) % returns the solution as thetasolution
