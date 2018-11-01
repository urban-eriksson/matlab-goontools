function density_demo()
figure(2001)
clf
data = [1 3 4 4.5 5 5 8 8.2 9];
delta = 0.1;
bins = -1:delta:11;
dens = gdensity(data,bins,0.3);
disp(['Integration of the density ideally equals the number of points : ' num2str(sum(dens * delta))])
plot(bins,dens*delta,'b','linewidth',1)
hold on
plot(data,zeros(size(data)),'r.','markersize',20)

xlabel('data')
ylabel('density')
title('1D density')

figure(2002)
clf
mu = [4 5];
sigma = [3 1.5; 1.5 1];
data = mvnrnd(mu,sigma,100);
plot(data(:,1),data(:,2),'+')
axis([0 10 0 10])
xlabel('x')
ylabel('y')
title('Multivariate Gaussian')

figure(2003)
clf
[xbin,ybin]=meshgrid(0:0.1:10,0:0.1:10);
bins = [xbin(:) ybin(:)];
dens = gdensity(data,bins,0.3);
mesh(xbin,ybin,reshape(dens,size(xbin)));
xlabel('x')
ylabel('y')
title('2D density of multivariate Gaussian')


