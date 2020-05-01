%
% Anirban Bhattacharya, ESE 558, 2/15/2019, ECE, SBU
%
%    Circular Convolution
%
M=input('Enter M : ');
N=input('Enter N : ');
f=zeros(M,N);
h=zeros(M,N);
for m= 1 : M
    for n=1:N
        f(m,n)=rand() * 100;
    end
end
f
for m = 1 : M
    for n = 1 : N
        h(m,n) = rand() * 100;
    end
end
h
% f;  % print f
% h;
g=zeros(M,N);
for u = 1 : M
    for v = 1 : N
        for m = 1 : M
            for n = 1 : N
                g(u,v) = g(u,v) + (f(m,n) * h(mod(u-m+M, M)+1, mod(v-n+N, N)+1));
            end
        end
    end
end
g