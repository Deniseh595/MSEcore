%% Phase transformations in elemental copper
% This script uses NIST thermochemical data to 
%       - create plots of thermodynamic functions of state
%       - calculate phase transformation temperatures, and the changes in
%       standard enthalpy, entropy, and Gibbs free energy associated with
%       the phase transformation
%       - compare the change in Gibbs free energy calculated from NIST data
%       to the linearized Gibbs free energy estimate near the phase
%       transformation temperature. 

close all;  clear all; filename = 'Cu_Shomate_';
%% NIST Data
% The NIST Chemistry webbook (URL: http://webbook.nist.gov/chemistry/)
% gives Shomate coefficients that can be used to calculate the heat
% capacity, standard enthalpy, absolute entropy, and standard Gibbs free
% energy as a function of temperature. The Shomate coefficients are define
% only over a certain range of T. Extrapolation beyond this range is
% dangerous.

% NIST Chemistry webbok data for iron can be found here:
% http://webbook.nist.gov/cgi/cbook.cgi?Name=copper&Units=SI
% This is actually a fairly straightforward case, as there only two phase
% transformations: solid (alpha, hcp) -> L and L -> gas

Cu.phase={'s','L','g'};
Cu.Tmin = [298, 1358, 2843.261];
Cu.Tmax = [1358, 2843, 6000];

S=[[17.72891,  32.84450,   -80.48635];
   [28.09870,  -0.000084,   49.35865];
   [-31.25289,  0.000032,   -7.578061];
   [13.97243,  -0.000004,    0.404960];
   [0.068611,  -0.000028,  133.3382];
   [-6.056591, -1.804901,  519.9331];
   [47.89592,  73.92310,   193.5351];
   [0,         11.85730,   337.6003];];

%% Calculating Thermodynamic Functions of State from Shomate Coefficients
% We use here anonymous functions to calculate the thermodynamic functions
% of state. Input arguments are a column vector of exactly 8 Shomate
% coefficients (A-H) and a row vector with temperature values where t = T/1000 [K]. Please note that H0
% is really H0, not H0-H0_298! Cp0 and S0 are given in units of J mol^-1 K^-1, H0
% and G0 in units of kJ mol^-1.

Cp0 = @(Shomate,t) Shomate*[0*t+1 ; t     ; t.^2  ; t.^3  ;  t.^-2    ; 0*t  ; 0*t  ; 0*t]; %[J mol^-1 K^-1]

H0  = @(Shomate,t) Shomate*[t     ; t.^2/2; t.^3/3; t.^4/4; -t.^-1    ; 0*t+1; 0*t  ; 0*t]; %[kJ mol^-1]

S0  = @(Shomate,t) Shomate*[log(t); t     ; t.^2/2; t.^3/3; -0.5*t.^-2; 0*t  ; 0*t+1; 0*t]; %[J mol^-1 K^-1]
 
G0 = @(Shomate, T) H0(Shomate, T/1000)-T/1000.*S0(Shomate, T/1000); % [kJ mol^-1]

%% Calculate phase transformation temperatures
% We define the Gibbs free energy change for four different
% transformations in the system as anonymous functions. To solve for the
% phase transformation tempreature at which the Gibbs free energy change is
% zero, we find the root of the anonymous functions using a guess based on
% the phase transformation temperatures given in phase diagrams.

% vaporization: L->gas
DeltaG_Lg= @(T) G0(S(:,3)',T)-G0(S(:,2)',T);
T_Lg = fzero(DeltaG_Lg,3130);

% melting/fusion: s->L
DeltaG_sL= @(T) G0(S(:,2)',T)-G0(S(:,1)',T);
T_sL = fzero(DeltaG_sL,1800);


%% Plot Functions of State

% T-ranges
T1=linspace(298,T_sL,1000);              
T2=linspace(T_sL,T_Lg,1000);             
T3=linspace(T_Lg,6000,1000);

h1=figure;
set(gcf,'DefaultLineLineWidth',1.5)

c=colormap(lines(3));
plot(T1,Cp0(S(:,1)',T1/1000),'Color',c(1,:));hold on;
plot(T2,Cp0(S(:,2)',T2/1000),'Color',c(2,:));hold on;
plot(T3,Cp0(S(:,3)',T3/1000),'Color',c(3,:));hold on;

title('Heat capacity (specific heat) of elemental Cu');
ylabel('C_p^0 [J mol^-^1 K^-^1]');
xlabel('T [K]');
legend(Cu.phase);
set(gca,'TickDir','out');
grid on;

h2=figure;
set(gcf,'DefaultLineLineWidth',1.5)
plot(T1,H0(S(:,1)',T1/1000),'Color',c(1,:));hold on;
plot(T2,H0(S(:,2)',T2/1000),'Color',c(2,:));hold on;
plot(T3,H0(S(:,3)',T3/1000),'Color',c(3,:));hold on;

title('Standard Enthalpy of elemental Cu');
ylabel('H^0-H_2_9_8 [kJ mol^-^1]');
xlabel('T [K]');
legend(Cu.phase);
set(gca,'TickDir','out');
grid on;

h3=figure;
set(gcf,'DefaultLineLineWidth',1.5)
plot(T1,S0(S(:,1)',T1/1000),'Color',c(1,:));hold on;
plot(T2,S0(S(:,2)',T2/1000),'Color',c(2,:));hold on;
plot(T3,S0(S(:,3)',T3/1000),'Color',c(3,:));hold on;

title('Absolute Entropy of elemental Cu');
ylabel('S^0 [J mol^-^1 K^-^1]');
xlabel('T [K]');
legend(Cu.phase);
set(gca,'TickDir','out');
grid on;

h4=figure;
set(gcf,'DefaultLineLineWidth',1.5)
plot(T1,G0(S(:,1)',T1),'Color',c(1,:));hold on;
plot(T2,G0(S(:,2)',T2),'Color',c(2,:));hold on;
plot(T3,G0(S(:,3)',T3),'Color',c(3,:));hold on;

title('Gibbs Free Energy of elemental Cu');
ylabel('G^0 [kJ mol^-^1]');
xlabel('T [K]');
legend(Cu.phase);
set(gca,'TickDir','out');
grid on;


%% Plot Close Ups of Phase Transformations
h5=figure;
set(gcf,'DefaultLineLineWidth',1.5)
% solid-liquid transition
DT = 2;
T_tr = T_sL;
p1=1;
p2=2;

Tr_left = (T_tr-DT):0.1:T_tr;
Tr_right = T_tr:0.1:(T_tr+DT);
Tr = (T_tr-DT):0.1:(T_tr+DT);

subplot(4,2,1);
ycent=mean([H0(S(:,p1)',Tr_left(end)/1000), H0(S(:,p2)',Tr_left(end)/1000)]);
yrange=abs(H0(S(:,p1)',Tr_left(end)/1000)-ycent);
DeltaH0(1) = H0(S(:,p2)',T_tr/1000)-H0(S(:,p1)',T_tr/1000);

plot(Tr_left,H0(S(:,p1)',Tr_left/1000),'Color',c(p1,:));hold on;
plot(Tr_right,H0(S(:,p1)',Tr_right/1000),'Color',c(p1,:),'LineStyle',':');
plot(Tr_left,H0(S(:,p2)',Tr_left/1000),'Color',c(p2,:),'LineStyle',':');hold on;
plot(Tr_right,H0(S(:,p2)',Tr_right/1000),'Color',c(p2,:));
plot([T_tr T_tr],[0 600],'k:');
plot([T_tr T_tr],[H0(S(:,p1)',Tr_left(end)/1000), H0(S(:,p2)',Tr_left(end)/1000)],'m','LineWidth',2);
xlim([Tr(1) Tr(end)]);
ylim(ycent+[-yrange yrange]*1.5);
ylabel('H^0-H^0_2_9_8 [kJ/mol]');
xlabel('T [K]');
set(gca,'TickDir','out');

subplot(4,2,3);
ycent=mean([S0(S(:,p1)',Tr_left(end)/1000), S0(S(:,p2)',Tr_left(end)/1000)]);
yrange=abs(S0(S(:,p1)',Tr_left(end)/1000)-ycent);
DeltaS0(1) = S0(S(:,p2)',T_tr/1000)-S0(S(:,p1)',T_tr/1000);

plot(Tr_left,S0(S(:,p1)',Tr_left/1000),'Color',c(p1,:));hold on;
plot(Tr_right,S0(S(:,p1)',Tr_right/1000),'Color',c(p1,:),'LineStyle',':');
plot(Tr_left,S0(S(:,p2)',Tr_left/1000),'Color',c(p2,:),'LineStyle',':');hold on;
plot(Tr_right,S0(S(:,p2)',Tr_right/1000),'Color',c(p2,:));
plot([T_tr T_tr],[0 600],'k:');
plot([T_tr T_tr],[S0(S(:,p1)',Tr_left(end)/1000), S0(S(:,p2)',Tr_left(end)/1000)],'m','LineWidth',2);
xlim([Tr(1) Tr(end)]);
ylim(ycent+[-yrange yrange]*1.5);
ylabel('S^0 [J/(mol K)]');
xlabel('T [K]');
set(gca,'TickDir','out');

subplot(4,2,5);
plot(Tr_left,G0(S(:,p1)',Tr_left),'Color',c(p1,:));hold on;
plot(Tr_right,G0(S(:,p1)',Tr_right),'Color',c(p1,:),'LineStyle',':');
plot(Tr_left,G0(S(:,p2)',Tr_left),'Color',c(p2,:),'LineStyle',':');hold on;
plot(Tr_right,G0(S(:,p2)',Tr_right),'Color',c(p2,:));
plot([T_tr T_tr],[0 -600],'k:');
xlim([Tr(1) Tr(end)]);
ylim(G0(S(:,p1)',Tr_left(end))+[-.2 .2]);
ylabel('G^0 [kJ/mol]');
xlabel('T [K]');
set(gca,'TickDir','out');

subplot(4,2,7);
y1=G0(S(:,p2)',Tr(1))-G0(S(:,p1)',Tr(1));
y2=G0(S(:,p2)',Tr(end))-G0(S(:,p1)',Tr(end));

plot(Tr,G0(S(:,p2)',Tr)-G0(S(:,p1)',Tr),'b');hold on; % Note: could be replaced with DeltaG function
plot(Tr,-DeltaS0(1)/1000*(Tr-T_tr),'r:');

plot([Tr(1) Tr(end)],[0,0],'k:');
plot([T_tr T_tr],[y2 y1],'k:');
xlim([Tr(1) Tr(end)]);
ylim([y2 y1]);

ylabel('\DeltaG [kJ/mol]');
xlabel('T [K]');
set(gca,'TickDir','out');

% liguid-gas transition
DT = 2;
T_tr = T_Lg;
p1=2;
p2=3;

Tr_left = (T_tr-DT):0.1:T_tr;
Tr_right = T_tr:0.1:(T_tr+DT);
Tr = (T_tr-DT):0.1:(T_tr+DT);

subplot(4,2,2);
ycent=mean([H0(S(:,p1)',Tr_left(end)/1000), H0(S(:,p2)',Tr_left(end)/1000)]);
yrange=abs(H0(S(:,p1)',Tr_left(end)/1000)-ycent);
DeltaH0(2) = H0(S(:,p2)',T_tr/1000)-H0(S(:,p1)',T_tr/1000);

plot(Tr_left,H0(S(:,p1)',Tr_left/1000),'Color',c(p1,:));hold on;
plot(Tr_right,H0(S(:,p1)',Tr_right/1000),'Color',c(p1,:),'LineStyle',':');
plot(Tr_left,H0(S(:,p2)',Tr_left/1000),'Color',c(p2,:),'LineStyle',':');hold on;
plot(Tr_right,H0(S(:,p2)',Tr_right/1000),'Color',c(p2,:));
plot([T_tr T_tr],[0 600],'k:');
plot([T_tr T_tr],[H0(S(:,p1)',Tr_left(end)/1000), H0(S(:,p2)',Tr_left(end)/1000)],'m','LineWidth',2);
xlim([Tr(1) Tr(end)]);
ylim(ycent+[-yrange yrange]*1.5);
ylabel('H^0-H^0_2_9_8 [kJ/mol]');
xlabel('T [K]');
set(gca,'TickDir','out');

subplot(4,2,4);
ycent=mean([S0(S(:,p1)',Tr_left(end)/1000), S0(S(:,p2)',Tr_left(end)/1000)]);
yrange=abs(S0(S(:,p1)',Tr_left(end)/1000)-ycent);
DeltaS0(2) = S0(S(:,p2)',T_tr/1000)-S0(S(:,p1)',T_tr/1000);

plot(Tr_left,S0(S(:,p1)',Tr_left/1000),'Color',c(p1,:));hold on;
plot(Tr_right,S0(S(:,p1)',Tr_right/1000),'Color',c(p1,:),'LineStyle',':');
plot(Tr_left,S0(S(:,p2)',Tr_left/1000),'Color',c(p2,:),'LineStyle',':');hold on;
plot(Tr_right,S0(S(:,p2)',Tr_right/1000),'Color',c(p2,:));
plot([T_tr T_tr],[0 600],'k:');
plot([T_tr T_tr],[S0(S(:,p1)',Tr_left(end)/1000), S0(S(:,p2)',Tr_left(end)/1000)],'m','LineWidth',2);
xlim([Tr(1) Tr(end)]);
ylim(ycent+[-yrange yrange]*1.5);
ylabel('S^0 [J/(mol K)]');
xlabel('T [K]');
set(gca,'TickDir','out');

subplot(4,2,6);
plot(Tr_left,G0(S(:,p1)',Tr_left),'Color',c(p1,:));hold on;
plot(Tr_right,G0(S(:,p1)',Tr_right),'Color',c(p1,:),'LineStyle',':');
plot(Tr_left,G0(S(:,p2)',Tr_left),'Color',c(p2,:),'LineStyle',':');hold on;
plot(Tr_right,G0(S(:,p2)',Tr_right),'Color',c(p2,:));
plot([T_tr T_tr],[0 -600],'k:');
xlim([Tr(1) Tr(end)]);
ylim(G0(S(:,p1)',Tr_left(end))+[-.2 .2]);
ylabel('G^0 [kJ/mol]');
xlabel('T [K]');
set(gca,'TickDir','out');

subplot(4,2,8);
y1=G0(S(:,p2)',Tr(1))-G0(S(:,p1)',Tr(1));
y2=G0(S(:,p2)',Tr(end))-G0(S(:,p1)',Tr(end));

plot(Tr,G0(S(:,p2)',Tr)-G0(S(:,p1)',Tr),'b');hold on;
plot(Tr,-DeltaS0(2)/1000*(Tr-T_tr),'r:');

plot([Tr(1) Tr(end)],[0,0],'k:');
plot([T_tr T_tr],[y2 y1],'k:');
xlim([Tr(1) Tr(end)]);
ylim([y2 y1]);

ylabel('\DeltaG [kJ/mol]');
xlabel('T [K]');
set(gca,'TickDir','out');

%% Output data
clc;
fprintf('Phase transformation:\n');
fprintf('s->L:\n');
fprintf('T_tr    = %4.2f K.\n',T_sL);
fprintf('DeltaH0 = %4.2f kJ mol^-1.\n',DeltaH0(1));
fprintf('DeltaS0 = %4.2f J mol^-1 K^-1.\n\n',DeltaS0(1));

fprintf('L->gas:\n');
fprintf('T_tr    = %4.2f K.\n',T_Lg);
fprintf('DeltaH0 = %4.2f kJ mol^-1.\n',DeltaH0(2));
fprintf('DeltaS0 = %4.2f J mol^-1 K^-1.\n\n',DeltaS0(2));

%% How good is the linear approximation of DeltaG near T_tr?
% careful here: extrapolation beyond the range over which Shomate
% coefficients are defined may not represent reality very well, or at all.
h6=figure;
set(gcf,'DefaultLineLineWidth',1.5)
DT = 50;

T_tr = T_Lg;
p1=2;
p2=3;
i=2;
Tr = (T_tr-DT):0.1:(T_tr+DT);

subplot(223);
y1=G0(S(:,p2)',Tr(1))-G0(S(:,p1)',Tr(1));
y2=G0(S(:,p2)',Tr(end))-G0(S(:,p1)',Tr(end));

plot(Tr,G0(S(:,p2)',Tr)-G0(S(:,p1)',Tr),'b');hold on;
plot(Tr,-DeltaS0(i)/1000*(Tr-T_tr),'r:');
plot([Tr(1) Tr(end)],[0,0],'k:');
plot([T_tr T_tr],[y2 y1],'k:');
xlim([Tr(1) Tr(end)]);
ylim([y2 y1]);

ylabel('\DeltaG [kJ/mol]');
xlabel('T [K]');
set(gca,'TickDir','out');grid on;

subplot(224);
plot(Tr,100*(G0(S(:,p2)',Tr)-G0(S(:,p1)',Tr)+DeltaS0(i)/1000*(Tr-T_tr))./(-DeltaS0(i)/1000*(Tr-T_tr)),'b');hold on;
grid on;
%plot([T_tr T_tr],[y2 y1],'k:');
xlim([Tr(1) Tr(end)]);
%ylim([y2 y1]);
ylabel('(\DeltaG-\DeltaG_e_s_t)/\DeltaG_e_s_t [%]');
xlabel('T [K]');
set(gca,'TickDir','out');

%
T_tr = T_sL;
p1=1;
p2=2;
i=1;
Tr = (T_tr-DT):0.1:(T_tr+DT);
subplot(221);
y1=G0(S(:,p2)',Tr(1))-G0(S(:,p1)',Tr(1));
y2=G0(S(:,p2)',Tr(end))-G0(S(:,p1)',Tr(end));

plot(Tr,G0(S(:,p2)',Tr)-G0(S(:,p1)',Tr),'b');hold on;
plot(Tr,-DeltaS0(i)/1000*(Tr-T_tr),'r:');
plot([Tr(1) Tr(end)],[0,0],'k:');
plot([T_tr T_tr],[y2 y1],'k:');
xlim([Tr(1) Tr(end)]);
ylim([y2 y1]);

ylabel('\DeltaG [kJ/mol]');
xlabel('T [K]');
set(gca,'TickDir','out');grid on;

subplot(222);
plot(Tr,100*(G0(S(:,p2)',Tr)-G0(S(:,p1)',Tr)+DeltaS0(i)/1000*(Tr-T_tr))./(-DeltaS0(i)/1000*(Tr-T_tr)),'b');hold on;
grid on;
%plot([T_tr T_tr],[y2 y1],'k:');
xlim([Tr(1) Tr(end)]);
%ylim([y2 y1]);
ylabel('(\DeltaG-\DeltaG_e_s_t)/\DeltaG_e_s_t [%]');
xlabel('T [K]');
set(gca,'TickDir','out');

%% save figures h1=h6 as .eps files

print(h1,[filename,'Cp'],'-deps','-cmyk','-opengl');
print(h2,[filename,'S'],'-deps','-cmyk','-opengl');
print(h3,[filename,'H'],'-deps','-cmyk','-opengl');
print(h4,[filename,'G'],'-deps','-cmyk','-opengl');
print(h5,[filename,'PTs'],'-deps','-cmyk','-opengl');
print(h6,[filename,'Linearity'],'-deps','-cmyk','-opengl');
