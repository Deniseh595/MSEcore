%some initialization stuff
clear all
close all
set(0, 'DefaultAxesFontSize', 16);
set(0, 'DefaultTextFontSize', 16);
set(0, 'DefaultLineLineWidth', 2);
set(0, 'DefaultFigurePaperposition',[0 0 6 4])
set(0, 'DefaultFigurePaperSize',[6 4])

%input the data
t=60*[0 6 12 18 24 36 48 60];
l=[7.94 13.3 14.3 16.7 16.6 25 28.6 28.6];
sv=[0.364 0.32 0.258 0.222 0.196 0.178 0.16 0.16];

% create the first plot
plot(t, l.^3, '+b');
hold on
spacingfit=polyfit(t, l.^3, 1); % generates a linear curve fit
plot(t,polyval(spacingfit,t),'b-'); % plots the fit
hold off
xlabel('t (s)')
ylabel('\lambda_{2}^{3} (\mum^{3})')
text(200,2.2e4,'\lambda_{2}^{3}=A+Kt')
ktext=num2str(1e-18*spacingfit(1),'%5.1e');
text(200,1.8e4,['K =' ktext ' m^3/s'])
print(gcf,'-depsc2','../316-2_figures/lab_dendrite_spacing.eps')

% now make the sv plot
figure % creates a new figure window
plot(t, sv.^-3, 'b+');
hold on
svfit=polyfit(t, sv.^(-3),1);
plot(t,polyval(svfit,t))
xlabel('t (s)')
ylabel('S_{v}^{-3} (unspecified units)')
text(200,270,'S_{v}^{-3}=A+Kt')
ktext=num2str(1e-18*svfit(1),'%5.1e');
text(200,220,['K =' ktext])
print(gcf,'-depsc2','../316-2_figures/lab_dendrite_svplot.eps')

% now include another dataset (from Monday PM group)
figure
t=[0 80 160 240 320]; % time in seconds
sv1311=[0.258 0.157 0.10 0.099 0.075];
sv1338=[0.144 0.113 0.096 0.085 0.0756];
plot(t, sv1311.^-3, 'b+', t, sv1338.^-3, 'ro');
svfit1=polyfit(t, sv1311.^(-3),1);
svfit2=polyfit(t, sv1338.^(-3),1);
hold on
plot(t,polyval(svfit1,t),'b-', t, polyval(svfit2,t),'r-')
xlabel('t (s)')
ylabel('S_{v}^{-3} (\mum^{3})')
% now generate legend info
ktext1=num2str(1e-18*svfit1(1),'%5.1e');
ktext2=num2str(1e-18*svfit2(1),'%5.1e');
legendtext{1}=['131.1 ^{\circ}C, K=' ktext1 ' m^{3}/s'];
legendtext{2}=['133.8 ^{\circ}C, K=' ktext2 ' m^{3}/s'];
legend(legendtext,'location','best')
print(gcf,'-depsc2','../316-2_figures/lab_dendrite_svplotv2.eps')
