close all
set(0,'defaultaxesxtick',[])
set(0,'defaultaxesytick',[])
set(0,'defaultaxesfontsize',16)
set(0,'defaultlinelinewidth',1)
set(0,'defaultfigurepaperposition',[0 0 4 7])
set(0,'defaultfigurepapersize',[7 7])

t1=0.3;
t2=0.7;
subplot(4,1,1)
plot([0,t1,t2,1],[0,0,1,1],'b-')
ylabel('\gamma')
xlabel('time')
ylim([0,1.1])

subplot(4,1,2)
plot([0,t1,t2,1],[0,0,1,1],'b-')
ylabel('\sigma_{xy}')
xlabel('time')
ylim([0,1.1])
text(0.05,0.8,'solid','horizontalalignment','left')

subplot(4,1,3)
plot([0,t1,t1,t2,t2,1],[0,0,1,1,0,0],'b-')
ylabel('\sigma_{xy}')
xlabel('time')
ylim([0,1.1])
text(0.05,0.8,'liqiud','horizontalalignment','left')

subplot(4,1,4)
numpoints=200;
t=linspace(0,1,numpoints+1);
strainrate=1/(t2-t1);
strain=strainrate*(t-t1).*abs(t>t1).*abs(t<t2)+abs(t>=t2);
diffstrain=diff(strain);
t=t+0.5/numpoints;  % time set to middle of increment
g0=0.2;
tau=0.2;
g=@(t) g0*exp(-t/tau);
for i=1:numpoints
    stress(i)=0;
    for j=1:i-1
        stress(i)=stress(i)+diffstrain(j)*g(t(i)-t(j));
    end
end

plot(t(1:numpoints),stress(1:numpoints),'b-')
ylabel('\sigma_{xy}')
xlabel('time')
ylim([0,0.1])
text(0.05,0.075,'viscoelastic','horizontalalignment','left')
print(gcf,'../figures/generic_viscoelasticity.eps','-depsc2')


%%
% now we get curves for unentangled, entangled and crosslinked polymers
close all
set(0,'defaultaxesxtick',[1e-5 1e-3 1e-1 10 1000 1e5])
set(0,'defaultaxesytick','remove')
set(0,'defaultfigurepaperposition',[0 3 12,4])
set(0,'defaultfigurepapersize',[12 5])

g1=1e9;
g2=1e6;
tau1=1e-3;
tau2=10;
xmin=1e-5;
ymin=1e4;
ymax=1e10;
xmax=1000;
t=logspace(log10(xmin),log10(xmax),100);
case1=@(t) g1*exp(-t/tau1);
case2=@(t) g1*exp(-t/tau1)+g2*exp(-t/tau2);
case3=@(t) g1*exp(-t/tau1)+g2;

subplot(1,3,1)
loglog(t,case1(t))
ylim([ymin ymax])
xlim([xmin xmax])
ylabel('G(t) (Pa)')
xlabel('t')
title('Uncrosslinked, low M')


subplot(1,3,2)
loglog(t,case2(t))
ylim([ymin ymax])
xlim([xmin xmax])
ylabel('G(t) (Pa)')
xlabel('t')
title('Uncrosslinked, high M')

subplot(1,3,3)
loglog(t,case3(t))
ylim([ymin ymax])
xlim([xmin xmax])
ylabel('G(t) (Pa)')
xlabel('t')
title('Crosslinked, high M')

print(gcf,'../figures/viscoelasticity_relaxation curves.eps','-depsc2')

%%
% now plot some representative curves for different phase angles
close all
set(0,'defaultaxesxtick',[])
set(0,'defaultaxesytick',[])
set(0,'defaultaxesfontsize',16)
set(0,'defaultlinelinewidth',1)
set(0,'defaultfigurepaperposition',[0 0 4 7])
set(0,'defaultfigurepapersize',[7 7])
t=linspace(0,6*pi,200);
strain=sin(t);
stress=@(t,d) 
subplot(2,3,1)



