% Nome: Dênes Vargas Teixeira       Matrícula: 201713225
% a primeira coluna inicia com 0 devido ao somatorio
x = [0,4,2,3,1,6,3,9,0;0,12,8,5,5,2,11,1,4;0,12,8,8,6,3,0,4,5];
n = length(x);
disp(x);
% faz as iterações percorrendo cada coluna indo da
% primeira coluna valida até o fim
for j = 2: n
   x(1, j) = x(1, j) + max([x(1, j - 1), x(2, j - 1)]);
   x(2, j) = x(2, j) + max([x(1, j - 1), x(2, j - 1), x(3, j - 1)]);
   x(3, j) = x(3, j) + max([x(2, j - 1), x(3, j - 1)]);
end
%printa o resultado final que seria o maximo da ultima coluna após as somas
fprintf('O resultado eh: ');
disp(max([x(1, n), x(2, n), x(3, n)]));