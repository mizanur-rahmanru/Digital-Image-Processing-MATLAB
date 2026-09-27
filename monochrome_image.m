%%Monochrome Image

clc;
clear all;
close all;

orgImg = imread('cat.jpg');
orgImg = imresize(orgImg, [1600, 1600]);

grayImg = rgb2gray(orgImg);
threshold = 128;
for i = 1:1600
    for j = 1:1600
        if grayImg(i,j)>=threshold;
            grayImg(i,j)= 255;
        else
            grayImg(i,j)=0;
        end
    end
end

figure;
subplot(2,1,1);
imshow(orgImg);
title('Original Image');

subplot(2,1,2);
imshow(grayImg);
title('Binary Image');