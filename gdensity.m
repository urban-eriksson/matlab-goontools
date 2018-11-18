function dens = gdensity(data, bins, sigma, reach)
%GDENSITY Gaussian density

if nargin < 4
    reach = 3 * sigma;
end

if size(data,2) > size(data,1)
    transpose = true;
    data = data';
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
    dens(j) = sum( exp(-0.5 * sum( (data(indices,:) - bins(j,:)).^2 / sigma2, 2) ) );
end

dens = 1/(sqrt(2*pi) * sigma) * dens;

if transpose
    dens = dens';
end