figure
figformat % set some defaults so the figures look pretty
x=linspace(-1,1,200);  % These are the x points
lDL=[0.2,0.4,0.6]; % these are the three values of the normalized diffusion length that we will include in our calculations
c=@(x,lDL) erf(x/lDL);  % define a function of two variables, x and lDL
col={[1,0,0],[0,0.5,0],[0,0,1]};  % these are the three colors (rgb format)
linetype={'-','--','-.'};  % these are the three line types we well used (plain, dashed and dash-dot)
axes
hold on
for i=1:3
    plot(x,c(x,lDL(i)),'color',col{i},'linestyle',linetype{i})
    legendtext{i}=['$\ell_{a}^{D}/L$=' num2str(lDL(i))];
end
legend(legendtext,'location','best','interpreter','latex')
ylabel('C_{a}')
xlabel('x/L')
ylim([-1.2 1.2])
set(gca,'ytick',[-1,1])
set(gca,'yticklabel',[])  % turn off the y axis tick labls by making 'yticklable' an empty vector
text(-1.15, -1, 'C_{1}','fontsize',16)
text(-1.15, 1, 'C_{2}','fontsize',16)
print(gcf,'erfsolution.eps','-depsc2') % save as an eps file