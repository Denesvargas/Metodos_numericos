format long;

x = input('Entre com o vetor x: ');
y = input('Entre com o vetor y: ');
n = length(x);
m = n - 1;
% [-2;-1;0;1;2]
% [0;0;-1;0;7]
% [2.4;2.6;2.8;3;3.2;3.4;3.6;3.8]  [2.8;3;3.2]
% [11.02;13.46;16.44;20.08;24.53;29.96;36.59;44.7] [16.44;20.08;24.53]
disp(n);
plot(x,y, 'r*');

xbuild = x;
ybuild = y;

A = zeros(m+1, m+1);
b = zeros(m+1, 1);

for i = 1: m+1
    for j = 1: m+1
        if(j == m+1 && i == m+1)
            A(i, j) = n; 
        else
            A(i, j) = sum(xbuild.^(2*m + 2 - i - j));
        end
    end
    b(i, 1) = sum(ybuild.*(xbuild.^(m+1 - i)));
end

fprintf('Matriz A:\n');
disp(A);
disp(b);

% Método de Gauss %
[o, p] = size(A);

aum = [A b];
k = [o, o];

for j = 1: p
    for i = j +1:o
        if(aum(j, j) == 0)
            fprintf('pivo é zero em (%d, %d), precisa achar outro pivô.\n', j, j);
            coluna = 0;
            for c = i: p
                if(coluna == 0)
                    if(aum(c, j) ~= 0)
                       coluna = c; 
                    end
                else
                    if(aum(c, j) > aum(coluna, j))
                       coluna = c; 
                    end
                end
            end
            if(coluna ~= 0)
                aum([j coluna],:) = aum([coluna, j],:);
                fprintf('Trocou a linha %d com a linha %d.\n', j, coluna);
            else
                fprintf('Não foi possivel encontrar um pivô, o método falhou no escalonmento.\n');
                return;
            end
        end
        if(aum(i, j) == 0)
           continue; 
        end
        k(i,j) = aum(i, j)/aum(j, j);
        aum(i, :) = aum(i, :) - k(i, j)*aum(j, :);
    end
end

fprintf('matriz aumentada:\n');
disp(aum);
t(o) = aum(o, o+1)/aum(o,o);
% resolução da matriz tringular superior
for i = o - 1: -1 :1
   soma = 0;
   for j = i + 1:o
      soma = soma + aum(i, j)*t(j);
   end
   t(i) = (aum(i, o+1) - soma)/aum(i, i);
end
fprintf('O vetor solução é: \n');
for i = 1:o
   fprintf('%d = %f\n', i, t(i)); 
end

% parte da aula
coef = num2str(t'); % cria o polinômio a partir dos coeficientes
p = [coef(1, :) '*x^' num2str(o-1)];
for i = 2:o
    p = [p ' + (' coef(i, :) ')* x^' num2str(o-i)];  
end


fprintf('O polinômio é: \n');
disp(p);
fp = str2sym(p);
erro = 0;
for i = 1: n
    erro = erro + (subs(fp, xbuild(i))-ybuild(i))^2;
end
erro = erro^(1/2);
fprintf('aqui no final\n');
disp(subs(fp, 3.1));
fplot(p, [min(xbuild), max(xbuild)]); % plota os pontos dados inicialmente
hold on;
grid on;
plot(xbuild, ybuild, 'ro'); % plota os pontos iniciais
title('Polinômio de ajuste');
xlabel('x');
ylabel('f(x)');
fprintf('O erro é %f\n', erro);