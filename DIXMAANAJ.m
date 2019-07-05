function [fx] = DIXMAANAJ(x0)
n = length(x0); %Dimension del problema

%El archivo toma el punto x0 = [2 2 2 ... 2]


m = n/3;
termino1 = 0;
termino2 = 0;
termino3 = 0;
termino4 = 0;
alpha = 1;
beta = 0.0625;
gamma = 0.0625;
delta = 0.0625;
k1 = 2;
k2 = 0;
k3 = 0;
k4 = 2;

for i = 1:n
    termino1 = termino1 + alpha*x0(i)^2*(i/n)^k1;   
end
for j = 1:(n-1)
    termino2 = termino2 + beta*x0(j)^2*(x0(j+1)+x0(j+1)^2)^2*(j/n)^k2;
end
for k=1:(2*m)
    termino3 = termino3 + gamma*x0(k)^2*x0(k+m)^4*(k/n)^k3;
end
for l=1:m
    termino4 = termino4 + delta*x0(l)*x0(l+2*m)*(l/n)^k4;
end
fx = 1 + termino1 + termino2 + termino3 + termino4;

end
