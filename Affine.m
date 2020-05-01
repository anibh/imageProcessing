%
% Prof. Murali Subbarao, ESE 558, 2/9/2019, ECE, SBU
%
%    GEOMETRIC TRANSFORMATION OF IMAGES
%
%    Affine transform and translation
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
 
% change this matrix A for different rotation, scaling, 
% and affine transformation
 
% Affine transform matrix A
% This specifies the transformation that the input image
% must undergo to form the output image
% General form is
%
% A  = [ a11  a12
%       a21   a22 ]
%
% Test input is for rotation , scaling x-axis, and translation T
%
theta=60.0;
A = [ 0.5 * cosd(theta) -sind(theta)
      sind(theta)  cosd(theta) ];
    
T= [ 10 5 ]'; % change this for translations
 
% In Affine transform, straight lines map to 
% straight lines. 
% Therefore, first map corner points (1,1),
% (M,1), (1,N), and (M,N)
 
p = A * [ 1 1 ]' + T; % first corner point
x1=p(1);
y1=p(2);
p= A * [ 1 N ]' + T; % second corner point
x2=p(1);
y2=p(2);
p= A * [ M 1 ]' + T; % third corner point
x3=p(1);
y3=p(2);
p= A * [ M N ]' + T; % fourth corner point
x4=p(1);
y4=p(2);
 
% Determine background image size (excluding translation)
xmin = floor( min( [ x1 x2 x3 x4 ] ));
xmax = ceil( max( [ x1 x2 x3 x4 ] ));
ymin = floor(min( [ y1 y2 y3 y4 ] ));
ymax = ceil(max( [ y1 y2 y3 y4 ] ));
Mp=ceil(xmax-xmin)+1; % number of rows
Np=ceil(ymax-ymin)+1; % number of columns
 
I8=zeros(Mp,Np); % output gray scale image
 
I4=zeros(Mp,Np,3); % output color image

I9=zeros(Mp,Np); % output gray scale image for bilinear

I10=zeros(Mp,Np,3); % output color image for bilinear

I11=zeros(Mp,Np); % output gray scale image for gaussian

I12=zeros(Mp,Np,3); % output color image for gaussian
 
% We need to map position of output image pixels
% to a position in the input image. Therefore, find the
% inverse map.
 
Ap = inv(A);

k = 2;
sigma = 1.0;
G = zeros(2*k+1, 2*k+1); % Gaussian Filter Array
xcenter = k+1;
ycenter = k+1;
for x = -k : k % Gaussian Filter window claculation for given sigma and size
    for y = -k : k
        G(xcenter + x, ycenter + y) = (exp(-(((x*x) + (y*y))/(2*sigma*sigma))))/(2*pi*sigma);                        
    end
end
 
