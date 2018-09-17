function yi = linterp(x, y, xi, gamma, reach)
%LINTERP Lorentzian interpolation

if nargin < 5
    reach = 3 * gamma;
end

wdensy = weightedldensity(x, y, xi, gamma, reach);
wdensx = weightedldensity(x, ones(size(x)), xi, gamma, reach);
yi = wdensy./wdensx;

