sf = input('Digite a funcao: ', 's');
f = str2sym(sf);
xi = input('digite o ponto inicial: ');
x1 = input('digite o segundo ponto: ');
p = input('Digite a precisão: '); 
n = input('Digite o numero maximo de execucoes: ');

erro = 1;
nexe = 0;
xa = 0;
while(erro > p && nexe < n)
    fx = subs(f,xi);
    fx1 = subs(f, x1);
    x2 = (xi*fx1 - x1*fx)/(fx1 - fx);
    if(fx1 - fx == 0)
        fprintf('O metodo falhou, divisao por zero, tente usar outros pontos iniciais.');
        break;
    end
    fx2 = subs(f,x2);
    fprintf('xi= %2.5f | fx= %2.5f | abs(fx) = %2.5f | x2 = %2.5f -- fx2 = %2.5f\n', xi, fx, abs(fx), x2, fx2);
    if(abs(fx2) < p)
        fprintf('O metodo convergiu pela imagem e a solução é: %2.5f\n', x2);
        break;
    end
    erro = abs(x2-xi)/abs(x2);
    xi = x1;
    x1 = x2;
    nexe = nexe + 1;
    pause();
end
if(erro < p)
    fprintf('O metodo convergiu pelo dominio e a solucao é: %2.5f\n', x2);
elseif(nexe >= n)
    disp('O metodo atingiu o numero maximo de execuções');
end
