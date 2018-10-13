function dens = gdensity(data, bins, sigma, reach)
%GDENSITY Gaussian density

if nargin < 4
    reach = 3 * sigma;
end

data_sorted = sort(data);
dens = zeros(size(bins));
sigma2 = sigma^2;
Ndata = length(data);
Nbins = length(bins);
for j = 1:Nbins
    [idx_low, idx_high] = findIndexRange(bins(j) - reach, bins(j) + reach, data_sorted);
    for k = idx_low:idx_high
        dens(j) = dens(j) + exp(-0.5 * (data_sorted(k) - bins(j))^2 / sigma2);
    end
end

dens = 1/(sqrt(2*pi) * sigma * Ndata) * dens;

