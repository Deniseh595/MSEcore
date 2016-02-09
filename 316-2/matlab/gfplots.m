figure;
gf=importdata('X17_gf.txt','\t',0);
t=gf(:,1);
f5=gf(:,2);
f15=gf(:,3);
f25=gf(:,4);
plot(t,f5,'ro',t,f15,'go',t,f25,'bo')
xlabel('Time (min)');
ylabel('\Delta \Gamma / \Delta f');
title('X17');
figure;
gf2=importdata('X02_gf.txt','\t',0);
t2=gf2(:,1);
f52=gf2(:,2);
f152=gf2(:,3);
f252=gf2(:,4);
df5=gf2(:,5);
df15=gf2(:,6)./sqrt(3);
df25=gf2(:,7)./sqrt(5);
m5=gf2(:,5);
m15=gf2(:,6)./sqrt(3);
m25=gf2(:,7)./sqrt(5);
plot(t2,f52,'ro',t2,f152,'go',t2,f252,'bo')
xlabel('Time (min)');
ylabel('\Delta \Gamma / \Delta f');
title('X02');
figure;
plot(t2,df5,'ro',t2,df15,'go',t2,df25,'bo')
title('X02 sqrt');
figure;
gf3=importdata('X03_gf.txt','\t',0);
t3=gf3(:,1);
f53=gf3(:,2);
f153=gf3(:,3);
f253=gf3(:,4);
plot(t3,f53,'ro',t3,f153,'go',t3,f253,'bo')
xlabel('Time (min)');
ylabel('\Delta \Gamma / \Delta f');
title('X03');