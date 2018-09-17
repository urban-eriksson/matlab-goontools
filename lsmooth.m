function ysm = lsmooth(x, y, gamma, reach)
%LSMOOTH Lorentzian smoothing

if nargin < 4
    reach = 3 * gamma;
end

wdensy = weightedldensity(x, y, x, gamma, reach);
wdensx = weightedldensity(x, ones(size(x)), x, gamma, reach);
ysm = wdensy./wdensx;

