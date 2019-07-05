%script tridialm29
clear; clc;

m=29;
x0=ones(1000,1);
fname = 'TRIDIA';

tic
[x, iter] = mlbfgs(fname, x0, m);
tiempo = toc;

fprintf('%s\n\n',fname)
fprintf('tiempo\t\t\titer\t\tnorma gradiente\t\tvalor\n')
fprintf('%2.6f\t\t%3.0f\t\t\t%1.6f\t\t\t%2.6f\n', tiempo, ...
    iter, norm(gradiente(fname,x)),feval(fname,x))