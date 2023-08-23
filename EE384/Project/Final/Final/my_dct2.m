function D = my_dct2(block)
    % Function to compute the 2D Discrete Cosine Transform (DCT) of a block
    % Input:
    %   block: input 2D block (e.g., 8x8 block)
    % Output:
    %   D: 2D DCT coefficients of the block
    
    [M, N] = size(block);
    D = zeros(M, N);
    
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
            sum_val = 0;
            for x = 1:M
                for y = 1:N
                    sum_val = sum_val + block(x, y) * cos((2*x - 1)*(u-1)*pi/(2*M)) * cos((2*y - 1)*(v-1)*pi/(2*N));
                end
            end
            D(u, v) = alpha_u * alpha_v * sum_val;
        end
    end
end