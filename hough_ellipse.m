# ========================================================================================= 
# Author: Andre A. Boechat
# File: hough_ellipse.m
# Date: February 27, 2014, 10:12:22 AM
# Description: Implementation of the classical Hough Transform algorithm to detect 
# ellipses.
# 
# Reference: 
# [1] Y. Xie and Q. Ji, “A new efficient ellipse detection method,” Pattern
# Recognition, 2002. Proceedings. 16th …, vol. 2, pp. 957–960, 2002.
#
# [2] http://en.wikipedia.org/wiki/Hough_transform
# [3] http://en.wikipedia.org/wiki/Randomized_Hough_transform
# ========================================================================================= 
#
# Using the following general equation to define an ellipse:
# ax^2 + by^2 + cx + dy + e = 0


function [parameters] = hough_ellipse(img)

    MIN_MAJOR_DISTANCE = 10;
    MIN_VOTES = 5;
    [width height] = size(img);
    %% Finding all nonzero pixels of the image, possible ellipse's pixels.
    [xs ys] = find(img);
    pixels = [xs ys];
    %% Function to calculate the Euclidean distance between two points.
    distance = @(p1, p2) sqrt((p1(1) - p2(1))^2 + (p1(2) - p2(2))^2);
    %% ij1, ij2 are indexes of (x1, y1) and (x2, y2), following the reference [1].
    for ij1 = 1:(length(xs)-1)
        for ij2 = (ij1+1):length(xs)
            x1 = pixels(ij1, 1);
            y1 = pixels(ij1, 2);
            x2 = pixels(ij2, 1);
            y2 = pixels(ij2, 2);
            d12 = distance([x1 y1], [x2 y2]);
            %% Accumulator for the minor axis' half-length.
            acc = sparse(1, max(width, height)/2);
            if  d12 > MIN_MAJOR_DISTANCE
                %% Center
                x0 = (x1 + x2)/2;
                y0 = (y1 + y2)/2;
                %% Half-length of the major axis.
                a = d12/2;
                %% Orientation.
                alpha = atan((y2 - y1)/(x2 - x1));
                %% Distances between the two points and the center.
                d01 = distance([x1 y1], [x0 y0]);
                d02 = distance([x2 y2], [x0 y0]);
                for ij3 = 1:length(xs)
                    %% The third point must be a different point, obviously.
                    if (ij3 != ij1) && (ij3 != ij2)
                        continue;
                    endif 
                    x3 = pixels(ij3, 1);
                    y3 = pixels(ij3, 2);
                    d03 = distance([x3 y3], [x0 y0]);
                    %% Distance f
                    if  d03 < d01
                        f = distance([x3 y3], [x1 y1]);
                    elseif d03 < d02
                        f = distance([x3 y3], [x2 y2]);
                    else 
                        continue;
                    endif
                    %% Estimating the half-length of the minor axis.
                    cos2_tau = ((a^2 + d03^2 - f^2) / (2 * a * d03))^2;
                    sin2_tau = 1 - cos2_tau;
                    b = round(sqrt((a^2 * d03^2 * sin2_tau) /...
                                (a^2 * (-d03^2) * cos2_tau)));
                    %% Changing the score of the accumulator. 
                    acc(b)++;
                endfor
                %% Taking the highest score.
                [sv si] = max(acc);
                if sv > MIN_VOTES 
                    %% Ellipse detected!
                    parameters = [x0 y0 a b alpha];
                    return;
                endif
            endif
        endfor
    endfor
    printf("No ellipses detected!\n");
endfunction

