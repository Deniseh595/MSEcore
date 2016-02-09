close all
figure
figformat
Cudata=dlmread('diffdata/DCu.txt', '\t',6,0);
Nidata=dlmread('diffdata/DNi.txt', '\t',6,0);
Dtildedata=dlmread('diffdata/Dtilde.txt', '\t',6,0);
semilogy(Cudata(:,1)/100,Cudata(:,2),'b-+')
hold on
semilogy(Nidata(:,1)/100,Nidata(:,2),'r-O')
xlabel('X_{Cu}')
ylabel('D_{Cu}, D_{Ni} (cm^2/s)')
legend('D_{Cu}', 'D_{Ni}', 'location', 'best')
print(gcf,'../figures/Cu_Ni_diffusion_plot.svg','-dsvg')