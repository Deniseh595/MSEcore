gab=0.072;  
theta(1)=37; 
theta(2)=23;
parmguess = [0.05; 0.05];     % Make a starting guess at the contact angles
% now we rewrite the function interms of parm, with parm(1) and parm(2)
% given by:  parm(1)=gad;  parm(2)=gbd
contactanglefunction=@(parm) [gab-parm(1)*cosd(theta(1))-parm(2)*cosd(theta(2));
    parm(1)*sind(theta(1))-parm(2)*sind(theta(2))];
% note that the function is actually two separate functions, separated by a
% semicolon.  The functions must be written so that the solution is
% obtained by setting the functions to zero
[parmfit,fval] = fsolve(contactanglefunction,parmguess);  % Call solver 
gad=parmfit(1) 
gbd=parmfit(2) 