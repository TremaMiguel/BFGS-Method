function [x, iter] = mlbfgs(fname, x0, m)
%Método de memoria limitada bfgs para fname: R^n -> R.
% Autores: Salvador Candelas, Eduardo Martínez, Armando Trejo
% Análisis Aplicado
% ITAM
% 4 Diciembre del 2018

%IN: 
% - fname.- cadena con el nombre de la función a minimizar
% - x0.- vector inicial de dimensión n para la minimización
% - m.- número natural que representa el número de pares de vectores 
%      para almacenar.
%OUT:
% - x.- vector final de la minimización (minimo)
% - iter.- número de iteraciones del metodo

%----------------------------------------------------------------------
tol = 1.e-06;                    % tolerancia a la norma del gradiente
x   = x0;                        % punto inicial
n   = length(x);                 % dimensión del problema
gx  = gradiente(fname,x);        % gradiente en el punto
%-----------------------------------------------------------------------
maxiter = 100;                   % número máximo de iteraciones          
iter    = 0;                     % contador de las iteraciones
maxjter = 10;                    % número máximo de iteraciones en backtracking
ss = zeros(n,m);                 % vector para guardar los valores de sk
yy = zeros(n,m);                 % vector para guardar los valores de yk
gamma = zeros(m,1);              % vector para guardar los valores de gammak
B0 = 1;                          % Como tomamos como matriz inicial la identidad, 
                                 % ponemos usamos un uno para multiplicar
                                 % al vector. 

while (norm(gx) > tol  && iter < maxiter)
    iter = iter + 1;    % Empezamos a contar las iteraciones
    %--------------------------------------------------
    % 4.1 Calculamos la direccion de descenso con memoria limitada
    % Codigo tomado de Nocedal p. 178
    alpha = zeros(m,1);
    q = gx;
    for ii = m:-1:1
        alpha(ii) = gamma(ii)*(ss(:,ii)'*q);
        q = q - alpha(ii)*yy(:,ii);
    end
    if (mod(iter,m) == 0) %Actualizamos la matriz para que siga siendo pd
        B0 = (s0'*y0)/(y0'*y0);
        r = B0*q;
    else
        r = B0*q;
    end
    for ii = 1:m
        beta = gamma(ii)*(yy(:,ii)'*r);
        r = r + ss(:,ii)*(alpha(ii) - beta);
    end
    p = -r;
    if norm(p) >= 1e3  % Si la norma de p es muy grande, la escalamos para no irnos a infinito muy rapido
        p = p / norm(p);
    end
    %--------------------------------------------------
    % 4. 2 busqueda de lineal (Condiciones fuerte Wolfe)
    jter = 0;
    t = 2.0;
    pend = gx'*p;
    fx = feval(fname,x);
    flag = true;
    while (flag && jter < maxjter)
        xt = x+t*p;
        gxt = gradiente(fname,xt);
        a1 = (feval(fname,xt) < fx + (1.e-04)*t*pend); %Condicion 1 de Wolfe
        a2 = (abs(norm(gxt)'*p) < 0.9*abs(pend));      %Condicion 2 de Wolfe
        a2 = sum(a2);
        if ( a1 && a2)                           %Revisamos que se cumplan ambas
            flag = false;
        else
            t = (0.5)*t;
            jter = jter + 1;
        end
    end
   % fin de busqueda de linea
   %----------------------------------------------------
    % 4.3 Actualizamos valores
    xp = x + t*p;                 %Nuevo punto
    gx = gradiente(fname,xp);     %Gradiente en el nuevo punto
    s0 = xp - x;
    y0 = gx - q;
    ss = [ss(:,2:m),s0];
    yy = [yy(:,2:m),y0];
    gamma = [gamma(2:m); 1/(x0'*y0)];
    x = xp;
end