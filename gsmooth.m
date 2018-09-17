function ysm = gsmooth(x, y, sigma, reach)
%GSMOOTH Gaussian smoothing

if nargin < 4
    reach = 3 * sigma;
end

wdensy = weightedgdensity(x, y, x, sigma, reach);
wdensx = weightedgdensity(x, ones(size(x)), x, sigma, reach);
ysm = wdensy./wdensx;

