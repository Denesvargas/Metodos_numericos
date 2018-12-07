

%===================================Entradas===================================%

x=input('Digite o vetor x: ');
y=input('Digite o vetor y: ');

n=length(x);

plot(x,y,'r*');
hold on;
grid on;

%Determina o metodo a ser utilizado
disp('Escolha o método a ser utilizado:');
disp('1 - Polinomio');
disp('2 - Hiperbolico');
disp('3 - Exponencial de base e');
disp('4 - Exponencial de base qualquer');
disp('5 - Curva Geometrica');

resp=input('Qual deseja usar? :');

switch (resp)

	case 1
		m=input('Digite o grau do polinomio: ');

	case 2
		m=1;
		for i=1:n
			y(i)=1/y(i);
		end

	case 3
		m=1;
		y=log(y); %Trocar para ln na versão do Matlab

	case 4
		m=1;
		y=log(y);

	case 5
		m=1;
		x=log(x);
		y=log(y);

end


%Restante das entradas
A=zeros(m+1,m+1);
b=zeros(m+1,1);

%=========================Construcao matriz A e vetor b========================%

pot=2*m;
p=pot;

for i=1:m+1
    for j=1:m+1
        A(i,j)=sum(x.^p);
        p=p-1;
    end
    pot=pot-1;
    p=pot;
end

p=m;

for i=1:m+1
    b(i)=sum(y.*(x.^p));
    p=p-1;
end

%============================Metodo de Elim de Gauss===========================%

aum=[A b];
mult=zeros(m+1,m);

for j = 1:m
    for i = j+1:m+1

        %Verifica e trata pivos nulos%
        if aum(j,j) == 0
            for l = j+1:n
                if aum(l,j) ~= 0
                    aux = aum(l,:);
                    aum(l,:) = aum(j,:);
                    aum(j,:) = aux;
                    break;
                end
            end
        end


        mult(i,j) = aum(i,j)/aum(j,j);
        aum(i,:) = aum(i,:)-mult(i,j)*aum(j,:);
    end
end

%Resolucao da matriz triangulara superior%
sol(m+1)=aum(m+1, m+2)/aum(m+1,m+1);

for i = m: -1 :1
   soma = 0;
   for j = i + 1:m+1
      soma = soma + aum(i, j)*sol(j);
   end
   sol(i) = (aum(i, m+2) - soma)/aum(i, i);
end

fprintf('O vetor solução é: \n');

for i = 1:m+1
   fprintf('%d = %f\n', i, sol(i));
end

%========================Define polinomio para cada caso=======================%
coef = num2str(sol');

switch (resp)

	case 1

		g = [coef(1,:) '* x^' num2str(m)];

		for i=2:m+1
		    g = [g ' + (' coef(i,:) ')* x^' num2str((m+1)-i)];
		end

	case 2
		g=['1/(' coef(1,:) '* x + ' coef(2,:) ')'];

	case 3
		g=[coef(2,:) '* exp(' coef(1,:) '*x)'];

	case 4
		g=[coef(2,:) '*' coef(1,:) '^x'];

	case 5
		g=[coef(2,:) '*x^' coef(1,:)];

end

%===============================Define Polinomio===============================%

disp('A g(x) eh: ');
disp(g);

%================================Grafico final=================================%

erro=0;

for  i=1:n
    erro=erro+(subs(str2sym(g) ,x(i))-y(i))^2;
end

erro=(erro^(1/2));
fprintf('O erro � %f\n', erro);
fplot(g,[min(x),max(x)]);
