## ========================================================================================= 
## Author: Andre A. Boechat
## File: inpainting_test.m
## Date: August 29, 2014, 03:11:13 PM
## Description: Script to test the inpainting.m function. The thick black line of the
## target image is removed using the fast inpainting technique.
## 
## Reference: 
## Oliveira, M., Bowen, B., Richard, M., & Chang, Y. (2001).
## Fast digital image inpainting. Appeared in the Proceedings of the
## International Conference on Visualization, Imaging and Image Processing.
## ========================================================================================= 
function inpainting_test()
    img = imread('resources/2p72g-1408987006084.jpg');
    %figure
    subplot(3,1,1), imshow(img) % debug
    %%% Creating a mask for the black tick line.
    [nr nc d] = size(img);
    mask = zeros(nr, nc);
    %% Pixel indexes of the black tick line.
    blackIdxs = find(img(:,:,1) < 30);
    %% Only the line pixels are white.
    mask(blackIdxs) = 1;
    %% Dilating the region a little bit to include the smooth border of the line.
    mask = imdilate(mask, strel("diamond", 1));
    subplot(3,1,2), imshow(mask) % debug
    tic
    ret = inpainting(img, mask);
    toc
    subplot(3,1,3), imshow(ret) % debug
endfunction
