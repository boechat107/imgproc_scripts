## ========================================================================================= 
## Author: Andre A. Boechat
## File: baseline_removal.m
## Date: July 01, 2014, 09:29:58 AM
## Description: Implementation of the baseline removal technique described in [1]. This
## technique uses gray-level morphological operations to remove baselines without
## losing too much information about the characters.
## 
## Reference: 
## [1] Ye, X., Cheriet, M., Suen, C., & Liu, K. (1999). Extraction of bankcheck items by
## mathematical morphology. International Journal on Document …, 2(2-3), 53–66.
## doi:10.1007/s100320050037
## ========================================================================================= 
##
## Usage:
## [OUT_IMG] = baseline_removal(IMG, MIN_LEN, THICK)
## 
## [OUT_IMG] = baseline_removal(IMG, MIN_LEN, THICK, ANG = 0)
## 
##     IMG is the gray-level input image.
##     MIN_LEN is the minimum length of the baselines.
##     THICK is the height of the thickest part of the baselines.
##     ANG (optional) can be used to remove lines in any direction and gives the angle 
##         from X-axis to X-Y projection of the line.
## 
##     OUT_IMG is the image result of the function.

function [out_img] = baseline_removal(img, min_len, thick, ang = 0)

    %% The input image must be in gray scale.
    assert(isgray(img), "The input image must be in gray scale");
    %% Definition of the linear structuring elements.
    hse = strel("line", min_len, ang);
    vse = strel("line", thick, ang + 90);
    %% Main steps of the algorithm.
    f1 = imclose(img, hse);
    f2 = imclose(f1, vse);
    f3 = f2 - f1;
    out_img = img + f3;
endfunction
