figformat
kb=1.38e-23;
nav=6.02e23;
m=32/nav;
g=9.8/1000;
p0=1.01e5;
h=linspace(0,10000,10);
t=300;
p=exp(-m*g.*h/(kb*t));
plot(h,p,'b-')
xlabel('h (m)')
ylabel('P(h)/P(h=0)')
print(gcf,'../figures/pressure_height_plot.eps','-depsc2')

