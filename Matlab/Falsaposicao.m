sf = input('Digite a funcao: ', 's');
f = inline(sf);
a = input('digite o inicio do intervalo: ');
b = input('digite o final do intervalo: ');
p = input('Digite a precisão: ');  



if(f(b)*f(a) > 0)
    disp('Não tem raiz no intervalo')
else
    fa = f(a);
    fb = f(b);
    while((b-a) > p)
        x = (a*fb-b*fa)/(fb-fa);
        fprintf('a= %2.5f | b= %2.5f | x = %2.5f -- abs(f(x)) = %.5f | intervalo = %.5f\n', a, b, x, abs(f(x)), abs(a-b));
        fx = f(x);
        vx = [a;b];
        vy = [fa;fb];
        hold on;
        grid on;
        fplot(sf, [a b]);
        plot(vx, vy, 'r-');
        plot(x, 0, 'g*')
        if(fa*fb == 0)
            disp('A raiz está nos extremos do intervalo.');
            if(fa == 0)
                x = a;
            else
                x = b;
            end
            break;
        end
        if(abs(fx) < abs(p))
            break;
        end
        if(fx*fa > 0)
            a=x;
            fa = fx;
        else
            b=x;
            fb = fx;
        end
        pause();
        hold off;
        clf reset;
    end
    disp('A raiz é ')
    disp(x);
end
