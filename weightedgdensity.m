function dens = weightedgdensity(data, weights, bins, sigma, reach)
%WEIGHTEDGDENSITY Weighted Gaussian density

if nargin < 5
    reach = 3 * sigma;
end

[data_sorted,idx] = sort(data);
weights_sorted = weights(idx);
dens = zeros(size(bins));
sigma2 = sigma^2;

for j = 1:length(bins)
    [idx_low, idx_high] = findIndexRange(bins(j) - reach, bins(j) + reach, data_sorted);
    for k = idx_low:idx_high
        dens(j) = dens(j) + weights_sorted(k) * exp( -0.5 * (data_sorted(k) - bins(j))^2 / sigma2 );
    end
end

dens = 1/(sqrt(2*pi)*sigma) * dens;

