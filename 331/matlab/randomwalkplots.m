close all
clear all
xdata(1)=0;
ydata(1)=0;
steps=1000;

theta=360*rand(steps,1);

subplot(1,2,1)
for i=2:steps+1
    thetaval=90*round((theta(i-1))/90);
    xdata(i)=xdata(i-1)+cosd(thetaval);
    ydata(i)=ydata(i-1)+sind(thetaval);
end

plot(xdata,ydata,'b-','linewidth',2)
axis equal
set(gca,'visible','on')
[figx, figy] = dsxy2figxy(gca, [0 xdata(steps+1)], [0 ydata(steps+1)]); %  (now in figure space)
annotation('arrow',figx,figy,'linewidth',2,'color','red')
xlabel('x/a')
ylabel('y/a')
title('(a)')

subplot(1,2,2)
for i=2:steps+1;
    xdata(i)=xdata(i-1)+cosd(theta(i-1));
    ydata(i)=ydata(i-1)+sind(theta(i-1));
end
plot(xdata,ydata,'b-','linewidth',2)

axis equal
set(gca,'visible','on')
[figx, figy] = dsxy2figxy(gca, [0 xdata(steps+1)], [0 ydata(steps+1)]); %  (now in figure space)
annotation('arrow',figx,figy,'linewidth',2,'color','red')

xlabel('x/a')
ylabel('y/a')

title('(b)')

set(gcf,'paperposition',[0 0 10 7])
set(gcf,'papersize',[10,7])
print(gcf','../figures/randwomwalks2d.eps','-depsc2')

%%
figure
gaussian=@(x) exp(-1.5*x.^2);
xdata=linspace(-1,1,100);
ydata=gaussian(xdata);
plot(xdata,ydata,'b-')
xlabel('R/R_0')
set(gca,'YTick',[],'FontSize',16)
set(gcf,'paperposition',[0 0 5 5],'papersize',[5 5])
print(gcf,'../figures/singlechainconfigs.eps','-depsc2')
