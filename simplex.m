% Para o programa funcionar corretamente inicialmente
%é necessário definir as constantes do problema.
% Caso seu problema seja de minimização, atribua
%true para a variável mínimo, se for de máximo,
%atribua false

A = [1 1 1 0 0; -1 1 0 1 0; 1 0 0 0 1]
b = [6; 2; 5]
c = [-1; -2; 0; 0; 0]
base = [3 4 5]
maxit = 5
x = zeros(maxit,length(c))
minimo = true

%Inicio do código
for it = [1:maxit]
  B = A(:, base)
  xB = inv(B)*b
  lambdat = c(base)' * inv(B)
  ctil = c' - lambdat*A
  
  %Laço que plota todos os resultados de x
  for i = [1:length(c)]
    for j = [1:length(base)]
      if(i == base(j))
        x(it, i) = xB(j)
      endif
    endfor
  endfor

  %Condicional de ctil
  if (minimo)
    menor = 0
    for i = [1:length(ctil)]
      if (ctil(i) < menor)
        menor = ctil(i)
        k = i
      endif
    endfor
  else
    maior = 0
    for i = [1:length(ctil)]
      if (ctil(i) > maior)
        maior = ctil(i)
        k = i
      endif
    endfor
  endif
    
  if ((menor == 0 && minimo) || (maior == 0 && !minimo))
    break
  endif
  
  %Teste da razão
  y = inv(B)*A(:,k)
  r = xB ./ y
  
  menor = inf
  for i = [1:length(r)]
    if (r(i) < menor && r(i) >= 0)
      menor = r(i)
      l = i
    endif
  endfor
  base(l) = k
endfor