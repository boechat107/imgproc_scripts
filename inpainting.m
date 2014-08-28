function [out] = inpainting(img, mask)
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
    figure
    imshow(out);
    hold on;
    for i = 1:50
        tempImg = imfilter(out, kernel1, "conv");
        maskDiff = mean(mean(abs(out(mmaskIdxs) - tempImg(mmaskIdxs))));
        out(mmaskIdxs) = tempImg(mmaskIdxs);
        imshow(out)
        pause
        %printf("Roi difference: %f\n", maskDiff)
    endfor
    hold off;
endfunction
