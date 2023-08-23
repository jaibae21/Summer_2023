% Jaiden Gann
% 8/3/23
% Watermarking System

clc;clear;close all;

fprintf("Watermarking System\n\n");
fprintf("To use make sure the images you want to be watermarked are in the folder images\n\n");

% Load the original image and watermark image
fprintf("Select the image to watermark\n")
[filename,folderPath] = uigetfile({'*.jpg'; '*.png'; '*.bmp'});
if filename == 0
    disp('No file selected. Watermarking canceled.');
end
originalImage = imread(fullfile(folderPath, filename));

fprintf("Select the image to use as a watermark\n")
[filename2,folderPath2] = uigetfile({'*.jpg'; '*.png'; '*.bmp'});
watermarkImage = imread(fullfile(folderPath2, filename2));

% Ask for method to be used
method = input("What method of watermarking would you like to use?\n LSB, DCT:  ", 's');
%method = 'lsb'; % for publishing

% Run the embedding process
switch lower(method)
    case 'lsb'
        tic;
        watermarkedImage = embedLSB(originalImage, watermarkImage);
        timeElapsedLSB = toc;
        fprintf("Time taken for LSB: %.4f\n", timeElapsedLSB);
    case 'dct'
        tic;
        watermarkedImage = embedDCT(originalImage, watermarkImage);
        timeElapsedDCT = toc;
        fprintf("Time taken for DCT: %.4f\n", timeElapsedDCT);
    otherwise
        error('Inavlid watermarking method. Support methods are: LSB and DCT')
end

% Calculate PSNR
switch lower(method)
    case 'lsb'
        % Make images doubles for calculations
        watermarkedImage = double(watermarkedImage);
        originalImage = double(originalImage);
        % Mean Squared Error - metric of distortion
        MSE_LSB = sum(sum(sum((originalImage - watermarkedImage).^2))) / numel(originalImage);
        PSNR_LSB = 10 * log10(255^2 / MSE_LSB); %higher PSNR = better image quality
        fprintf("PSNR for LSB: %.2f dB\n", PSNR_LSB);
    case 'dct'
        % Make images doubles for calculations
        watermarkedImage = double(watermarkedImage);
        originalImage = double(originalImage);

        watermarkedImageDCT = idct2(watermarkedImage);   %reconstruct watermarked image from DCT coefficients
        MSE_DCT = sum(sum(sum((originalImage - watermarkedImageDCT).^2))) / numel(originalImage);
        PSNR_DCT = 10*log10(255^2 / MSE_DCT);
        fprintf("PSNR for DCT: %.2f dB\n", PSNR_DCT);
    otherwise
        error('Invalid watermarking method. Supported methods are LSB and DCT')
end

switch lower(method)
    case 'lsb'
        originalImage = my_rgb2gray(originalImage);
		watermarkedImage = imresize(watermarkedImage, size(originalImage, [1,2])); % Resize
        SSIM_LSB = calculateSSIM(originalImage, watermarkedImage);
        fprintf("SSIM for LSB: %.4f\n", SSIM_LSB);
    case 'dct'
        originalImage = my_rgb2gray(originalImage);
        watermarkedImageDCT = idct2(watermarkedImage);
		watermarkedImageDCT = imresize(watermarkedImageDCT, size(originalImage, [1,2])); % Resize DCT coefficients
        SSIM_DCT = calculateSSIM(originalImage, watermarkedImageDCT);
        fprintf("SSIM for DCT: %.4f\n", SSIM_DCT);
    otherwise
        error('Invalid watermarking method. Supported methods are LSB and DCT');
end
%% Functions
%% RGB to Gray Scale Funciton
%
% <include>my_rgb2gray.m</include>
%
%% embedLSB Funciton
%
% <include>embedLSB.m</include>
%
%% embedDCT Funciton
%
% <include>embedDCT.m</include>
%
%% calculateSSIM Funciton
%
% <include>calculateSSIM.m</include>
%