clc;
clear;
close all;

%% Read and convert image to grayscale
img = imread('cat.jpg');

if size(img,3) == 3
    img = rgb2gray(img);
end

img = im2double(img);

%% Fourier Transform
F = fft2(img);
F_shift = fftshift(F);

[M, N] = size(img);
[u, v] = meshgrid(1:N, 1:M);

% Center of frequency domain
u0 = floor(N/2) + 1;
v0 = floor(M/2) + 1;

% Distance from center
D = sqrt((u-u0).^2 + (v-v0).^2);

%% Cut-off frequencies
D0 = 30;       % Low/High-pass cutoff
D1 = 20;       % Band-pass lower cutoff
D2 = 60;       % Band-pass upper cutoff

%% 1. LOW-PASS FILTER
H_low = double(D <= D0);

G_low = F_shift .* H_low;
g_low = real(ifft2(ifftshift(G_low)));

%% 2. HIGH-PASS FILTER
H_high = double(D > D0);

G_high = F_shift .* H_high;
g_high = real(ifft2(ifftshift(G_high)));

%% 3. BAND-PASS FILTER
H_band = double(D >= D1 & D <= D2);

G_band = F_shift .* H_band;
g_band = real(ifft2(ifftshift(G_band)));

%% 4. NOTCH FILTER
% Two notch reject points
D_notch1 = sqrt((u-(u0+40)).^2 + (v-(v0+40)).^2);
D_notch2 = sqrt((u-(u0-40)).^2 + (v-(v0-40)).^2);

r = 10;    % Radius of notch

H_notch = ones(M,N);

H_notch(D_notch1 <= r) = 0;
H_notch(D_notch2 <= r) = 0;

G_notch = F_shift .* H_notch;
g_notch = real(ifft2(ifftshift(G_notch)));

%% Normalize output images
g_low   = mat2gray(g_low);
g_high  = mat2gray(g_high);
g_band  = mat2gray(g_band);
g_notch = mat2gray(g_notch);

%% Display results
figure;

subplot(2,3,1);
imshow(img);
title('Original Image');

subplot(2,3,2);
imshow(g_low);
title('Low-Pass Filter');

subplot(2,3,3);
imshow(g_high);
title('High-Pass Filter');

subplot(2,3,4);
imshow(g_band);
title('Band-Pass Filter');

subplot(2,3,5);
imshow(g_notch);
title('Notch Filter');

subplot(2,3,6);
imshow(log(1 + abs(F_shift)), []);
title('Fourier Spectrum');

%% Display filter masks
figure;

subplot(2,2,1);
imshow(H_low, []);
title('Low-Pass Mask');

subplot(2,2,2);
imshow(H_high, []);
title('High-Pass Mask');

subplot(2,2,3);
imshow(H_band, []);
title('Band-Pass Mask');

subplot(2,2,4);
imshow(H_notch, []);
title('Notch Mask');
