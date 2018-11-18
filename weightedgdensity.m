function dens = weightedgdensity(data, weights, bins, sigma, reach)
%WEIGHTEDGDENSITY Weighted Gaussian density
% a bin has same number of dimensions as a data
% weights are scalar

if nargin < 5
    reach = 3 * sigma;
end

if size(data,2) > size(data,1)
    transpose = true;
    data = data';
    weights = weights';
    bins = bins';
else
    transpose = false;
end

kd = KDtree(data);
sigma2 = sigma^2;
Nbins = size(bins,1);
dens = zeros(Nbins,1);

for j = 1:Nbins
    indices = kd.neighborhood_indices(bins(j,:),reach);
    dens(j) = sum( weights(indices) .* exp(-0.5 * sum( (data(indices,:) - bins(j,:)).^2 / sigma2, 2) ) );
end

dens = 1/(sqrt(2*pi) * sigma) * dens;

if transpose
    dens = dens';
end

