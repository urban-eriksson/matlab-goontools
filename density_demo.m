function density_demo()
figure(2001)
clf
data = rand(1,1000);
%data = [0.5];
hist(data,20);
hold on
bins = -0.2:0.02:1.2;
tic
dens = gdensity(data,bins,0.05);
toc
sum(dens)
plot(bins,dens,'r','linewidth',1.5)

