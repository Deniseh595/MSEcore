% solution script
go=30; gow=50; gw=72; 
verticalforce=@(theta) go*sind(theta(1))-gow*sind(theta(2)); 
horizontalforce=@(theta) gw-go*cosd(theta(1))-gow*cosd(theta(2));
ftosolve=@(theta) [verticalforce(theta), horizontalforce(theta)]; 
thetaguess=[10,10]; 
thetasolution=fsolve(ftosolve, thetaguess)