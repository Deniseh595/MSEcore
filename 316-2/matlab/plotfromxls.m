close all
clear all
set(0,'defaultaxesfontsize',16)
set(0,'defaultlinelinewidth',2)
set(0,'defaultfigurepapersize',[6 4])
set(0,'defaultfigurepaperposition',[0 0 6 4])
gf=xlsread('X03_gf.xlsx');
t=gf(:,1);
f5=gf(:,2);
f15=gf(:,3);
f25=gf(:,4);
plot(t,f5,'ro',t,f15,'g+',t,f25,'bs')
xlabel('Time (min)');
ylabel('\Delta f');
legend('5 MHz', '15 MHz', '25 MHz')
ylim([-100 1000])
title('X03');
filename='../316-2_figures/plot_from_xls';
print(gcf,'-depsc2',filename)

