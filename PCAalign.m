function [xt,yt] = PCAalign(x, y, makeplots)
% PCAALIGN rotates and aligns a x-y point cloud along the x-axis 
%   centered at the origo
%   x,y     input coordinates
%   xt,yt   transformed coordinates

if nargin < 3
    makeplots = false;
end

% mean
mx = mean(x);
my = mean(y);

% zero-centered
nx = x - mx;
ny = y - my;

% covariance matrix
N = length(x);
a = 1 / (N-1) * sum(nx.*nx);
b = 1 / (N-1) * sum(nx.*ny);
c = 1 / (N-1) * sum(ny.*nx);
d = 1 / (N-1) * sum(ny.*ny);

% eigenvalues
lambda1 = (a+d)/2 + sqrt( ((a+d)/2)^2 + b*c - a*d);
lambda2 = (a+d)/2 - sqrt( ((a+d)/2)^2 + b*c - a*d);

% make sure principal direction is along x-axis
if abs(lambda2) > abs(lambda1)
    temp = lambda1;
    lambda1 = lambda2;
    lambda2 = temp;
end

% eigenvectors
if c~=0
    v1 = [lambda1-d c];
    v2 = [lambda2-d c];
elseif b~=0
    v1 = [b lambda1-a];
    v2 = [b lambda2-a];
end

% same scale on input and output
v1 = v1 / norm(v1);
v2 = v2 / norm(v2);

% positive x,y => positive xt,yt
if v1(1) < 0
    v1 = -v1;
end
if v2(2) < 0
    v2 = -v2;
end

% calculate transformed coordinates
xt = zeros(size(x));
yt = zeros(size(y));
for j = 1:N
    xt(j) = v1(1)*nx(j) + v1(2)*ny(j);
    yt(j) = v2(1)*nx(j) + v2(2)*ny(j);
end

% plot
if makeplots
    figure(808)
    clf
    plot(x,y,'b*')
    hold on
    plot(xt,yt,'r*')
    daspect([1 1 1])
    legend('Input','PCAed')
    grid on
    hold off
end


    
    

