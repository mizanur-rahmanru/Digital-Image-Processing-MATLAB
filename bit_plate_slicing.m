%% Bit Plane Slicing for RGB Color Image (Fixed)
clc;
close all;
clear all;


orgImg = imread('cat.jpg');

figure('Name','Bit-Plane Slicing (RGB)','NumberTitle','off');
subplot(3, 3, 1);
imshow(orgImg);
title('Original RGB Image');

% Loop for 8 bit planes
for k = 1:8
    bit_plane = mod(floor(double(orgImg) / 2^(k-1)), 2);
    subplot(3, 3, k+1);
    imshow(bit_plane);
    title(['Bit Plane ', num2str(k)]);
end