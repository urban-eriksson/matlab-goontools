function ysm = gsmooth(x, y, sigma, reach)
%GSMOOTH Gaussian smoothing

if nargin < 4
    reach = 3 * sigma;
end

ysm = ginterp(x, y, x, sigma, reach);
