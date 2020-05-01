%
% Anirban Bhattacharya, ESE 558, 2/9/2019, ECE, SBU
%
%    K-Nearest Neighbors Filter for Noise removal
%
%Read an RGB image color image 'LeftCam1.JPG'.
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
I8 = imnoise(I7, 'salt & pepper');
I9 = zeros(M, N);
% I10 = zeros(M, N, 3);

P = 1; Q = 1;
% filter size definition
total = (2*P + 1)*(2*Q + 1);
neighbors = 4;
for m = 0 : M - 1
   for n = 0 : N - 1
      r = 1;
      med = zeros(1, (total));
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
            med(1,r) = I8(k + 1, l + 1) - I8(m + 1, n + 1);
            r = r + 1;
         end
      end
      med = sort(med, 'ComparisonMethod', 'abs');
      count = 0;
      for i = 1:neighbors
          count = count + med(1, i + 1) + I8(m + 1, n + 1);
      end
      I9(m + 1, n + 1) = count / neighbors;
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
