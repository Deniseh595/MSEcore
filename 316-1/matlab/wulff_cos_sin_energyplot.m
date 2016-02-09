close all
gamma=@(alpha) abs(cos(alpha))+abs(sin(alpha));
r=@(theta,alpha) gamma(alpha)/cos(theta-alpha);
alpha=linspace(0,2*pi,200);
polar(alpha,gamma(alpha),'r-');
title('\gamma=|cos\theta|+|sin\theta|', 'fontsize', 16)
hold on % plot all subsequent curves on existing axes
for alpha=linspace(0,2*pi,17)  % this  is the loop that draws all the lines
    theta(1)=alpha+2*pi/5;  % specify two angles on either side of alpha
    theta(2)=alpha-2*pi/5;
    rvals(1)=r(theta(1),alpha);  % use the equation provided to get r for each
    % of the specified angles
    rvals(2)=r(theta(2),alpha);
    polar(theta,rvals) % plot lines connecting the two points we just defined
end
set(gcf,'paperposition',[0 0 5 5],'papersize',[5 5])
print(gcf,'../figures/matlabwulffenergyexample.eps', '-depsc2') % save the eps file
