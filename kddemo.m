function kddemo()

% Neighborhood search
xy = [rand(1000,1) rand(1000,1)];
kd = KDtree(xy);
r = 0.2;
p = [0.27 0.66];
nb = kd.neighborhood(p,r);
figure('numbertitle','off')
plot(xy(:,1),xy(:,2),'b.')
hold on
plot(nb(:,1),nb(:,2),'ro')
viscircles(gca,p,r,'color',[0.5 0.5 0.5],'linestyle','--');
title('k-d tree neighborhood search')
axis([0 1 0 1])

% Nearest neighbor search
xy = [rand(10,1) rand(10,1)];
kd = KDtree(xy);
p = [0.5 0.5];
nn = kd.nearestneighbor(p);
figure('numbertitle','off')
plot(xy(:,1),xy(:,2),'b.')
hold on
plot(nn(1),nn(2),'ro')
plot(p(1),p(2),'k*')
r = sqrt((nn(1)-p(1))^2 + (nn(2)-p(2))^2);
viscircles(gca,p,r,'color',[0.5 0.5 0.5],'linestyle','--');
plot([p(1) nn(1)],[p(2) nn(2)],'k')
title('k-d nearest neighbor search') 
axis([0 1 0 1])

% Range search using indices
xy = [rand(1000,1) rand(1000,1)];
kd = KDtree(xy);
lower = [0.44 0.24];
upper = [0.68 0.72];
ix = kd.rangesearch_indices(lower,upper);
figure('numbertitle','off')
plot(xy(:,1),xy(:,2),'b.')
hold on
plot(xy(ix,1),xy(ix,2),'ro')
plot([lower(1) upper(1) upper(1) lower(1) lower(1)],[lower(2) lower(2) upper(2) upper(2) lower(2)],'color',[0.5 0.5 0.5],'linestyle','--','linewidth',1.5)
title('k-d tree range search')
axis([0 1 0 1])