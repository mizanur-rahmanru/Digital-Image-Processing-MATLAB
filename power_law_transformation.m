%power - log transform

clc;
clear all;
close all;

orgImg = imread('cat.jpg');
orgImg = imresize(orgImg, [1600, 1600]);
grayImg = rgb2gray(orgImg);

grayImg = double(grayImg)/255;

gamma = 0.5;
c = 1;
for i = 1:1600
    for j = 1:1600
        grayImg(i,j) = c*(grayImg(i,j)*gamma);
    end
end

figure;
subplot(2,1,1);
imshow(orgImg);
title('Original Image');

subplot(2,1,2);
imshow(grayImg);
title('Power-log Transformed');