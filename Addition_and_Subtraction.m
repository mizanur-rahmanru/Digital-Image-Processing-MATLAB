clc; 
clear all; 
close all; 
img1 = imread('image1.jpg'); 
img2 = imread('image2.jpg'); 

[rows,cols,channels] = size(img1); 
 
img2 = imresize(img2,[rows,cols]); 
% Convert to double 
img1 = double(img1); 
img2 = double(img2); 
% Create output matrices 
add = zeros(rows,cols,channels,'double'); 
sub = zeros(rows,cols,channels,'double'); 
% Addition and Subtraction 
for i = 1:rows 
for j = 1:cols 
for k = 1:3 
% Addition 
add_val = img1(i,j,k) + img2(i,j,k); 
if add_val > 255 
add(i,j,k) = 255; 
else 
add(i,j,k) = add_val; 
end 
% Subtraction 
sub_val = img1(i,j,k) - img2(i,j,k); 
if sub_val < 0 
sub(i,j,k) = 0; 
else 
sub(i,j,k) = sub_val; 
end 
end 
end 
end 
% Display 
figure; 
subplot(221); 
imshow(uint8(img1)); 
title('Original Image 1'); 
subplot(222); 
imshow(uint8(img2)); 
title('Original Image 2'); 
subplot(223); 
imshow(uint8(add)); 
title('Addition Result'); 
subplot(224); 
imshow(uint8(sub)); 
title('Subtraction Result');