%
% Anirban Bhattacharya, ESE 558, 2/15/2019, ECE, SBU
%
%    General Linear Transform
%
M=input('Enter M : ');
N=input('Enter N : ');
f=zeros(M,N);
h=zeros(M,N,M,N);
for m= 1 : M
    for n=1:N
        f(m,n)= rand() * 100;
    end
end
f
for m = 1 : M
    for n = 1 : N
        for u = 1 : M
            for v = 1 : N
                h(m,n,u,v) = rand() * 100;                
            end
        end
    end
end
h
g=zeros(M,N);
for u = 1 : M
    for v = 1 : N
        for m = 1 : M
            for n = 1 : N
                g(u,v) = g(u,v) + (h(u,v,m,n) * f(m,n));
            end
        end
    end
end
g
