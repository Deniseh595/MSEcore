myfun=@(x) [3*x(1)+2*x(2)-3; 2*x(1)-x(2)+2];  % x(1)=a,  x(2)=b
xguess=[0,0]; % initial guess for x(1), x(2)
xans=fsolve(myfun, xguess) % xans is values of x(1), x(2) that return a zero value of the function