function linjumpdiff03fig1diff
% Book Illustration for Linear (Geometric)Jump Diffusion SDE RNG 
%   Simulation with constant coefficients for t in [0,1] 
%   with sample variation:
%        DX(t) = X(t)*(mu*Dt + sig*DW(t) + nu*DP(t),   
%            X(0) = x0.
%   Or log-state:
%        DY(t) = (mu-sig^2/2)*Dt + sig*DW(t) + log(1+nu)*DP(t),  
%       Y(0) = log(x0).
%   Generation is by summing Wiener increments DW of even spacing Dt
%     with Poisson jump increment added at correct time increment.
%   Sufficiently SMALL increments assumed, so zero-one jump law is
%       appropriate.
%   Allows Separate Driver Input and Special Jump 
%       or Diffusion Handling.
clc % clear variables, but must come before globals, 
    %    else clears globals too.
clf % clear figures
fprintf('\nfunction linjumpdiff03fig1 OutPut:');
%%% Initialize input to jdsimulator
N = 1000; T = 1.0; % Set initial time grid: Fixed Delta{t}.
mu = 0.5; sig = 0.10; nu = 0; lambda = 0; 
% set constant parameters.
%
jdsimulator(mu,sig,nu,lambda,N,T);
%
% END INPUT FOR JUMP-DIFFUSION SIMULATOR.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function jdsimulator(mu,sig,nu,lambda,N,T)
idiff = 1; ijump = 1;
if sig == 0, idiff = 0; end
if nu == 0, ijump = 0; end
nfig = 0; % figure counter.
NI = N+1;  Dt = T/NI;
iv = 2; % iv=1 for *(1+/-sqrt(Var[X])) or iv=2 for *exp(+/-sqrt(Var[Y]).
sqrtdt = sqrt(Dt); % Set standard Wiener increment moments.
muddt = (mu - sig^2/2)*Dt; % Get Ito diffusion corrected drift term. 
lognu = log(1 + nu); % Get log of relative jump term amplitude.
% Begin Sample Path Calculation:
t = 0:Dt:T; kstates = 4; x0 = 1.0;
XS = zeros(NI+1,kstates); % declare global state vector.
for kstate = 1:kstates % Test Multiple Simulated Sample Paths:
    if idiff == 1
      randn('state',kstate-1); % Set initial normal state
                               %    for repeatability.
      DW = sqrtdt*randn(NI,1); % Generate normal random vector 
                               %    of N samples for DW(t).
    end
    if ijump == 1
      rand('state',kstate-1); % Set initial uniform state
                              %    for repeatability.
      DU = rand(NI,1); % Generate Uniform random vector of N 
                       %    DP(t) samples.
      ldt = lambda*Dt; % one jump prob.
      ul = (1-ldt)/2;  ur = (1+ldt)/2; % Set centered jump 
                                       %   probability thresholds,
    end
     XS(1,kstate) = x0; % Set initial state.
    % using centered part of uniform distribution 
    %     to avoid open end point bias.
    YS = zeros(1,NI+1); % Set initial exponent. 
    for i = 1:NI % Simulated Sample paths by Increment Accumulation:
        YS(i+1) = YS(i) + muddt;
        if idiff == 1, YS(i+1) = YS(i+1)+ sig*DW(i); end
        if ijump == 1
          if DU(i) <= ur && DU(i) >= ul % Get jump if prob. in [ul,ur]:
             YS(i+1) = YS(i+1) + lognu;
          end
        end
        XS(i+1,kstate) = x0*exp(YS(i+1));% Invert exponent to get state.
    end
end
% Compute Mean State Path and +/- One Std. Deviation:
XT(1) = x0; XB(1) = x0;
XM = zeros(1,NI+1); XM(1) = x0; % Set initial state mean.
XT = zeros(1,NI+1); XT(1) = x0; % Set initial state top spread.
XB = zeros(1,NI+1); XB(1) = x0; % Set initial state bottom spread.
muxexp = mu + lambda*nu; 
if iv == 1, sigxexp = sig^2 + lambda*nu^2; end
if iv == 2, sigyexp = sig^2 + lambda*(log(1+nu))^2; end
for i = 1:NI
    XM(i+1) = x0*exp(muxexp*t(i+1));
    if iv == 1
        V = sqrt(exp(sigxexp*t(i+1)) - 1);
        XT(i+1) = XM(i+1)*(1 + V);
        XB(i+1) = XM(i+1)*(1 - V);
    end
    if iv == 2
        V = exp(sqrt(sigyexp*t(i+1)));
        XT(i+1) = XM(i+1)*V;
        XB(i+1) = XM(i+1)/V;
    end
end
% Begin Plot:
nfig = nfig + 1;
kjd = 4 - 2*idiff - ijump;
NP = N + 2;
stitle = {'Linear Jump-Diffusion Simulations' ...
        ,'Linear Diffusion Simulations' ...
        ,'Linear Jump Simulations'};
sylabel = {'X(t), Jump-Diffusion State','X(t), Diffusion State' ...
        ,'X(t), Jump State'};
fprintf('\n\nFigure(%i):  Linear Jump-Diffusion Simulations\n',nfig)
figure(nfig)
scrsize = get(0,'ScreenSize'); % figure spacing for target screen
ss = [5.0,4.0,3.5]; % figure spacing factors
plot(t,XS(1:NP,1),'k-' ...
    ,t,XS(1:NP,2),'k-' ...
    ,t,XS(1:NP,3),'k-' ...
    ,t,XS(1:NP,4),'k-' ...
    ,t,XM(1:NP),'k--' ...
    ,t,XT(1:NP),'k-.' ...
    ,t,XB(1:NP),'k-.','LineWidth',2);
title(stitle(kjd)...
    ,'FontWeight','Bold','Fontsize',44);
ylabel(sylabel(kjd)...
    ,'FontWeight','Bold','Fontsize',44);
xlabel('t, Time'...
    ,'FontWeight','Bold','Fontsize',44);
if iv == 1
hlegend=legend('X(t) Sample 1','X(t) Sample 2','X(t) Sample 3'...
    ,'X(t) Sample 4','E[X](t)','(E[X]*(1+V))(t)','(E[X]*(1-V))(t)'...
    ,'Location','NorthWest');
end
if iv == 2
hlegend=legend('X(t) Sample 1','X(t) Sample 2','X(t) Sample 3'...
    ,'X(t) Sample 4','E[X](t)','(E[X]*V)(t)','(E[X]/V)(t)'...
    ,'Location','NorthWest');
end
set(hlegend,'Fontsize',36,'FontWeight','Bold');
set(gca,'Fontsize',36,'FontWeight','Bold','linewidth',3);
set(gcf,'Color','White','Position' ...
   ,[scrsize(3)/ss(nfig) 60 scrsize(3)*0.60 scrsize(4)*0.80]); %[l,b,w,h]
%
% End JDSimulator Code