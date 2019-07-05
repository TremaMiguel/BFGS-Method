%script freurothlm3
clear; clc;

m=3;
x0=repmat([0.5,-2],1,500)';
fname = 'FREUROTH';

tic
[x, iter] = mlbfgs(fname, x0, m);
tiempo = toc;

fprintf('%s\n\n',fname)
fprintf('tiempo\t\t\titer\t\tnorma gradiente\t\tvalor\n')
fprintf('%2.6f\t\t%3.0f\t\t\t%1.6f\t\t\t%2.6f\n', tiempo, ...
    iter, norm(gradiente(fname,x)),feval(fname,x))
