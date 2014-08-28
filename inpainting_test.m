function inpainting_test()
    img = imread('resources/2p72g-1408987006084.jpg');
    figure
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
    ret = inpainting(img, mask);
    subplot(3,1,3), imshow(ret) % debug
endfunction

