tic % start a time so that we can see how long the program takes to run
n=30;  % set the number of boxes across the square grid
vfrac=0.01;  % vacancy fraction
matrix=ones(n); 
map=[1,1,1;1,0,0;0,0,1];  % define 3 colors:  white, red, blue
figure
colormap(map)  % set the mapping of values in 'matrix' to a specific color
caxis([0 2]) % range of values in matrix goes from 0 (vacancy) to 2
% the previous three commands set things up so a 0 will be white, a 1 will
% be red and a 2 sill be blue
matrix(:,n/2+1:n)=2;  % set the right half of the matrix to 'blue'
i=round(n/2);   % put one vacancy in the middle
j=round(n/2);
matrix(i,j)=0; 
imagesc(matrix); % this is the command that takes the matrix and turns it into a plot
t=0;
times=[1e4,2e4,5e4,1e5];
showallimages=0; % set to zero if you want to speed things up by not showing images,  set to 1 if you want to show all the images during the simulation

%% now we start to move things around
vacancydiff.matrices={};  % makea blank cell array
while t<max(times);
    t=t+1;
    dir=round(4*rand+0.5);
    if dir==1
        in=i+1;
        jn=j;
        if in==n+1; in=1; end
    elseif dir==2
        in=i-1;
        jn=j;
        if in==0; in=n; end
    elseif dir==3
        in=i;
        jn=j+1;
        if jn>n; jn=n; end
    elseif dir==4
        in=i;
        jn=j-1;
        if jn==0; jn=1; end
    end
    % now we need to make switch
    neighborix=sub2ind([n n],in,jn);
    vacix=sub2ind([n n],i,j);
    matrix([vacix neighborix])=matrix([neighborix vacix]);
    if showallimages
        imagesc(matrix);
        drawnow
    end
    if ismember(t,times)
        vacancydiff.matrices=[vacancydiff.matrices {matrix}]; % append matrix to output file
        imagesc(matrix);
        set(gcf,'paperposition',[0 0 5 5])
        set(gcf,'papersize',[5 5])
        print(gcf,['vacdiff' num2str(t) '.eps'],'-depsc2')
    end
    i=in;
    j=jn;
end
vacancydiff.times=times;
vacancydiff.n=n;
save('vacancydiff.mat','vacancydiff') % writes the vacancydiff structure to a .mat file that we can read in later
toc




    




