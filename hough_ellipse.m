# ========================================================================================= 
# Author: Andre A. Boechat
# File: hough_ellipse.m
# Date: February 27, 2014, 10:12:22 AM
# Description: Implementation of the classical Hough Transform algorithm to detect 
# ellipses.
# 
# Reference: 
# http://en.wikipedia.org/wiki/Hough_transform
# http://en.wikipedia.org/wiki/Randomized_Hough_transform
# ========================================================================================= 
#
# Using the following general equation to define an ellipse:
# ax^2 + by^2 + cx + dy + e = 0


function [a, b, c, d, e] = hough_ellipse(img)

    [width height] = size(img);
    %%% Defining the possible values for each variable of the ellipse equation.
    %% Function to generate the sequence of values for a variable, where v is a
    %% vector with all not quantized values.
    vals_generator = @(fn, v) unique(fn(v));
    %% Function to quantize a value by a factor.
    qfac = 16;
    quantization = @(x) floor(x/qfac)*qfac;
    max_val = max([width height]);
    var_vals = vals_generator(quantization, [-max_val:max_val]);

    vars_len = length(var_vals);
    acc = uint32(zeros(vars_len, vars_len, vars_len, vars_len, vars_len));
    %% Loop over all nonzero pixels of the image.
    [xs ys] = find(img);
    var_idxs = 1:vars_len;
    for xyidx = 1:length(xs)
        x = xs(xyidx);
        y = ys(xyidx);
        for aidx = var_idxs
            for bidx = var_idxs
                for cidx = var_idxs
                    for didx = var_idxs
                        a = var_vals(aidx);
                        b = var_vals(bidx);
                        c = var_vals(cidx);
                        d = var_vals(didx);
                        e = -(a*x^2 + b*y^2 + c*x + d*y);
                        e_quant = quantization(e);
                        %% Calculating the array index of the value e_quant.
                        %% Otherwise, we would need to linearly search for the
                        %% index in the array [-max_val:max_val].
                        zero_idx = ceil(vars_len/2);
                        rel_idx = e_quant/qfac;
                        if e_quant > 0
                            eidx = zero_idx + rel_idx;
                        else 
                            eidx = zero_idx - rel_idx;
                        end 
                        %% Incrementing the score of the corresponding ellipse
                        %% variables.
                        if eidx <= vars_len
                            acc(aidx, bidx, cidx, didx, eidx)++;
                        end
                    end
                end 
            end 
        end 
    end 
    %% Finding the indexes of maximum value. 
%    [maxv, pos] = max(acc(:));
%    [aidx, bidx, cidx, didx, eidx] = ind2sub(size(acc), pos);
%    a = var_vals(aidx);
%    b = var_vals(bidx);
%    c = var_vals(cidx);
%    d = var_vals(didx);
%    e = var_vals(eidx);


