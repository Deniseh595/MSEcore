function simulate
clear all
global nab dab dastar x0 w
tmin=0; % mininum time
tmax=1e7; % maxmimum time
tpoints=10000; % number of time points
xpoints=300; % number of distance points
xmin=0; % minimum x for simulation
xmax=470; % maximum x for simulation
nab=24/940;  % ratio of A to B molecular weights
dab=1/nab;  % ratio of A to B diffusion coefficients
dastar=0.1;  % diffiusion coeff. in angstroms^2/sec
x0=235; % initial interface position in angstroms
w=5; % initial interfacial width
set(0,'defaultaxesfontsize',16)

m = 0;
x = linspace(xmin,xmax,xpoints);  % distance in angstroms
t = linspace(tmin,tmax,tpoints);  % time in seconds

sol = pdepe(m,@diffeqn,@initial,@pdex1bc,x,t);
phi = sol(:,:,1);

% A solution profile can also be illuminating.
figure
plot(x,phi(1,:)); hold on
for k=2:10:tpoints
    plot(x,phi(k,:))
end
hold off
title('Solutions')
xlabel('Distance \AA', 'interpreter', 'latex')
ylabel('\phi_{a}')
xm=zeros(1,tpoints);
xm(1)=x0;
for k=1:tpoints-1
    [phim(k), dphidxm(k)]=pdeval(m,x,phi(k,:),xm(k));
    v(k)=dastar*(1-nab)*(1-phim(k)+nab*phim(k))*dphidxm(k);
    xm(k+1)=xm(k)+v(k)*(t(k+1)-t(k));
end
figure
semilogx(t,xm)
xlabel('time (s)','fontsize',16)
ylabel('$\Delta x_{m} (\AA)$', 'interpreter', 'latex','fontsize',16)
data(:,1)=t;
data(:,2)=xm;
xlswrite('data',data)
plotdata
% --------------------------------------------------------------
function [c,f,s] = diffeqn(temp1,temp2,phi,DphiDx)
global dastar nab dab 
d=dastar*(1-phi+phi/(dab*nab))*(1-phi+phi*nab); % from PRL, 57, 1312 (1986)
c = 1;
f = d*DphiDx;
s = 0;
% --------------------------------------------------------------
function phi0 = initial(x)  % initital condition at t=0
global x0 w
phi0 = 0.5-0.5*tanh((x-x0)/w);
% --------------------------------------------------------------
function [pl,ql,pr,qr] = pdex1bc(xl,phil,xr,phir,t)
pl = 0;
ql = 1;
pr = 0;
qr = 1;
