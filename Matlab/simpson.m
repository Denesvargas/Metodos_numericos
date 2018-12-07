clear all
clc
format long;

fstr = input('Entre com a funcao: ', 's');
f = str2sym(fstr);
a = input('Digite o inicio do intervalo: ');
b = input('Digite o final do intervalo: ');
n = input('Digite o numero de intervalos: ');

h = (b - a) / n;
% gerar todos os valores dos intervalos (calculo de x(i))
k = 1;
x = zeros(n + 1, 1);
for i = a: h: b
    x(k) = i;
    k = k + 1;
end

disp(x)
% gerar todos os valores dos intervalos aplicados na função(calculo de y(i))

y = zeros(n + 1, 1);
for i = 1: n + 1
    y(i) = subs(f, x(i));
end
% calculo da Integral trinagular repetida

soma = y(1);
for i = 2: n
    if(mod(i, 2) == 0)
        soma = soma + 4*y(i);
    else
        soma = soma + 2*y(i);
    end
end
soma = soma + y(n + 1);
soma = (h/3)*soma;

fprintf('O resultado eh %f.\n', soma);

% plota os trapezios

hold on;
grid on;
fplot(f, [min(x), max(x)], 'k-');
for i = 1: n+1
    plot([x(i), x(i)], [0, y(i)], 'k-');
end
plot(x, y, 'r*');
hold off;

