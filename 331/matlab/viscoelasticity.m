clear all; close all; figformat
%% make figure to illustrate Boltzmann Superposition
clear all; close all;
sigi=@(gam0,t) gam0*exp(-t).*abs(t>=0);
gami=@(gam0,t) gam0.*abs(t>=0);
gam0=[1 -0.6 -0.3];
t0=[0 0.6 0.9 1.2];
t=[linspace(t0(1),t0(2),100), linspace(t0(2),t0(3),100), linspace(t0(3),t0(4),100)];
gamma=gami(gam0(1),t-t0(1))+gami(gam0(2),t-t0(2))+gami(gam0(3),t-t0(3));
sigma=sigi(gam0(1),t-t0(1))+sigi(gam0(2),t-t0(2))+sigi(gam0(3),t-t0(3));

subplot(2,1,1)
plot([-1,0,t],[0,0,gamma])
ylabel('\gamma')
xlim([-0.1 1.2])
ylim([0 1.1])

subplot(2,1,2)
plot([-1,0,t],[0,0,sigma],'b-')
xlabel('t/\tau')
ylabel('\sigma_{xy}/G_0')
xlim([-0.1 1.2])
ylim([-0.7 1.1])
hold on
t1=t(1:300); t2=t(101:300); t3=t(201:300);
plot(t1,sigi(gam0(1),t1-t0(1)),'b--')
plot(t2,sigi(gam0(2),t2-t0(2)),'b--')
plot(t3,sigi(gam0(3),t3-t0(3)),'b--')

set(gcf,'paperposition',[0 0 7 5])
set(gcf,'papersize',[7 5])
print(gcf,'-depsc2','../figures/boltzmann_superposition.eps')

%%
tau1=1e-3; tau2=100;
g1=1e9; g2=1e5;
gr2=@(t) g1*exp(-t/tau1)+g2*exp(-t/tau2);
gr1=@(t) g1*exp(-t/tau);

subplot(1,2,1)
xdata=linspace(0,5*tau1,100);
plot(xdata,gr1(xdata),'b-')
xlabel('t (s)')
ylabel('G(t) (Pa)')

xdata=logspace(-5,3,100);


figure

figure
subplot(1,2,1)
xdata=logspace(-5,5,300);
plot(xdata,gr(xdata),'b-');
ylabel('G(t)')
xlabel('t (s)')
xlim([0 5e-3])
ylim([0 1.2e9])

subplot(1,2,2)
xdata=logspace(-5,5,300);
loglog(xdata,gr(xdata),'b-');
ylabel('G(t)')
xlabel('t (s)')
xlim([1e-5 1e3])
ylim([1e4 1e10])

set(gcf,'paperposition',[0 0 10 4])
set(gcf,'papersize',[10 4])
set(gca,'xTick',[1e-5,1e-3,1e-1,10,1000])
print(gcf,'-depsc2','../figures/relaxationplots_2tau')

%%  Plot behavior of Maxell Model
w=logspace(-2,2,100);
storage=w.^2./(1+w.^2);
loss=w./(1+w.^2);
loglog(w,storage,'-r','linewidth',2)
hold on
loglog(w,loss','--b','linewidth',2)
xlabel('\omega\tau','fontsize',16)
ylabel('G^\prime/G_0, G^{\prime\prime}/G_0','fontsize',16)
set(gcf,'paperposition',[0 0 7 5])
set(gcf,'papersize',[7 5])
set(gca,'fontsize',16)
legend('G^\prime','G^{\prime\prime}','location','best')
print(gcf,'../figures/maxwellideal.svg','-dsvg')


