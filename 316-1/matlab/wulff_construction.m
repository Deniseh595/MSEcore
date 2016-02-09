close all
A=[0,0.05,0.07,0.6];  % these are the 4 values of A defined in the problem
% define a function where the radius d is the surface energy and alpha
% is the angle
d=@(A,alpha) 1+A*cos(4*alpha);
% now define a function that gives points on lines needed for the wulff
% construction
r=@(A,theta,alpha) d(A,alpha)/cos(theta-alpha);

for k=1:4
    alpha=linspace(0,2*pi,200); % we draw 200 lines around the polar plot.
    subplot(2,2,k)  % this makes a 2 by 2 grid of plots
    hold on  % if hold is on when we make the plot, we don't get the grids
    polar(alpha,d(A(k),alpha),'r-'); % plot the energy curv in red
    for alpha=linspace(0,2*pi,200)  % this is the loop that draws all the lines
        theta(1)=alpha+2*pi/5;  % specify two angles on either side of alpha
        theta(2)=alpha-2*pi/5;
        rvals(1)=r(A(k),theta(1),alpha);  % use the equation provided to get r for each
            % of the specified angles
        rvals(2)=r(A(k),theta(2),alpha);
        polar(theta,rvals) % plot lines connecting the two points we just defined
    end
    rlimit=1.2; % default axeslimits are not really optimzed for these plots, so we'll change them here
    xlim([-rlimit,rlimit])
    ylim([-rlimit,rlimit])
    axis off % we can see the Wulff shapes better if we turn off the axis
    title(['A=' num2str(A(k))],'fontsize',20)  % label each subplot
end
set(gcf,'paperposition',[0 0 10 10])  % this makes sure that the aspect ratios of thee plots are okay
set(gcf,'papersize',[10 10])  % works with paperposition
print(gcf,'../figures/matlabwulffplots.eps', '-depsc2') % save the eps file