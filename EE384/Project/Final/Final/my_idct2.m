function block = my_idct2(D)
    % Function to compute the 2D Inverse Discrete Cosine Transform (IDCT) of a block
    % Input:
    %   D: 2D DCT coefficients of the block
    % Output:
    %   block: 2D IDCT of the block (e.g., 8x8 block)
    
    [M, N] = size(D);
    block = zeros(M, N);
    
    for x = 1:M
        for y = 1:N
            sum_val = 0;
            for u = 1:M
                for v = 1:N
                    alpha_u = sqrt(1/M);
                    alpha_v = sqrt(1/N);
                    if u == 1
                        alpha_u = sqrt(1/M)/sqrt(2);
                    end
                    if v == 1
                        alpha_v = sqrt(1/N)/sqrt(2);
                    end
                    sum_val = sum_val + alpha_u * alpha_v * D(u, v) * cos((2*x - 1)*(u-1)*pi/(2*M)) * cos((2*y - 1)*(v-1)*pi/(2*N));
                end
            end
            block(x, y) = sum_val;
        end
    end
end