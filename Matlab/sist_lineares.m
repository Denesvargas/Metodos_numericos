clear all
clc

a = input('Entre com a matriz A: ');
b = input('Entre com o vetor b: ');

[n, m] = size(a);

aum = [a b];
k = [n, m];
% metodo de Gauss
for j = 1: m
    for i = j +1:n
        if(aum(j, j) == 0)
            fprintf('pivo é zero em (%d, %d), precisa achar outro pivô.\n', j, j);
            coluna = 0;
            for c = i: m
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
                fprintf('Não foi possivel encontrar um pivô, o método falhou.\n');
                return;
            end
        end
        if(aum(i, j) == 0)
           continue; 
        end
        k(i,j) = aum(i, j)/aum(j, j);
        aum(i, :) = aum(i, :) - k(i, j)*aum(j, :);
    end
    disp(aum);
end

disp(aum);
x(n) = aum(n, n+1)/aum(n,n);
% resolução da matriz tringular superior
for i = n - 1: -1 :1
   soma = 0;
   for j = i + 1:n
      soma = soma + aum(i, j)*x(j);
   end
   x(i) = (aum(i, n+1) - soma)/aum(i, i);
end
fprintf('O vetor solução é: \n');
for i = 1:n
   fprintf('%d = %f\n', i, x(i)); 
end


