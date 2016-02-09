load vacancydiff % load the previously saved output.mat file
figure
figformat % not necessary, this is the standard initialization script I use to standardize what my plots look like
n=vacancydiff.n;
matrix=vacancydiff.matrices{4};
matrixsum=sum(matrix,1); % sum of each column in the matrix
plot(1:n,matrixsum/n,'+b')
xlabel ('x')
ylabel ('C')
print(gcf,'vacancyplot.eps','-depsc2') % this creates an .eps file, which I use for the coursenotes but which may not be as useful for many of you as the jpg file
saveas(gcf,'vacancyplot.jpg')
