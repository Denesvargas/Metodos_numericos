format long;

x = input('Entre com o vetor x: ');
y = input('Entre com o vetor y: ');
n = length(x);
grau = length(x) - 1;

disp(x);
disp(y);

% contrução das Li
pol = '0';
for i = 1: n
    num = '1';
    den = 1;
    % construção do numerador e denominador
    for j = 1: n
        if(i ~= j)
            fprintf('%s.\n', num);
            if(length(num) ~= 1)
                num = [num '* (x - ' num2str(x(j)) ')'];
            else
                num = ['(x - ' num2str(x(j)) ')'];
            end
            den = den * (x(i) - x(j)); 
        end
    end
    L = ['(' num ') / (' num2str(den) ')'];
    if (pol ~= '0')
        pol = [pol ' + ' num2str(y(i)) ' * ' L];
    else
        pol = [num2str(y(i)) ' * ' L];
    end
end

disp(pol);

plot(x,y, 'r*');
fplot(pol, [min(x), max(y)]); % plota os pontos dados inicialmente
% [1;2;3] [-1;3;-5]






