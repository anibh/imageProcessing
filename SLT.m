%
% Anirban Bhattacharya, ESE 558, 2/15/2019, ECE, SBU
%
%    Separable Linear Transform
%
M=input('Enter M : ');
N=input('Enter N : ');
f=zeros(M,N);
h1=zeros(M,M);
h2=zeros(N,N);
for m= 1 : M
    for n=1:N
        f(m,n)=int8(rand() * 100);
    end
end
f
for m = 1 : M
   for u = 1 : M
       h1(u,m) = rand() * 100;
   end
end
h1
for n = 1 : N
   for v = 1 : N
       h2(v,n) = rand() * 100;
   end
end
h2
% f;  % print f
% h;
g=zeros(M,N);
g1=zeros(M,N);
for m = 1 : M
    for n = 1 : N
        for u = 1 : M
            for v = 1 : N
                g1(m,v) = g1(m,v) + (h2(v,n) * f(m,n));
            end
        end
    end
end
g1
for m = 1 : M
    for n = 1 : N
        for u = 1 : M
            for v = 1 : N
                g(u,v) = g(u,v) + (h1(u,m) * g1(m,v));
            end
        end
    end
end
g
