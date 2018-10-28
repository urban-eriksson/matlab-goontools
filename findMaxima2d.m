function [maxx,maxy] = findMaxima2d(x,y,d)
Nx = length(x);
Ny = length(y);
maxx=[];
maxy=[];

maxd = max(max(d));

for j = 2:Nx-1
    for k = 2:Ny-1
        if  d(j,k)>d(j-1,k-1) && d(j,k)>d(j-1,k) && d(j,k)>d(j-1,k+1) && d(j,k)>d(j,k-1) && d(j,k)>d(j,k+1) && d(j,k)>d(j+1,k-1) && d(j,k)>d(j+1,k) && d(j,k)>d(j+1,k+1) && d(j,k) > maxd/2 
            maxx = [maxx x(j)];
            maxy = [maxy y(k)];
        end
    end
end

