% Para o programa funcionar corretamente inicialmente
%é necessário definir as constantes do problema.
% Esse prog resolve problemas de minimização, portanto
%caso o problema seja de maximização, basta multiplicar
%a func objetivo por -1.
A = [1 1 1 0 0; -1 1 0 1 0; 1 0 0 0 1]
b = [6; 2; 5]
c = [-1; -2; 0; 0; 0]
base = [3 4 5]
maxit = 5
x = zeros(maxit,length(c))

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
  menor = 0
  for i = [1:length(ctil)]
    if (ctil(i) < menor)
      menor = ctil(i)
      k = i
    endif
  endfor
  
  if (menor == 0)
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