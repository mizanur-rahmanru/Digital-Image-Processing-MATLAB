%% Zooming and Shrinking
clc;
close all;
clear all;

orgImg = imread('cat.jpg');
orgImg = imresize(orgImg, [1600, 1600]);
grayImg = rgb2gray(orgImg);

grayImg = double(grayImg);

%% Image Zooming
zoom = 2;
zoomImg = zeros(3200,3200);
for i = 1:3200
    for j = 1:3200
        old_i = ceil(i/zoom);
        old_j = ceil(j/zoom);   
        
        zoomImg(i,j) = grayImg(old_i, old_j);
    end 
end

%% Shrinking
shrink = 0.5;
shrinkImg = zeros(800,800);

for i = 1:800
    for j = 1:800
        old_i = ceil(i/shrink);
        old_j = ceil(j/shrink);
        
        shrinkImg(i,j) = grayImg(old_i, old_j);
    end
end

%% Conversion
zoomImg = uint8(zoomImg);
shrinkImg = uint8(shrinkImg);
grayImg = uint8(grayImg);

%% Plot

figure;

subplot(1,3,1);
imshow(orgImg);
title('Original');

subplot(1,3,2);
imshow(zoomImg);
xlim([800 1600]);
ylim([800 1600]);
title('Zoomed');

subplot(1,3,3);

% Create 1600x1600 empty image
shrinkDisplay = zeros(1600,1600);

% Put 800x800 shrunk image at the center
shrinkDisplay(401:1200,401:1200) = shrinkImg;

imshow(uint8(shrinkDisplay));
title('Shrunk');
