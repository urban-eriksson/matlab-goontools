# matlab-goontools
Tools for goons. Methods and algorithms which are great when doing scientific programming.

- k-d tree
- density
- Gaussian and Lorentzian smoothing
- interpolation

## k-d tree ##

Lean implementation of k-d tree which can be used in a number of other algorithms, e.g. density. Ideally the k-d tree can make some algorithms faster by providing points and indices located in a neighborhood of the query point, so that points further away can be disregarded.  

Run kddemo.m to see some example on how it can be used.

<p align="center"> 
<img src="https://github.com/urban-eriksson/matlab-goontools/blob/master/images/KDneighbors.PNG">
</p>

<p align="center"> 
<img src="https://github.com/urban-eriksson/matlab-goontools/blob/master/images/KDnearest.PNG">
</p>

<p align="center"> 
<img src="https://github.com/urban-eriksson/matlab-goontools/blob/master/images/KDrange.PNG">
</p>


## gdensity ##

Gaussian density.

The density is the workhorse of almost all data analysis, and it can be applied to almost any problem. It works a little bit like a histogram but it brings an accuratesse the histogram simply does not have, with its compromise between resolution and partition noise.

First take look at the simple one dimensional density analysis, where the original data points are shown as red dots on the x-axis:

<p align="center"> 
<img src="https://github.com/urban-eriksson/matlab-goontools/blob/master/images/1Ddensity.PNG">
</p>

The density analysis can also be done for an arbitrary number of dimensions. Here is an example using samples taken from a two dimensional Gaussian distribution.

<p align="center"> 
<img src="https://github.com/urban-eriksson/matlab-goontools/blob/master/images/multivariate_gaussian.PNG">
</p>

The resulting density calculation can be seen here:

<p align="center"> 
<img src="https://github.com/urban-eriksson/matlab-goontools/blob/master/images/2Ddensity.PNG">
</p>

Run densitydemo.m to generate these samples.

## gsmooth & ginterp ##

Gaussian smoothing and Gaussian interpolation.

Smoothing is a special case of interpolation where the interpolation points are the same as the coordinates for the original data. The formula for calculating Gaussian interpolation is surprisingly simple:

```
y = Density of x weighted by y / Density of x 
```

The weighted density is similar to the normal density, except that the impact on the density of each sample in x is multiplied by a weight, in this case the values of y.


<p align="center"> 
<img src="https://github.com/urban-eriksson/matlab-goontools/blob/master/images/smoothinterp1.PNG">
</p>


Different sigma can be used to produce varying degree of smoothness

<p align="center"> 
<img src="https://github.com/urban-eriksson/matlab-goontools/blob/master/images/smoothinterp2.PNG">
</p>

Smoothing can be performed also when the number of dimensions is larger than one. Here is a two dimensional Gaussian function:

<p align="center"> 
<img src="https://github.com/urban-eriksson/matlab-goontools/blob/master/images/Gaussian_original.PNG">
</p>

Adding uniform noise:

<p align="center"> 
<img src="https://github.com/urban-eriksson/matlab-goontools/blob/master/images/Gaussian_noise.PNG">
</p>

After performing smoothing:

<p align="center"> 
<img src="https://github.com/urban-eriksson/matlab-goontools/blob/master/images/Gaussian_smooth.PNG">
</p>

These examples have been generated with smooth_interp_demo.m 







