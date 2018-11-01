# matlab-goontools
Tools for goons. Methods and algorithms which are great when doing scientific programming.

- k-d tree
- density
- Gaussian and Lorentzian smoothing
- interpolation

## k-d tree ##

Lean implementation of k-d tree which can be used in a number of other algorithms, e.g. density.

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


## gdensity & ldensity ##

The density is the workhorse of almost all data analysis, and only imagination sets a limit for the number of use cases. It works a little bit like a histogram but it brings an accuratesse the histogram simply does not have, with its compromise between resolution and partition noise.

First take look at the simple one dimensional density analysis, where the original data points are shown as red dots on the x-axis:

<p align="center"> 
<img src="https://github.com/urban-eriksson/matlab-goontools/blob/master/images/1Ddensity.PNG">
</p>

The density analysis can also be done for any number of dimensions. Here is an example using sample from a two dimensional Gaussian distribution.

<p align="center"> 
<img src="https://github.com/urban-eriksson/matlab-goontools/blob/master/images/multivariate_gaussian.PNG">
</p>

The resulting density calculation can be seen here:

<p align="center"> 
<img src="https://github.com/urban-eriksson/matlab-goontools/blob/master/images/2Ddensity.PNG">
</p>

Run densitydemo.m to generate these samples.

## gsmooth & lsmooth ##

## ginterp & linterp ##
