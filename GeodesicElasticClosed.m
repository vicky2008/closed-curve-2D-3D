function [d,Geod] = GeodesicElasticClosed(p1,p2)

% input p1 and p2 as 2xn or 3xn matrices (planar vs. 3D closed curves)
% to turn off figures set figs=0
% the output is the distance d between p1 and p2 and the geodesic path Geod
% stp refers to the number of shapes displayed along the geodesic

figs=1;

stp = 6;

[n,T]=size(p1);

if figs
figure(1); clf; hold on;
if (n==2)
    plot(p1(1,:),p1(2,:),'b','LineWidth',2);
    plot(p2(1,:),p2(2,:),'r','LineWidth',2);
    axis equal;
    axis xy off;
else
    plot3(p1(1,:),p1(2,:),p1(3,:),'b','LineWidth',2);
    plot3(p2(1,:),p2(2,:),p2(3,:),'r','LineWidth',2);
    axis equal;
    axis xy off;
end
end

p1 = ReSampleCurve(p1,100);
p2 = ReSampleCurve(p2,100);

q1 = curve_to_q(p1);
q2 = curve_to_q(p2);

tic
[q2n,R] = Find_Rotation_and_Seed_unique(q1,q2,1);
q2n = q2n/sqrt(InnerProd_Q(q2n,q2n));
q2=curve_to_q(p2);
q2 = ProjectC(q2);
p2=q_to_curve(q2);
p2n=R*p2;
toc

d = acos(InnerProd_Q(q1,q2n));
if figs
alpha = geodesic_sphere_Full(q1,q2n,stp);
Path_Plot(alpha,p2n,10,'b',[73,6]);
axis xy; view([1 90]);
end

[k] = size(alpha,3);

for j=1:k
    Geod(:,:,j)=q_to_curve(alpha(:,:,j));
end