for i = xmin : xmax
    for j = ymin : ymax
        p = Ap * ( [ i j ]' -T );
        
        % coordinates of point where we need to find the
        % image value through interpolation. 
        x0=p(1);
        y0=p(2);
        % coordinates of nearest sample point
 
        xn = round(x0);
        yn = round(y0);
        xc=x0-xn; % (xc,yc) gives the displacement
                  % of filter center h
        yc=y0-yn;
 
        % make sure the nearest point (xn,yn) is within the
        % input image
        
        % coordinates of sample points for bilinear interpolation are
        minx=floor(x0);
        maxx=ceil(x0); 
        miny=floor(y0);
        maxy=ceil(y0);
        dx = x0-minx;
        dy=y0-miny;
        % Sample points for the input image I6 are
        
        % make sure all points are within bounds 
        % like (1<=xn) && (xn<=M) && (1<=yn) && (yn<=N)
        % Interpolate for each RGB channels separately
        % Write the function bilinear below
        
         if( (1<=xn) && (xn<=M) && (1<=yn) && (yn<=N) )
             
             x=round(i-xmin+1);  % shift (xmin, ymin)
                                 % pixel position (1,1)
                                 % in the output image
 
             y=round(j-ymin+1);
 
            % NEAREST NEIGHBOR INTERPOLATION
       
            % copy the values of nearest pixel
            I4(x,y,1)= I6(xn,yn,1);
            I4(x,y,2)= I6(xn,yn,2);
            I4(x,y,3)= I6(xn,yn,3);
            
            I8(x,y)=I7(xn,yn);
            I8(x,y)=I7(xn,yn);
            I8(x,y)=I7(xn,yn);
            
         end
         
         % Bilinear Interpolation
         
         if((1<=minx) && (minx<=M) && (1<=miny) && (miny<=N) && (1<=maxx) && (maxx<=M) && (1<=maxy) && (maxy<=N))
            x=round(i-xmin+1);  % shift (xmin, ymin)
                                 % pixel position (1,1)
                                 % in the output image
 
            y=round(j-ymin+1);
            
            I10(x,y,1) = (dx * ((dy * I6(maxx,maxy,1)) + ((1 - dy) * I6(maxx,miny,1)))) + ((1 - dx) * ((dy * I6(minx,maxy,1)) + ((1 - dy) * I6(minx,miny,1)))); 
            
            I10(x,y,2) = (dx * ((dy * I6(maxx,maxy,2)) + ((1 - dy) * I6(maxx,miny,2)))) + ((1 - dx) * ((dy * I6(minx,maxy,2)) + ((1 - dy) * I6(minx,miny,2))));             
            
            I10(x,y,3) = (dx * ((dy * I6(maxx,maxy,3)) + ((1 - dy) * I6(maxx,miny,3)))) + ((1 - dx) * ((dy * I6(minx,maxy,3)) + ((1 - dy) * I6(minx,miny,3)))); 

            I9(x,y) = (dx * ((dy * I7(maxx,maxy)) + ((1 - dy) * I7(maxx,miny)))) +((1 - dx) * ((dy * I7(minx,maxy)) + ((1 - dy) * I7(minx,miny))));
         end
         
         % Gaussian Interpolation
         
         if( (1<=xn) && (xn<=M) && (1<=yn) && (yn<=N) )
             x=round(i-xmin+1);  % shift (xmin, ymin)
                                 % pixel position (1,1)
                                 % in the output image
 
             y=round(j-ymin+1);
             sum = 0.0;
             normalization_factor = 0.0;
             for m = -k : k
                 for n = -k : k
                     xgauss = k + 1;
                     ygauss = k + 1;
                     xpixel = xn + k;
                     ypixel = yn + k;
                     if((1<=xpixel) && (xpixel<=M) && (1<=ypixel) && (ypixel<=N))
                         sum = sum + (G(xgauss - m, ygauss - n)*I7(xpixel, ypixel));
                         normalization_factor = normalization_factor + G(xgauss - m, ygauss - n);
                     end
                 end
             end
             sum = sum / normalization_factor;
             I11(x,y) = sum;
             
             for l = 1 : 3
                 sum = 0.0;
                normalization_factor = 0.0;
                for m = -k : k
                    for n = -k : k
                        xgauss = k + 1;
                        ygauss = k + 1;
                        xpixel = xn + k;
                        ypixel = yn + k;
                        if((1<=xpixel) && (xpixel<=M) && (1<=ypixel) && (ypixel<=N))
                            sum = sum + (G(xgauss - m, ygauss - n)*I6(xpixel, ypixel, l));
                            normalization_factor = normalization_factor + G(xgauss - m, ygauss - n);
                        end
                    end
                end
                sum = sum / normalization_factor;
                I12(x, y, l) = sum;
             end
             
         end
    end
end
 
%figure
%imshow(I3 , [ 0 255 ]);
%title('I3');
 
figure
imshow(I4);
title('I4 Nearest Neighbor Interpolation (color)');
 
figure
imshow(I8);
title('I8 Nearest Neighbor Interpolation (gray scale)');

figure
imshow(I9);
title('I9 Bilinear Interpolation (gray scale)');

figure
imshow(I10);
title('I10 Bilinear Interpolation (color)');

figure
imshow(I11);
title('I11 Gaussian Interpolation (gray scale)');

figure
imshow(I12);
title('I12 Gaussian Interpolation (color)');
 
 
%pause   %type return to continue 
