# Image processing scripts

Octave or Python scripts to solve some image processing problems. The scripts are
just a practice to learn some basic techniques or a first and easier implementation 
of more complex ones.

Implemented techniques:

* ellipse detection

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

## References

[1] Y. Xie and Q. Ji, "A new efficient ellipse detection method", Pattern Recognition, 2002. Proceedings. 16th, vol. 2, pp. 957–960, 2002.
