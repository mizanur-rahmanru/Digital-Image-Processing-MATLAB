% Histogram Equalization
clc;
clear all;
close all;

orgImg = imread('cat.jpg');
orgImg = imresize(orgImg, [512, 512]);
grayImg = rgb2gray(orgImg);

grayImg = double(grayImg);

[M, N] = size(grayImg);
% histogram conversion
histogram = zeros(1,256);
for i = 1:M
    for j = 1:N
        intensity = grayImg(i,j);
        histogram(intensity + 1) = histogram (intensity+1) + 1;
    end
end

%calculate Cumulative histogram
cdf = zeros(1,256);
cdf(1) = histogram(1);

for k = 2:256
    cdf(k) = cdf(k-1) + histogram(k);
end

%calculate equalization mapping
cdf_min = min(cdf>0);
mapping = zeros(1,256);

for k = 1:256
    mapping(k) = round(((cdf(k)-cdf_min)/...
        ((M*N)-cdf_min))*255);
end

% histogram equalization
equalizedImg = zeros(M, N);
for i = 1:M
    for j = 1:N
        intensity = grayImg(i,j);
        equalizedImg(i,j) = mapping(intensity+1);
    end 
end

equalizedImg = uint8(equalizedImg);

equalizedHistogram = zeros(1,256);

for i = 1:M
    for j = 1:N
        
        intensity = equalizedImg(i,j);
        
        equalizedHistogram(intensity + 1) = ...
            equalizedHistogram(intensity + 1) + 1;
        
    end
end

figure;

subplot(2,2,1);
imshow(uint8(grayImg));
title('Original Grayscale Image');

subplot(2,2,2);
bar(0:255, histogram);
title('Original Histogram');
xlabel('Intensity');
ylabel('Frequency');

subplot(2,2,3);
imshow(equalizedImg);
title('Histogram Equalized Image');

subplot(2,2,4);
bar(0:255, equalizedHistogram);
title('Equalized Histogram');
xlabel('Intensity');
ylabel('Frequency');
xlim([0 250]);

