matrix=importdata('matini.mat');
nx=size(matrix,1);
ny=size(matrix,2);
% initialisation of vacancy positon
xv=round(nx/2);
yv=round(ny/2);
matrix(xv,yv)=0;

nvec=[+1 -1 0 0; 0 0 +1 -1];
Gamma=zeros(1,4);
cumgam=zeros(1,4);

t=0;
tmax=1e6;

while t<=tmax
    t=t+1;
    
    for i=1:4
        Gamma(i)=1/4;
    end

    cumgam=cumsum(Gamma);
    % choice of jump direction
    rn=rand;
    njump=1;
    for k=1:4
        if cumgam(k)>=rn
            break
        end
        njump=k+1;
    end
    
    xn=xv+nvec(1,njump);% coordinate x of the atom of the exchange
    yn=yv+nvec(2,njump);% coordinate y of the atom of the exchange
    
    % verification of periodic conditions 
    xn=mod(xn-1,nx)+1;
    yn=mod(yn-1,ny)+1;
    % exchange of vacancy an neighbor positions
    neighbix=sub2ind(size(matrix), xn, yn);
    vacix=sub2ind(size(matrix), xv, yv);
    matrix([vacix neighbix])=matrix([neighbix vacix]); 
    xv=xn;
    yv=yn;
end
