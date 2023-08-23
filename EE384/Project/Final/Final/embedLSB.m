function watermarkedImage = embedLSB(originalImage, watermarkImage)
    % Load the watermark image (make sure it has the same dimensions as the host image)
    watermarkImage = imresize(watermarkImage, [64, 64]); % Resize the watermark image to a smaller size
    
    if size(originalImage, 3) == 3
        originalImage = my_rgb2gray(originalImage);
    end
    
    if size(watermarkImage, 3) == 3
        watermarkImage = my_rgb2gray(watermarkImage);
    end
    
    % Resize the watermark image to match the host image size
    watermark_image = imresize(watermarkImage, size(originalImage, [1 2]));
    
    % Convert the host and watermark images to double
    host_image = double(originalImage);
    watermark_image = double(watermark_image);
    
    % Scaling the watermark image to have values between 0 and 1
    watermark_image = watermark_image / 255;
    
    % Embedding the watermark into the host image (simple additive watermarking)
    alpha = 0.7; % Watermark strength (adjust this value to control the visibility of the watermark)
    watermarkedImage = host_image + alpha * watermark_image;
    
    % Clipping the pixel values to maintain the range [0, 255]
    watermarkedImage(watermarkedImage < 0) = 0;
    watermarkedImage(watermarkedImage > 255) = 255;
    
    % Convert the watermarked image back to uint8
    watermarkedImage = uint8(watermarkedImage);

    % Display the original image, watermark image, and watermarked image
    figure;
    subplot(2, 2, 1);
    imshow(uint8(host_image));
    title('Original Image');
    subplot(2, 2, 2);
    imshow(watermarkedImage);
    title('Watermarked Image');
    
    watermarkedImage = double(watermarkedImage);
    host_image = double(host_image);
    
    % Extraction of the watermark from the watermarked image
    extracted_watermark = (watermarkedImage - host_image) / alpha;
    
    % Rescaling the extracted watermark to the range [0, 255]
    extracted_watermark = (extracted_watermark - min(extracted_watermark(:))) / (max(extracted_watermark(:)) - min(extracted_watermark(:)));
    extracted_watermark = 255 * extracted_watermark;
    
    % Convert the extracted watermark to uint8
    extracted_watermark = uint8(extracted_watermark);
    
    % Display the extracted watermark
    figure;
    imshow(extracted_watermark);
    title('Extracted Watermark');
    
    % Save the watermarked image
    imwrite(watermarkedImage, 'watermarked_imageLSB.jpg');
end


