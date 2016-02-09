close all
figformat
x=linspace(-2,2,200);
cerf=@(x) -erf(x);
cerfderiv=@(x) (2/sqrt(pi))*exp(-x.^2);
cerf2deriv=@(x) -2*x.*(2/sqrt(pi)).*exp(-x.^2);
cthin=@(x) (pi)^(-0.5)*exp(-x.^2); 
cthintosolve=@(x) cthin(x)-cthin(0)/2;

figure
plot(x,cthin(x),'b-')
ylabel('$C_{a}\ell_{a}^{D}/C_{s}$','interpreter','latex')
xlabel('$x/\ell_{a}^{D}$','interpreter','latex','fontsize',20)
w=fsolve(cthintosolve,0.5);
%arrow([-w,0.5*cthin(0)],[w,0.5*cthin(0)],'ends','both');
text(0,0.33,'$2w$','horizontalalignment','center', 'interpreter','latex')
%print(gcf,'../figures/thinfilmdiffusionlength.eps','-depsc2') % save as an eps file
%%
figure
plot(x,cerf(x),'b-')
hold on
plot(x,2*x/pi^0.5,'r--')
ylabel('$C_{a}$','interpreter','latex')
xlabel('$x/\ell_{a}^{D}$','interpreter','latex','fontsize',20)
w=sqrt(pi)/2;
arrow([-w,1],[w,1],'ends','both');
text(0,0.85,'$2w$','horizontalalignment','center', 'interpreter','latex')
ylim([-1.2 1.2])
set(gca,'ytick',[-1,1])
set(gca,'yticklabel',[])  % turn off the y axis tick labls by making 'yticklable' an empty vector
text(-2.25, -1, 'C_{1}','fontsize',16)
text(-2.25, 1, 'C_{2}','fontsize',16)
%print(gcf,'../figures/erfdiffusionlength.eps','-depsc2') % save as an eps file

%%
yshift=0.07; % factor to increase subfigure size, moving them closer together
figure  % make figure to illustrate vacancy fluxes
subplot3=subplot(3,1,1);
plot(x,cerf(x),'b-')
hold on
plot(x,-cerf(x),'r--')
ylabel('$C_{a}, C_{b}$', 'interpreter', 'latex')
set(gca,'ytick',[])
set(gca,'xtick',[])
pos=get(gca,'Position');
pos(4)=pos(4)+yshift;
set(gca,'Position',pos)
legend('C_{a}', 'C_{b}')
text(-1.9,0.75,'(a)','fontsize',20)

subplot2=subplot(3,1,2);
plot(x,cerfderiv(x),'b-')
hold on
plot(x,-0.7*cerfderiv(x),'r--')
plot(x,-0.3*cerfderiv(x),'-.','color',[0,0.5,0])
ylabel('$J_{a}, J_{b}, J_{v}$', 'interpreter', 'latex')
set(gca,'ytick',[])
set(gca,'xtick',[])
pos=get(gca,'Position');
pos(4)=pos(4)+yshift;
set(gca,'Position',pos)
legend('J_{a}', 'J_{b}', 'J_{v}')
text(-1.9,0.75,'(b)','fontsize',20)

subplot3=subplot(3,1,3);
plot(x,cerf2deriv(x),'-.', 'color', [0,0.5,0])
hold on
plot([-2 2],[0 0],'k-','linewidth',1)
ylabel('$\partial C_{v}/ \partial t$', 'interpreter', 'latex')
set(gca,'ytick',[])
set(gca,'xtick',[])
xlabel('$x$', 'interpreter', 'latex', 'fontsize',20)
pos=get(gca,'Position');
pos(4)=pos(4)+yshift;
set(gca,'Position',pos)
annotation(gcf,'textbox',...
    [0.321051814480784 0.148305084745763 0.117666848471862 0.185017466683916],...
    'Interpreter','none',...
    'String',{'vacancies','destroyed'},...
    'FontSize',12,...
    'FitBoxToText','on',...
    'LineStyle','none',...
    'LineWidth',2);
annotation(gcf,'textbox',...
    [0.604283012252372 0.153728813559322 0.117666848471862 0.185017466683916],...
    'Interpreter','none',...
    'String',{'vacancies','created'},...
    'FontSize',12,...
    'FitBoxToText','off',...
    'LineStyle','none',...
    'LineWidth',2);

