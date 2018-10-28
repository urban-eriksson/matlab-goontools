function kddemo()

xy = [rand(1000,1) rand(1000,1)];
kd = KDtree(xy);
r = 0.2;
p = [0.27 0.66];
nb = kd.neighborhood(p,r);

figure
plot(xy(:,1),xy(:,2),'b.')
hold on
plot(nb(:,1),nb(:,2),'ro')
viscircles(gca,p,r,'color',[0.5 0.5 0.5],'linestyle','--');
title('k-d tree neighborhood search')


xy = [rand(10,1) rand(10,1)];
kd = KDtree(xy);
p = [0.5 0.5];
nn = kd.nearestneighbor(p);

figure
plot(xy(:,1),xy(:,2),'b.')
hold on
plot(nn(1),nn(2),'ro')
plot(p(1),p(2),'k*')
r = sqrt((nn(1)-p(1))^2 + (nn(2)-p(2))^2);
viscircles(gca,p,r,'color',[0.5 0.5 0.5],'linestyle','--');
plot([p(1) nn(1)],[p(2) nn(2)],'k')
title('k-d nearest neighbor search')