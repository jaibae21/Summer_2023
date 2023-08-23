function ssim_value = calculateSSIM(originalImage, watermarkedImage)
    % Parameters for SSIM calculation
    K1 = 0.01;
    K2 = 0.03;

    % Compute means of the images
    mu_x = mean(originalImage(:));
    mu_y = mean(watermarkedImage(:));

    % Compute variances of the images
    sigma_x_sq = var(originalImage(:), 1);
    sigma_y_sq = var(watermarkedImage(:), 1);

    % Compute covariance
    cov_xy = cov(originalImage(:), watermarkedImage(:));

    % Compute SSIM
    C1 = (K1 * 255)^2;
    C2 = (K2 * 255)^2;

    numerator = (2 * mu_x * mu_y + C1) * (2 * cov_xy(1, 2) + C2);
    denominator = (mu_x^2 + mu_y^2 + C1) * (sigma_x_sq + sigma_y_sq + C2);

    ssim_value = numerator / denominator;
end
