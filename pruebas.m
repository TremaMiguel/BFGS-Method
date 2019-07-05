%script dixmaanjlm3
clear; clc;
r=2;
m=3;
switch r
    case 1
        x0=2*ones(1500,1);
        fname = 'DIXMAANAJ';
    case 2
        x0=repmat([0.5,-2],1,500)';
        fname = 'FREUROTH';
    case 3
        x0=2*ones(1000,1);
        fname = 'Rosenbrock1000';
    otherwise
        x0=ones(1000,1);
        fname = 'TRIDIA';
end
tic
[x, iter] = mlbfgs(fname, x0, m);
tiempo = toc;

fprintf('%s\n\n',fname)
fprintf('tiempo\t\t\titer\t\tnorma gradiente\t\tvalor\n')
fprintf('%2.6f\t\t%3.0f\t\t\t%1.6f\t\t\t%2.6f\n', tiempo, ...
    iter, norm(gradiente(fname,x)),feval(fname,x))


