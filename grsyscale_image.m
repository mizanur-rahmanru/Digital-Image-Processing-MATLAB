%% RGB to Grayscale Image Conversion
clc;
close all;
clear all;

% 1. Read input RGB image
rgbImg = imread('cat.jpg');

% Check if image is 3-channel RGB
if size(rgbImg, 3) == 3
    % 2. Extract Red, Green, and Blue channels
    R = double(rgbImg(:, :, 1));
    G = double(rgbImg(:, :, 2));
    B = double(rgbImg(:, :, 3));

    % 3. Apply Luminance Weighted Formula
    grayImg = 0.2989 * R + 0.5870 * G + 0.1140 * B;

    % 4. Convert back to uint8 data type
    grayImg = uint8(grayImg);
else
    grayImg = rgbImg; % Already grayscale
end

% 5. Display Results
figure('Name', 'RGB to Grayscale Conversion', 'NumberTitle', 'off');

subplot(1, 2, 1);
imshow(rgbImg);
title('Original RGB Image');

subplot(1, 2, 2);
imshow(grayImg);
title('Converted Grayscale Image');