function dens = ldensity(data, bins, gamma, reach)
%LDENSITY Lorentzian density
%
% gamma defined as in http://mathworld.wolfram.com/LorentzianFunction.html
%

if nargin < 4
    reach = 3 * gamma;
end

data_sorted = sort(data);
dens = zeros(size(bins));
gamma2 = gamma^2;

for j = 1:length(bins)
    [idx_low, idx_high] = findIndexRange(bins(j) - reach, bins(j) + reach, data_sorted);
    for k = idx_low:idx_high
        dens(j) = dens(j) + 1 ./((data_sorted(k) - bins(j))^2 + 0.25 * gamma2);
    end
end

dens = 0.5 / pi * gamma * dens;

