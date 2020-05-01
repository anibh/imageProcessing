%
% Anirban Bhattacharya, ESE 558, 2/15/2019, ECE, SBU
%
%    Frequency Domain Filtering Using Fourier Transform
%
M=input('Enter M : ');
N=input('Enter N : ');
inp=zeros(M,N);
f1=zeros(M,M);
f2=zeros(N,N);
for m= 1 : M
    for n=1:N
        inp(m,n)=rand();
    end
end
figure
imshow(inp);
title('Gray level random generated image');
for m = 1 : M
   for u = 1 : M
       f1(u,m) = (cos(-(2*pi*u*m)/M) + 1i*(sin(-(2*pi*u*m)/M)))/M;
   end
end
for n = 1 : N
   for v = 1 : N
       f2(v,n) = (cos(-(2*pi*v*n)/N) + 1i*(sin(-(2*pi*v*n)/N)))/N;
   end
end
f=reshape(inp, M, N);
P=reshape(f1, M, M);
Q=reshape(f2, N, N);
F = P * f * Q;
filter=zeros(M, N);
for u = 1 : M
    for v = 1 : N
        if((u<=5 || u>=M-5) && (v<=5 || v>=N-5))
           filter(u,v) = 0.5;
        else
           filter(u,v) = 1.0;
        end
    end
end
H=reshape(filter, M, N);
G = H.*F;
f3=zeros(M, M);
f4=zeros(N, N);
for m = 1 : M
   for u = 1 : M
       f3(u,m) = cos((2*pi*u*m)/M) + 1i*(sin((2*pi*u*m)/M));
   end
end
for n = 1 : N
   for v = 1 : N
       f4(v,n) = cos((2*pi*v*n)/N) + 1i*(sin((2*pi*v*n)/N));
   end
end
Pp=reshape(f3, M, M);
Qp=reshape(f4, N, N);
g = Pp * G * Qp;
g