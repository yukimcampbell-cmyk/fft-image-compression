function [ P_padded ] = pad15( P )
%PAD15 Pad an RGB image so its dimensions are multiples of 15.
%
%   P_padded = PAD15(P) adds zero-valued rows and columns to the end of
%   the image so that both the number of rows and columns are divisible
%   by 15. This allows the image to be divided into 15-by-15 blocks
%   for block-based Fourier processing.
%
%   Input:
%       P - n-by-m-by-3 RGB image matrix
%
%   Output:
%       P_padded - Zero-padded RGB image matrix whose dimensions are
%                  both multiples of 15.

% Store the original image dimensions.
[rows, columns, ~] = size(P);

% Determine how many rows and columns need to be added to reach the
% next multiple of 15.
extra_rows = mod(15 - mod(rows, 15), 15);
extra_columns = mod(15 - mod(columns, 15), 15);

% Pad the image with zero-valued rows and columns.
P_padded = zeros(rows + extra_rows, columns + extra_columns, 3);

% Copy the original image into the upper-left corner of the padded matrix.
P_padded(1:rows, 1:columns, :) = P;

end
