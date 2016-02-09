close all
A=[0,0.05,0.07,0.6];  % these are the 4 values of A defined in the problem
% define a function where the radius d is the surface energy and alpha
% is the angle
d=@(A,alpha) 1+A*cos(4*alpha);
figure
for k=1:4
    alpha=linspace(0,2*pi,200); 
    subplot(2,2,k)  % this makes a 2 by 2 grid of plots
    polar(alpha,d(A(k),alpha),'r-');  % poloar is the command to make a polar plot
    title(['A=' num2str(A(k))],'fontsize',20)  % label each subplot
end
% adjust the print command as necessary to change the format, filename,
% etc.
print(gcf,'../figures/matlabwulffenergy.eps', '-depsc2') % save the eps file