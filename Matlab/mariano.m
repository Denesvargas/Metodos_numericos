% Método de Gauss Seidel %
format short;
 
A = input ('Entre com a matriz A: ');
b = input ('Entre com o vetor b: ');
%for i = 1:n
%   A(i, i) = 1000 * A(i, i)
%end
vx0 = input ('Entre com o vetor inicial x0: ');
nmax = input ('Digite o número máximo de iterações: ');
tol = input ('Digite a tolerancia: ');
 
% Construção da C e g %
 
n = size(A);
 
for i = 1:n
    for j = 1:n
        if (i == j)
            C(i, j) = 0;
        else
            C(i, j) = (- A(i, j)/A(i, i));
        end
    end
    g(i) = b(i)/A(i, i);
end

k = g';
for i = 1:n
   soma = 0;
   if i == 1
       for j = 2:n
           beta(i) = soma + abs(C(i, j));
       end
   else
       soma1 = 0;
       for j = 1:i-1
           soma1 = soma1 + beta(j) * abs(C(i, j));  
       end
       for j = i+1:n
           soma = soma + abs(C(i, j));
       end
       beta(i) = soma1 + soma;
   end
end
 
if (norm(beta, inf) > 1)
    fprintf ('Não há garantia de convergência.');
    return;
end
 
erro = 1;
ite = 0;
M = tril(C);
N = triu(C);
while(erro > tol && ite < nmax)
    vx1 = N * vx0 + k;
    for i = 2:n
        vx1 = M * vx1 + N * vx0 + k;
    end
    fprintf('depois x\n');
    disp(vx1)
    erro = norm(vx1 - vx0, inf)/norm(vx1, inf);
    vx0 = vx1;
    ite = ite + 1;
    
    
end

if (ite >= nmax)
    fprintf ('O método atingiu o número máximo e iterações.')
    return;
end
 
fprintf ('O método convergiu para o vetor, em %d iterações: ', ite);
for i = 1:n
    fprintf ('%8.5f ', vx1(i));
end
fprintf ('\n');