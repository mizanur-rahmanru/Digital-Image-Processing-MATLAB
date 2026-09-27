%%Log Transformation


clc;
clear all;
close all;

orgImg = imread('cat.jpg');
orgImg = imresize(orgImg, [1600, 1600]);
grayImg = rgb2gray(orgImg);

grayImg = double(grayImg);

c = 255/log(256);
for i= 1:1600;
    for j = 1:1600;
        grayImg(i,j) = c* log(1+grayImg(i,j));
        if grayImg(i,j)>= 255;
            grayImg(i,j) = 255;
        end
    end
end

grayImg=uint8(grayImg);

figure;
subplot(2,1,1);
imshow(orgImg);
title('Original Image');

subplot(2,1,2);
imshow(grayImg);
title('Log Transform Image');
imshow(grayImg);
title('Binary Image');