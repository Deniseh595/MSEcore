function y = oilonwater(theta)
goa=30; gow=50; gwa=72;  % specify the different interfacial energies
y(1)=goa*sind(theta(1))-gow*sind(theta(2));
y(2)=gwa-goa*cosd(theta(1))-gow*cosd(theta(2));
end

