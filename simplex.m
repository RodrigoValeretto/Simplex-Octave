A = [1 1 1 0 0; 1 -1 0 1 0; -1 1 0 0 1]
b = [6; 4; 4]
c = [-1; -2; 0; 0; 0]
base = [3 4 5]
maxit = 20
it = 1
x = zeros(maxit,length(c))

while(it <= maxit)
  B = A(:, base)
  xB = inv(B)*b
  lambdat = c(base)' * inv(B)
  ctil = c' - lambdat*A
  
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
  it++
endwhile