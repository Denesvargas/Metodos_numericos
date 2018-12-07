clear all
clc
format long;

x = input('Entre com o vetor x: ');
y = input('Entre com o vetor y: ');
%tam da matriz
n = length(x);

A = zeros(n, n + 1);

% construção da matriz de interpolação
A(:, 1) = x;
A(:, 2) = y;
linha = n - 1;
incr = 1;
for i = 3: n+1
     for j = 1: linha

         A(j, i) = (A(j+1, i-1) - A(j, i - 1))/ (A(j + incr, 1) - A(j, 1));
     end
     linha = linha - 1;
     incr = incr + 1;
end

% construcao do polinomio de newton

pol = '0';
for i = 1: n
    num = '1';
    for j = 1: i
        if(i ~= j)
            if(length(num) ~= 1)
                num = [num ' * (x - ' num2str(A(j,1)) ')'];
            else
                num = ['(x - ' num2str(A(j,1)) ')'];
            end
        end
    end
    if (length(pol) ~= 1)
        pol = [pol ' + ' num ' * (' num2str(A(1, i + 1)) ')'];
    else
        pol = [num ' * (' num2str(A(1, i + 1)) ')'];
    end
end

disp(pol);

fplot(str2sym(pol), [min(x), max(x)]);