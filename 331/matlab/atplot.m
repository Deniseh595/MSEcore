% input the data that we ned
t=[75 85 100 120 140];
at=[1 0.16 2e-2 2.2e-3 4.5e-4];
logat=log10(at); 

% make a new figure window and set the defaults for the plot
figure
pause(1)
figformat % if you use this line, make sure that you include figformat.m in the same directory as atplot.m

% plot the experimental data, label it and set the plot limits
% appropriately
plot(t,logat,'b+', 'markersize',18)
xlabel('T (^{\circ}C)')
ylabel('log(a_{T})')
xlim([70 150])
ylim([-4 1])

% the fitting parameters are all stored as elements of a single variable,
% which in our case is called parm
parm(1)=0; % initial guess for T infinity
parm(2)=700;  % initial guess for B
parm(3)=logat(1)-parm(2)/(t(1)-parm(1));  % requires at=1 for first data point

% the function that we fit to is called volgel in this case.  It is a
% function of two variables:  parm (which includes all of the adjustable
% parameters) and the independent varialbe, which in this case is the
% temperature
vogel=@(parm,t) parm(3)+parm(2)./(t-parm(1));

% lsqcurvefit (least sqaures curve fit) is the MATLAB function that does
% all the work for us.  It retrns the values of parm that give the best fit
% to the data
yfit=lsqcurvefit(vogel,parm,t,logat);

% now we plot the fitted curve over the experimental data
xforplot=linspace(min(t),max(t),100);
yforplot=vogel(yfit,xforplot);
hold on % we set hold to 'on' so that the previously plotted data is not erased when we generate the new plot
plot(xforplot,yforplot,'-b')

% now we save the plot as an .eps file
print(gcf,'atplot.eps','-depsc2')



