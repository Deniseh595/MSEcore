clc
clear all
sig=zeros(3); % create stress tensor and set to zero
sig=[4,3,0; 3,1,2; 0,2,6]*10^6; % this is the only nonzero component
sigp=zeros(3); % initalize rotated streses to zero
phi=30;
theta=[0, 90, 90; 90, phi, 90+phi; 90, 90-phi, phi];
for i=1:3
    for j=1:3
        for k=1:3
            for l=1:3
                sigp(i,j)=sigp(i,j)+cosd(theta(i,k))*cosd(theta(j,l))*sig(k,l);
            end
            % cosd takes degrees instead of radians as the unit
        end
    end
end
sigp %display the transformed tensor components