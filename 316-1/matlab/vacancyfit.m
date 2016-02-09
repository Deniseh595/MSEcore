close all % close all existing plots
load vacancydiff % load the previously saved output.mat file
n=vacancydiff.n;
midpoint=(n+1)/2;  % this is the midpoint of the simiulation, where
    % the composition changes from 'red' to 'blue'

% define the error function
c1=0;
c2=1;
cerf=@(w,x) 0.5*(c1+c2)+0.5*(c2-c1)*erf((x-midpoint)/w);
x=1:n;
wguess=5; % initial guess for w in fit
figure
for k=1:4
    subplot(2,2,k)
    matrix=vacancydiff.matrices{k};
    c=sum(matrix,1)/n-1; % sum of each column in the matrix
    plot(x,c,'+b')
    hold on
    wfit(k)=lsqcurvefit(cerf,wguess,x,c);
    plot(x,cerf(wfit(k),x),'r-')
    xlabel ('x')
    ylabel ('C_{blue}')
    title(['t=', num2str(vacancydiff.times(k)),...
        ', w=', num2str(wfit(k))])
    ylim([-0.1 1.1])
end
set(gcf, 'paperposition', [0 0 12 6])
set(gcf, 'papersize', [12 6])
print(gcf,'vacancyfit.eps','-depsc2')

% now we creat the plot of w vs. the square root of time 
figure
t=vacancydiff.times;
plot(t, wfit.^2,'+b')
hold on
linfit=@(m,x) m*x;
mfit=lsqcurvefit(linfit,1,t,wfit.^2);
D=mfit/4;
Nv=1/n^2; %
prefactor=D/Nv;
xlabel('t')
ylabel('w^{2}')
title(['slope=', num2str(mfit)])
plot([0 1e5],[0 mfit*1e5], 'b-') 
set(gcf, 'paperposition', [0 0 7 5])
set(gcf, 'papersize', [7 5])
print(gcf,'vacancydcalc.eps', '-depsc2')





