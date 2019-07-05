function [Fx] = FREUROTH(x)
n = length(x);  %Dimension del problema

Fx = 0;
for j = 1:(n/2)
   Fx = Fx + (-13 + x(2*j-1) + ((5-x(2*j))*x(2*j)-2)*x(2*j))^2 +(-29 + x(2*j-1) + ((x(2*j)+1)*x(2*j) - 14)*x(2*j))^2;
end

end

