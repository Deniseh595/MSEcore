% symbolic_visco.m
syms tau w go t real positive % specify symbolic variables and insist that they be real and positive
g=go*exp(-t/tau); % define exponential  relaxation function
storage=w*int(g*sin(w*t),t,0,inf); % evaluate the ingetral for G'
loss=w*int(g*cos(w*t),t,0,inf); % evaluate the integral for G"
pretty(storage) % visualize the expressions in a simpler form
pretty(loss)