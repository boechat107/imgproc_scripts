## ========================================================================================= 
## Author: Andre A. Boechat
## File: adaptivesquarethreshold.m
## Date: September 03, 2014, 03:29:28 PM
## Description: 
## Thresholds the image using an adaptive threshold that is computed using a local
## square region centered on each pixel.  The threshold is equal to the average value of
## the surrounding pixels plus the bias.  If down is true then b(x,y) = I(x,y) <= T(x,y)
## + bias ? 1 : 0.  Otherwise b(x,y) = I(x,y) >= T(x,y) + bias ? 0 : 1
## 
## Reference: 
## The adaptiveSquare function of BoofCV
## http://boofcv.org/javadoc/boofcv/alg/filter/binary/ThresholdImageOps.html
## ========================================================================================= 

function [ret] = adaptivesquarethreshold(img, radius, bias)
    meanimg = imfilter(img, fspecial('average', radius));
    thmat = meanimg + ones(size(img))*bias;
    ret = img >= thmat;
endfunction
