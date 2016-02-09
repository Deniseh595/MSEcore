A=0.6;  % these are the 4 values of A defined in the problem
d=@(A,alpha) 1+A*cos(6*alpha);
figure
alpha=linspace(0,2*pi,200);
polar(alpha,d(A,alpha),'r-');  % poloar is the command to make a polar plot
print(gcf, '../figures/matlab6fold.svg', '-dsvg')