set(gcf,'paperposition',[0 0 6 8])
set(gcf,'papersize', [6 8])
text(-1.9,0.75,'(c)','fontsize',20)
%print(gcf, '../figures/vacancycreation.eps','-depsc2')

%% plots similar to previous one for Cu/Ni homework/exam problem
figure
plot(x,cerfderiv(x),'b-')
hold on
plot(x,-0.7*cerfderiv(x),'r--')
plot(x,-0.3*cerfderiv(x),'-.','color',[0,0.5,0])
ylabel('$J_{Cu}, J_{Ni}, J_{v}$', 'interpreter', 'latex')
set(gca,'ytick',[])
set(gca,'xtick',[])
legend('J_{Cu}', 'J_{Ni}', 'J_{v}')
set(gcf,'paperposition',[0 0 7 3])
set(gcf,'papersize',[7 3])
print(gcf,'../figures/Cu_Ni_examfluxes.svg','-dsvg')

figure
plot(x,-cerf2deriv(x),'-.', 'color', [0,0.5,0])
hold on
plot([-2 2],[0 0],'k-','linewidth',1)
ylabel('Vac. creation rate')
set(gca,'ytick',[])
set(gca,'xtick',[])
xlabel('$x$', 'interpreter', 'latex', 'fontsize',20)
set(gcf,'paperposition',[0 0 7 3])
set(gcf,'papersize',[7 3])
print(gcf,'../figures/Cu_Ni_vaccreationrate.svg','-dsvg')


%%  now repeat previous plots for thin film solutions.
close all
da=1;
db=0.5;
ca=@(x) exp(-x.^2); 
cb=@(x) 1-ca(x);
cagradient=@(x) -2.*x.*ca(x);
cbgradient=@(x) -cagradient(x);
ja=@(x) -da*cagradient(x);
jb=@(x) -db*cbgradient(x);
jv=@(x) -ja(x)-jb(x);
jvderiv=@(x) 2*(db-da)*exp(-x.^2).*(1-2*x.^2);


x=linspace(-3,3,200);
figure
plot(x,ca(x),'b-',x,cb(x),'r--')
ylim([0 1.2])
ylabel('X_{a}, X_{b}')
xlabel('x')
set(gca,'xtick',[])
legend({'X_{a}', 'X_{b}'},'location', 'best')
print(gcf,'../figures/thinfilmprofiles.eps','-depsc2')

figure
plot(x,ja(x),'b-',x,jb(x),'r--',[min(x),max(x)],[0,0],'k-')
ylabel('J_{a}, J_{b}')
xlabel('x')
set(gca,'xtick',[],'ytick',[])
legend({'J_{a}', 'J_{b}'},'location', 'best')
print(gcf,'../figures/thinfilmfluxes.eps','-depsc2')

figure
plot(x,jv(x),'b-',[min(x),max(x)],[0,0],'k-')
ylabel('J_{v}')
xlabel('x')
set(gca,'xtick',[],'ytick',[])
print(gcf,'../figures/vacancyflux.eps','-depsc2')

figure
plot(x,jvderiv(x),'b-',[min(x),max(x)],[0,0],'k-')
ylabel('dJ_{v}/dx')
xlabel('x')
set(gca,'xtick',[],'ytick',[])
print(gcf,'../figures/vacancycreationrate.eps','-depsc2')

figure
da=1; db=1;
plot(x,-cagradient(x),'b-',x,-cbgradient(x),'r--',[min(x),max(x)],[0,0],'k-')
ylabel('J_{a}^{''}, J_{b}^{''}')
xlabel('x')
set(gca,'xtick',[],'ytick',[])
legend({'J_{a}^{''}', 'J_{b}^{''}'},'location', 'best')
print(gcf,'../figures/thinfilmfluxesprime.eps','-depsc2')

figure
plot(x,jv(x),'b-',[min(x),max(x)],[0,0],'k-')
ylabel('V')
xlabel('x')
set(gca,'xtick',[],'ytick',[])
print(gcf,'../figures/latticeplanevelocity.eps','-depsc2')



