function [fx] = TRIDIA(x0)
n = length(x0); %Dimensión del problema

alpha = 2;
beta = 2;
gamma = 1;
delta = 1;

termino2 = 0;
for i=2:n
    termino2 = termino2 + i*(alpha*x0(i) - beta*x0(i-1))^2;
end
fx = gamma*(delta*x0(1)-1)^2 + termino2;
end

