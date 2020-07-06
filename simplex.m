% Para o programa funcionar corretamente inicialmente
%é necessário definir as constantes do problema.
% Caso seu problema seja de minimização, atribua
%true para a variável mínimo, se for de máximo,
%atribua false

A = [2 1 1 0 ; 3 2 0 -1]
b = [4; 5]
c = [1; 1; -10000; 0]
base = [3 4]
maxit = 10
minimo = false
%Valores abaixo não devem ser alterados
x = zeros(maxit,length(c))
menor = 0
maior = 0
ilim = false

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
  
  ilim = true
  for i = [1:length(r)]
    if y(i) > 0
      ilim = false
    endif
  endfor
  
  %Verifica se o problema é ilimitado, é se todos os valores forem pra inf
  if ilim
    printf("Problema tem solução ilimitada")
    break
  endif
    
  menor = inf
  for i = [1:length(r)]
    if (r(i) < menor && y(i) >= 0)
      menor = r(i)
      l = i
    endif
  endfor
  base(l) = k
endfor