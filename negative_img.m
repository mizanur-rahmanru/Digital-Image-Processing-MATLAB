%%Negative Image

clc;
clear all;
close all;
orgImg = imread('cat.jpg');
orgImg = imresize(orgImg, [1000, 1000]);
grayImg = rgb2gray(orgImg);
for i= 1:1000
    for j = 1:1000
        grayImg(i,j) = 255-grayImg(i,j);
    end
end
figure;
subplot(2,1,1);
imshow(orgImg);
title('Original Image');

subplot(2,1,2);
imshow(grayImg);
title('Negative Img');