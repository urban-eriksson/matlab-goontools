function yi = ginterp(x, y, xi, sigma, reach)
%GINTERP Gaussian interpolation

if nargin < 5
    reach = 3 * sigma;
end

wdensy = weightedgdensity(x, y, xi, sigma, reach);
densx = gdensity(x, xi, sigma, reach);
yi = wdensy./densx;

