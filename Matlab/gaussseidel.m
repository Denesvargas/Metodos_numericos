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

t(1,1) = sum(abs(c(1,2:n)));
for i = 2: n
    sum1 = 0;
    sum2 = 0;
    for j = 1: i - 1
        sum1 = sum1 + abs(c(i, j))*t(j, 1);
    end
    for j = i + 1: n
        sum2 = sum2 + abs(c(i, j));
    end
    t(i,1) = sum1 + sum2;
end

x1 = v0;
cont = 0;

while(nmax > cont)
    x0 = x1;
    for i = 1: n
        x1(i,1) = c(i,:)*x1 + g(i,1);
    end
    erro = norm(x1 - x0, Inf) / norm(x1, Inf);
    cont = cont + 1;
    if(erro < tol)
       fprintf('O método convergiu e a solucao do sistema é o vetor: \n');
       disp(x1);
       fprintf('O método convergiu com: \n');
       disp(cont);
       return;
    end
    fprintf('vetor x\n');
    disp(x1)
end 

fprintf('vetor x\n');
disp(x1)
disp('O método atingiu o numero máximo de execuções.');
