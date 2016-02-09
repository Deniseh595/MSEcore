cumgam=cumsum(Gamma);
rn=rand;
njump=1;
for k=1:4,
    if cumgam(k)>=rn  
       break
    end
    njump=k+1;
end