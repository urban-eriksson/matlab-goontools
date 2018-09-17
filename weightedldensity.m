function dens = weightedldensity(data, weights, bins, gamma, reach)
%WEIGHTEDLDENSITY Weighted Lorentzian density

if nargin < 5
    reach = 3 * gamma;
end

[data_sorted,idx] = sort(data);
weights_sorted = weights(idx);
dens = zeros(size(bins));
gamma2 = gamma^2;

for j = 1:length(bins)
    [idx_low, idx_high] = findIndexRange(bins(j) - reach, bins(j) + reach, data_sorted);
    for k = idx_low:idx_high
        dens(j) = dens(j) + weights_sorted(k)./((data_sorted(k) - bins(j))^2 + 0.25 * gamma2);
    end
end

dens = 0.5 / pi * gamma * dens;

