function [compressedP, compression_rate] = compress_image(P, tol)
%COMPRESS_IMAGE Compress an RGB image using block-based Fourier transforms.
%
%   [compressedP, compression_rate] = COMPRESS_IMAGE(P, tol) divides an
%   RGB image into 15-by-15 blocks, removes Fourier coefficients whose
%   magnitudes are below the specified tolerance, and reconstructs the
%   compressed image.
%
%   Inputs:
%       P - n-by-m-by-3 RGB image matrix
%       tol - Nonnegative threshold for Fourier coefficients
%
%   Outputs:
%       compressedP - Compressed RGB image with the same dimensions
%                         as the original image
%       compression_rate - Percentage of Fourier coefficients set to zero

% Store the original image dimensions so that the padded image can be
% trimmed back to its original size after compression.
[rows, columns, ~] = size(P);

% Pad the image so that its dimensions are multiples of 15, allowing it
% to be divided evenly into 15-by-15 blocks.
paddedP = pad15(P);
[padded_rows, padded_columns, ~] = size(paddedP);

% Initialize the output image and the total number of zero Fourier
% coefficients produced during compression.
compressedP = zeros(padded_rows, padded_columns, 3, 'uint8');
num_zeros = 0;

% Process each colour channel independently.
for colour = 1:3

    % Determine the number of 15-by-15 blocks in each dimension.
    rows_of_15 = padded_rows / 15;
    cols_of_15 = padded_columns / 15;

    % Process each 15-by-15 block.
    for r = 0:rows_of_15-1
        for c = 0:cols_of_15-1

            % Extract the current block from the colour channel.
            block = paddedP(15*r+1:15*r+15, 15*c+1:15*c+15, colour);

            % Compress the block in the frequency domain.
            [compressed_block, zeros_in_block] = process_block(block, tol);

            % Calculate the number of Fourier coefficients removed.
            num_zeros = num_zeros + zeros_in_block;

            % Store the reconstructed block in the output image.
            compressedP(15*r+1:15*r+15, ...
                        15*c+1:15*c+15, colour) = compressed_block;
        end
    end
end

% Remove any padding that was added to the original image.
compressedP = compressedP(1:rows, 1:columns, :);

% Calculate the percentage of Fourier coefficients set to zero.
compression_rate = (num_zeros / (padded_rows * padded_columns * 3)) * 100;

end