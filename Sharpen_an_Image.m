

clear; clc; close all;

inputImg = imread('cat.jpg'); 

if size(inputImg, 3) == 3
    grayImg = rgb2gray(inputImg); 
else
    grayImg = inputImg;
end

grayImg = double(grayImg); 
[rows, cols] = size(grayImg);
sigma = 1.0;
kernelSize = 3;
halfK = floor(kernelSize / 2);
gaussianKernel = zeros(kernelSize, kernelSize);

for x = -halfK:halfK
    for y = -halfK:halfK
        gaussianKernel(x + halfK + 1, y + halfK + 1) = ...
            exp(-(x^2 + y^2) / (2 * sigma^2));
    end
end

kernelSum = 0;
for m = 1:kernelSize
    for n = 1:kernelSize
        kernelSum = kernelSum + gaussianKernel(m, n);
    end
end

for m = 1:kernelSize
    for n = 1:kernelSize
        gaussianKernel(m, n) = gaussianKernel(m, n) / kernelSum;
    end
end

paddedImg = zeros(rows + 2*halfK, cols + 2*halfK);
for i = 1:rows
    for j = 1:cols
        paddedImg(i + halfK, j + halfK) = grayImg(i, j);
    end
end

blurredImg = zeros(rows, cols);

for i = 1:rows
    for j = 1:cols
        pixelVal = 0;
        for m = 1:kernelSize
            for n = 1:kernelSize
                pixelVal = pixelVal + paddedImg(i + m - 1, j + n - 1) * gaussianKernel(m, n);
            end
        end
        blurredImg(i, j) = pixelVal;
    end
end

highPassDetails = zeros(rows, cols);
sharpenedImg = zeros(rows, cols);
k = 1.5; 

for i = 1:rows
    for j = 1:cols
        
        highPassDetails(i, j) = grayImg(i, j) - blurredImg(i, j);

        val = grayImg(i, j) + (k * highPassDetails(i, j));

        if val > 255
            val = 255;
        elseif val < 0
            val = 0;
        end
        
        sharpenedImg(i, j) = val;
    end
end


figure('Name', 'Image Sharpening Results', 'NumberTitle', 'off');

subplot(1, 3, 1);
imshow(uint8(grayImg));
title('Original Grayscale Image');

subplot(1, 3, 2);
imshow(uint8(blurredImg));
title('Blurred Image (Gaussian)');

subplot(1, 3, 3);
imshow(uint8(sharpenedImg));
title(['Sharpened Image (k = ', num2str(k), ')']);