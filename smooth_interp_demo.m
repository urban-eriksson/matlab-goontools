function smooth_interp_demo()
figure(3001)
clf
hold on
x = [-2 -1 -.5 0 0.7 2 2];
y = [0.6 0 0.3 -1 -0.5 0 1];
xi = -3:0.01:3;
sigma = 0.5;
reach = inf;
ysmooth = gsmooth(x,y,sigma,reach);
yi = ginterp(x,y,xi,sigma,reach);

plot(x,y,'bo','markerfacecolor','b')
plot(x,ysmooth,'r*','markersize',8)
plot(xi,yi,'g','linewidth',1)
legend('raw data','smoothing','interpolation')
xlabel('x')
ylabel('y')
title('Gaussian smoothing&interpolation')



figure(3002)
clf
hold on
yi1 = ginterp(x,y,xi,0.25,inf);
yi2 = ginterp(x,y,xi,0.5,inf);
yi3 = ginterp(x,y,xi,1,inf);
plot(x,y,'bo','markerfacecolor','b')
plot(xi,yi1,'r')
plot(xi,yi2,'g')
plot(xi,yi3,'k')
legend('raw data','\sigma=0.25','\sigma=0.5','\sigma=1')
xlabel('x')
ylabel('y')
title('Interpolation using different \sigma')

figure(3003)
clf 
[x,y]=meshgrid(0:0.25:10,0:0.25:10);
xy = [x(:) y(:)];
mu = [4 5];
sigma = [4 2; 2 2];
z1 = reshape(exp(-0.5 * sum((sigma\(xy-mu)').*(xy-mu)'))',size(x));
z2 = z1 + rand(size(z1))*0.1;
z3 = reshape(gsmooth(xy,z2(:),0.5),size(x));


mesh(x,y,z1)
figure(3004)
clf
mesh(x,y,z2)

figure(3005)
clf
mesh(x,y,z3)


    


% delta = 0.1;
% bins = -1:delta:11;
% dens = gdensity(data,bins,0.3);
% disp(['Integration of the density ideally equals the number of points : ' num2str(sum(dens * delta))])
% plot(bins,dens*delta,'b','linewidth',1)
% hold on
% plot(data,zeros(size(data)),'r.','markersize',20)
% 
% xlabel('data')
% ylabel('density')
% title('1D density')
% 
% figure(2002)
% clf
% mu = [4 5];
% sigma = [3 1.5; 1.5 1];
% data = mvnrnd(mu,sigma,100);
% plot(data(:,1),data(:,2),'+')
% axis([0 10 0 10])
% xlabel('x')
% ylabel('y')
% title('Multivariate Gaussian')
% 
% figure(2003)
% clf
% [xbin,ybin]=meshgrid(0:0.1:10,0:0.1:10);
% bins = [xbin(:) ybin(:)];
% dens = gdensity(data,bins,0.3);
% mesh(xbin,ybin,reshape(dens,size(xbin)));
% xlabel('x')
% ylabel('y')
% title('2D density of multivariate Gaussian')
% 

