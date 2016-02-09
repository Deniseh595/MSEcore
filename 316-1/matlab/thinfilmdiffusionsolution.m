figformat % set some defaults so the figures look pretty
xnorm=linspace(-1,1,200);  % These are the values for x/L that we want to consider
lDL=[0.2,0.4,0.6]; % these are the three values of the normalized diffusion length that we will include in our calculations
c=@(xnorm,lDL) (1/lDL)*(pi)^(-0.5)*exp(-xnorm.^2/lDL^2);  % define a function of two variables, x and Dt
col={[1,0,0],[0,0.5,0],[0,0,1]};  % these are the three colors (rgb format)
linetype={'-','--','-.'};  % these are the three line types we well used (plain, dashed and dash-dot)
axes
hold on
for i=1:3
    plot(xnorm,c(xnorm,lDL(i)),'color',col{i},'linestyle',linetype{i})
    legendtext{i}=['$\ell_{a}^{D}/L$=' num2str(lDL(i))];
end
legend(legendtext,'location','best','interpreter','latex')
ylabel('C_{a}L/C_{s}')
xlabel('x/L')
print(gcf,'../figures/thinfilmsolution.eps','-depsc2') % save as an eps file