# Image processing scripts

Octave or Python scripts to solve some image processing problems. The scripts are
just a practice to learn some basic techniques or a first and easier implementation 
of more complex ones.

Implemented techniques:

* ellipse detection
* baseline removal
* fast inpainting

## Ellipse detection 

The implemented algorithm is based on 
[[1]](http://scholar.google.com/scholar?cluster=3258739622664696123&hl=en&as_sdt=0,5&as_vis=1),
an efficient application of the classical 
[Hough Transform](http://en.wikipedia.org/wiki/Hough_transform) technique to detect 
ellipses on an image. The main problem of the usage of the normal Hough Transform for
ellipse detection is the necessary high dimensional accumulator to store the 
parameters' votes, since the general equation of an ellipse is composed of
5 variables: the center point [*x0* *y0*], the minor and major half-lengths *a* and
*b*, and the rotation angle (check this 
[here](http://www.maa.org/external_archive/joma/Volume8/Kalman/General.html)).
Xie's implementation makes some assumptions and can find all parameters with great
accuracy using just a 1D accumulator. The complexity is
![O3](http://latex.codecogs.com/gif.latex?O%28n%5E3%29) in the number of nonzero
pixels of the image.

To test the algorithm, we can run the following code on Octave:

```matlab
octave:1> img = imread ('resources/ellipse.png');
octave:2> par = hough_ellipse(img)
par =

   1.1050e+02   7.4500e+01   8.2514e+01   3.7000e+01   1.8180e-02

octave:3> imshow (img)
octave:4> hold on
octave:5> drawEllipse(110.5, 74.5, 82.5, 37, 0)
```

A window should pop and show a blue ellipse (estimated) over a white one (original).

## Baseline removal 

The implemented algorithm is used to remove baselines of bank checks and can be found
in 
[[2]](http://www.ee.bgu.ac.il/~dinstein/stip2002/Seminar_papers/Hershkovitz_Extraction%20of%20bankcheck.pdf).
It is based on mathematical morphological operations in gray-level and the author claims
that it preserves better the differences between the baselines and handwritings and 
generates smoother boundaries than binary operations.

The code here was generalized to be able to remove straight lines in any direction on 
gray scale images.

The algorithm can be tested using the following lines in Octave:

```matlab 
octave> img = imread('resources/dut.jpg');
octave> gray = rgb2gray (img);
octave> h_img = baseline_removal(gray, 20, 3);
octave> v_img = baseline_removal(gray, 20, 3, 90);
octave> subplot(1,3,1), imshow(gray)
octave> subplot(1,3,2), imshow(h_img)
octave> subplot(1,3,3), imshow(v_img)
```

## Fast inpainting

The [*inpainting*](http://www.rabbitmq.com/tutorials/tutorial-two-python.html)
technique aims to reconstruct damaged or missing parts of an image.
The implemented technique is described in [3] and seems to be a good start on
the field because of its simplicity.

The script `inpainting_test.m` can be run to see an example.

```matlab
octave:1> inpainting_test
warning: your version of GraphicsMagick limits images to 8 bits per pixel
Elapsed time is 0.0892851 seconds.
```

![example](https://github.com/boechat107/imgproc_scripts/blob/master/resources/inpaint_ex.png)

[Here](https://sites.google.com/site/rexstribeofimageprocessing/Home/image-inpainting)
there are more examples of the usage of this technique.

## References

[1] Y. Xie and Q. Ji, "A new efficient ellipse detection method", Pattern Recognition, 2002. Proceedings. 16th, vol. 2, pp. 957–960, 2002.

[2] Ye, X., Cheriet, M., Suen, C., & Liu, K. (1999). Extraction of bankcheck items by mathematical morphology. International Journal on Document …, 2(2-3), 53–66. doi:10.1007/s100320050037

[3] Oliveira, M., Bowen, B., Richard, M., & Chang, Y. (2001). Fast digital image inpainting. Appeared in the Proceedings of the International Conference on Visualization, Imaging and Image Processing, (Viip).


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/boechat107/imgproc_scripts/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

