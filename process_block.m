function [newB, num_zeros] = process_block(B, tol)
%PROCESS_BLOCK Compress a 15-by-15 image block using a 2-D Fourier transform.
%
%   [newB, num_zeros] = PROCESS_BLOCK(B, tol) transforms the image block
%   into the frequency domain, removes Fourier coefficients whose
%   magnitudes are below the specified tolerance, and reconstructs the
%   compressed image using the inverse Fourier transform.
%
%   Inputs:
%       B - 15-by-15 image block
%       tol - Non-negative threshold for Fourier coefficients
%
%   Outputs:
%       newB - Reconstructed 15-by-15 image block as a uint8 matrix
%       num_zeros - Number of zero-valued Fourier coefficients after
%                   compression

% Transform the image block from the spatial domain to the frequency
% domain using the 2-D discrete Fourier transform.
F = fft2(double(B));

% Calculate the magnitude of each Fourier coefficient and create a mask
% that keeps coefficients whose magnitude is at least the tolerance.
coefficient_magnitude = abs(F);
mask = coefficient_magnitude >= tol;

% Set Fourier coefficients below the tolerance to zero.
compressedF = F .* mask;

% Transform the compressed coefficients back to the spatial domain.
% Limit the reconstructed pixel values to the valid range of 0-255 and
% convert the result to an 8-bit integer image.
newB = uint8(min(max(real(ifft2(compressedF)), 0), 255));

% Count the number of zero-valued coefficients after compression.
num_zeros = sum(compressedF(:) == 0);

end