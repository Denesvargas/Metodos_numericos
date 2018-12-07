clear all
clc

format long;

a = input('Entre com a matriz A: ');
b = input('Entre com o vetor b: ');
nmax = input('Entre com o maximo de iterações: ');
tol = input('Entre com a tolerância: ');
v0 = input('Entre com o vetor inicial: ');

[n, m] = size(a);

for i = 1: n
   for j = 1: m
      if(i == j)
          c(i, j) = 0;
      else
          c(i, j) = -(a(i, j)/a(i, i)); 
      end
   end
   g(i, 1) = b(i)/a(i, i);
end

disp(c);
disp(g);

if(norm(c, Inf) >= 1)
    if(norm(c, 1) >= 1)
        disp('Não há garantia de convergencia por esse método');
        return;
    end
end
x1 = v0;
cont = 0;
while(nmax > cont)
    x2 = c*x1 + g;
    erro = norm(x2 - x1, Inf) / norm(x2, Inf);
    if(erro < tol)
       fprintf('O método convergiu e a solucao do sistema é o vetor: ');
       disp(x2);
       return;
    end
    x1 = x2;
    cont = cont + 1;
end 

disp('O método atingiu o numero máximo de execuções.');