## ========================================================================================= 
## Author: Andre A. Boechat
## File: inpainting.m
## Date: August 29, 2014, 03:06:33 PM
## Description: Implementation of a fast inpainting technique.
## 
## Reference: 
## Oliveira, M., Bowen, B., Richard, M., & Chang, Y. (2001).
## Fast digital image inpainting. Appeared in the Proceedings of the
## International Conference on Visualization, Imaging and Image Processing.
## ========================================================================================= 
## 
## Usage:
## [RET] = inpainting(IMG, MASK, TOL = .1)
## 
##     IMG is the input image (gray scale or color).
##     MASK is the mask image containing the region of interest (1 values).
##     TOL is the tolerance of the roi's difference between 2 successive iterations.
## 

function [out] = inpainting(img, mask, tol=.1)
    [nrows ncols nch] = size(img);
    %% Checking if the image and the mask have the same size.
    assert([nrows ncols] == size(mask),
            "The image and mask must have the same size");
    %% Diffusion kernels.
    a = .073235;
    b = .176765;
    c = .125;
    kernel1 = [a b a; b 0 b; a b a];
    kernel2 = [c c c; c 0 c; c c c];
    %% Eventual multiple dimensional mask to help some operations with the image's
    %% roi.
    mmask = repmat(mask, [1 1 nch]);
    mmaskIdxs = find(mmask);
    %% Removing color information of the mask pixels from the image.
    out = img .* (1 - mmask);
    %% Diffusion iteration.
    maskDiff = Inf;
    while maskDiff > tol
        tempImg = imfilter(out, kernel1, "conv");
        %% Calculating the roi's difference between 2 successive iterations.
        maskDiff = mean(abs(
                    %% We need to use something bigger than the int8 of the images
                    %% because we need to handle possible negative numbers here.
                    int16(out(mmaskIdxs)) - int16(tempImg(mmaskIdxs))));
        out(mmaskIdxs) = tempImg(mmaskIdxs);
    endwhile
endfunction
