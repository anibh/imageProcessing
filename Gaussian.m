%
% Prof. Murali Subbarao, ESE 558, 2/9/2019, ECE, SBU
%
%    Gaussian Blur Function
%
%Read an RGB image color image 'food1.JPG'.
I1 = imread('food1.jpg');
[M, N, C] = size(I1);  % M: Num. of Rows , N : Num. of Columns , C : Num. of color bands= 3
 
figure  % start a new figure
imshow(I1);  % display image of I1 in figure
title('Given image I1');  % title of figure
 
I6 = double(I1)/255.0;
figure  % start a new figure
imshow(I6);  % display image of I1 in figure
title(' Given image I6');  % title of figure
 
I2 = rgb2gray(I1);
 
figure
imshow(I2);
title('Given Image converted to gray scale I2');
 
I7 = double(I2)/255.0;
 
figure
imshow(I7);
title(' Given Image converted to gray scale I7');
 
% I4 = imnoise(I6, 'salt & pepper');
% I8 = imnoise(I7, 'salt & pepper');
I8 = zeros(M, N, 3);
I9 = zeros(M, N);
% I10 = zeros(M, N, 3);

P = 5; Q = 5;
% filter size definition
k = 5;
sigma = 1.0;
G = zeros(2*k+1, 1); % Gaussian Filter Arrays
f = zeros(2*k+1, 1);
center = k+1;
for x = -k : k % Gaussian Filter window claculation for given sigma and size
    G(center + x, 1) = (exp(-((x*x)/(2*sigma*sigma))))/(2*pi*sigma);
end

for m = 0 : M - 1
   for n = 0 : N - 1
      sumy = 0.0;
      sumyR = 0.0;
      sumyG = 0.0;
      sumyB = 0.0;
      norm_factory = 0.0;
      sumx = 0.0;
      sumxR = 0.0;
      sumxG = 0.0;
      sumxB = 0.0;
      norm_factorx = 0.0;
      for p = -P : P
         if(m - p < 0)
             k = abs(m - p);
         elseif(m - p > M - 1)
             k = M - 1 - ((m - p) - (M - 1));
         else
             k = m - p;
         end
         for q = -Q : Q
            if(n - q < 0)
               l = abs(n - q);
            elseif(n - q > N - 1)
                l = N - 1 - ((n - q) - (N - 1));
            else
                l = n - q;
            end
            sumy = sumy + G(center + q, 1)*I7(k + 1, l + 1);
            sumyR = sumyR + G(center + q, 1)*I6(k + 1, l + 1, 1);
            sumyG = sumyG + G(center + q, 1)*I6(k + 1, l + 1, 2);
            sumyB = sumyB + G(center + q, 1)*I6(k + 1, l + 1, 3);
            norm_factory = norm_factory + G(center + q, 1);
         end
         sumx = sumx + G(center + p, 1)*(sumy/norm_factory);
         sumxR = sumxR + G(center + p, 1)*(sumyR/norm_factory);
         sumxG = sumxG + G(center + p, 1)*(sumyG/norm_factory);
         sumxB = sumxB + G(center + p, 1)*(sumyB/norm_factory);
         norm_factorx = norm_factorx + G(center + p, 1);
      end
      I9(m + 1, n + 1) = sumx / norm_factorx;
      I8(m + 1, n + 1, 1) = sumxR / norm_factorx;
      I8(m + 1, n + 1, 2) = sumxG / norm_factorx;
      I8(m + 1, n + 1, 3) = sumxB / norm_factorx;
   end
end

% figure
% imshow(I4);
% title('I4');
 
figure
imshow(I8);
title('I8');

figure
imshow(I9);
title('I9');

% figure
% imshow(I10);
% title('I10'); 
