clc;
clear;
close all;

% Read the image
img = imread('cat.jpg');

% Convert to grayscale
gray = rgb2gray(img);

% Display original image
figure;
imshow(gray);
title('Original Grayscale Image');

%% Point Detection

% Laplacian mask for point detection
mask = [1 1 1;
        1 -8 1;
        1 1 1];

% Apply mask
point = imfilter(double(gray), mask);

% Take absolute value
point = abs(point);

% Threshold
threshold = 100;
point_detected = point > threshold;

% Display point detection result
figure;
imshow(point_detected);
title('Point Detection');


%% Line Detection

% Horizontal line mask
horizontal = [-1 -1 -1;
               2  2  2;
              -1 -1 -1];

% Vertical line mask
vertical = [-1  2 -1;
            -1  2 -1;
            -1  2 -1];

% +45 degree line mask
diagonal1 = [-1 -1  2;
             -1  2 -1;
              2 -1 -1];

% -45 degree line mask
diagonal2 = [ 2 -1 -1;
             -1  2 -1;
             -1 -1  2];

% Apply filters
H = abs(imfilter(double(gray), horizontal));
V = abs(imfilter(double(gray), vertical));
D1 = abs(imfilter(double(gray), diagonal1));
D2 = abs(imfilter(double(gray), diagonal2));

% Combine all line responses
line_detected = max(max(H,V),max(D1,D2));

% Threshold
threshold = 100;
line_detected = line_detected > threshold;

% Display line detection
figure;
imshow(line_detected);
title('Line Detection');