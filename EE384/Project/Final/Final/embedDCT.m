function watermarkedImage = embedDCT(originalImage,watermarkImage)

% Load the watermark image (make sure it has the same dimensions as the host image)
watermarkImage = imresize(watermarkImage, [64, 64]); % Resize the watermark image to a smaller size

if size(originalImage, 3) == 3
    originalImage = my_rgb2gray(originalImage);
end

if size(watermarkImage, 3) == 3
    watermarkImage = my_rgb2gray(watermarkImage);
end

% Apply DCT to the host image
dctHost = dct2(double(originalImage));

% Apply DCT to the watermark image
dctWatermark = dct2(double(watermarkImage));

alpha = 0.5; % Watermark strength (can be adjusted as needed)

% Embedding process (modification of DC coefficients)
dctHost(1:64, 1:64) = dctHost(1:64, 1:64) + alpha * dctWatermark;

% Inverse DCT to obtain the watermarked image
watermarkedImage = uint8(idct2(dctHost));

figure;
subplot(2, 2, 1);
imshow(originalImage);
title('Original Image');

subplot(2, 2, 2);
imshow(watermarkedImage);
title('Watermarked Image');

% Save the watermarked image
imwrite(watermarkedImage, 'watermarked_imageDCT.jpg');
end

