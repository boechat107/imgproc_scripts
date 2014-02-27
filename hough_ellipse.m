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
# a(x - p)^2 + 2b(x - p)(y - q) + c(y - q)^2 + 1 = 0
# with the restriction
# ac - b^2 > 0 or c > b^2 / a


function [] = hough_ellipse(img)

    [width height] = size(img);
    %%% Defining the possible values for each variable of the ellipse equation.
    %% Function to generate the sequence of values for a variable, where v is a
    %% vector with all not quantized values.
    vals_generator = @(fn, v) unique(fn(v));
    %% Function to quantize a value by a factor.
    quantization = @(x, fac) floor(x/fac)*fac;
    %% Quantization for p and q.
    quant_pq = @(x) quantization(x, 2);
    p_vals = vals_generator(quant_pq, [-width:width]);
    q_vals = vals_generator(quant_pq, [-height:height]);
    %% Quantization for a, b and c
    quant_abc = @(x) quantization(x, 4);
    max_val = max([width height]);
    abc_vals = vals_generator(quant_abc, [-max_val:max_val]);

    abc_len = length(abc_vals);
    acc = zeros(length(p), length(q), abc_len, abc_len, abc_len);
    %% Loop over all nonzero pixels of the image.
    [xs ys] = find(img);
    for x = xs
        for y = ys
            


