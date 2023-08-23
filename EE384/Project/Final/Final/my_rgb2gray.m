function grayImage = my_rgb2gray(A)

    grayImage = 0.3 * A(:,:,1) + 0.6*A(:,:,2) + 0.1 *A(:,:,3);   %equation for function
end