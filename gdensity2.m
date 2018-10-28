function dens = gdensity2(x,y,z,xbins,ybins,z0,sigma,sigmaz)
%function dens = gdensity2(data, bins, sigma, reach)
%GDENSITY Gaussian density

Ndata = length(x);
Nxbins = length(xbins);
Nybins = length(ybins);
dens = zeros(Nxbins,Nybins);
sigma2 = sigma^2;
sigma2b = (sigma/2)^2;
sigmaz2 = sigmaz^2;
normalization_factor = 1.0 / ( sqrt(2 * pi) * sigma * Ndata )^2;
for j = 1: Nxbins
    for k = 1 : Nybins
        sum = 0;
        for m = 1:Ndata
            dx = (x(m) - xbins(j))^2;
            dy = (y(m) - ybins(k))^2;
            dz = (z(m) - z0)^2;
            sum = sum + exp(-0.5 * (dx / sigma2 + dy / sigma2b + dz / sigmaz2));
        end
        dens(j,k) = normalization_factor * sum;
    end
end
