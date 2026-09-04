function plot_images(image_file)
%PLOT_IMAGES Display an image at several Fourier compression levels.
%
%   PLOT_IMAGES(image_file) displays the original image alongside
%   versions compressed to approximately 50%, 80%, and 95% by
%   removing small Fourier coefficients.
%
%   Input:
%       image_file - Name of a JPG/JPEG image file in the current folder.

% Read the original image.
P = imread(image_file);

% Display the original image.
subplot(2,2,1);
image(P);
title('Original Image');
axis off;

% Compress the image to approximately 50%.
tol50 = 14.815;
[cP50, comp50] = compress_image(P, tol50);

subplot(2,2,2);
image(cP50);
title(sprintf('Compression Rate: %.1f%%', comp50));
axis off;

% Compress the image to approximately 80%.
tol80 = 52.95;
[cP80, comp80] = compress_image(P, tol80);

subplot(2,2,3);
image(cP80);
title(sprintf('Compression Rate: %.1f%%', comp80));
axis off;

% Compress the image to approximately 95%.
tol95 = 218.7;
[cP95, comp95] = compress_image(P, tol95);

subplot(2,2,4);
image(cP95);
title(sprintf('Compression Rate: %.1f%%', comp95));
axis off;

end