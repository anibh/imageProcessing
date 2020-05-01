%
% Anirban Bhattacharya, ESE 558, 4/3/2020, ECE, SBU
%
%    Cylindrical Blur Function
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
G = zeros(2*k+1, 2*k+1); % Cylindrical Function Array
xcenter = k+1;
ycenter = k+1;
for x = -k : k % Cylindrical function calculation for k
    for y = -k : k
        if (sqrt(x*x + y*y)<= k)
           G(xcenter + x, ycenter + y)=1;
        else
            G(xcenter + x, ycenter + y)=0;
        end
    end
end

for m = 0 : M - 1
   for n = 0 : N - 1
      sum = 0.0;
      sumR = 0.0;
      sumG = 0.0;
      sumB = 0.0;
      norm_factor = 0.0;
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
            sum = sum + G(xcenter + p, ycenter + q)*I7(k + 1, l + 1);
            sumR = sumR + G(xcenter + p, ycenter + q)*I6(k + 1, l + 1, 1);
            sumG = sumG + G(xcenter + p, ycenter + q)*I6(k + 1, l + 1, 2);
            sumB = sumB + G(xcenter + p, ycenter + q)*I6(k + 1, l + 1, 3);
            norm_factor = norm_factor + G(xcenter + p, ycenter + q);
         end
      end
      I9(m + 1, n + 1) = sum / norm_factor;
      I8(m + 1, n + 1, 1) = sumR / norm_factor;
      I8(m + 1, n + 1, 2) = sumG / norm_factor;
      I8(m + 1, n + 1, 3) = sumB / norm_factor;
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
