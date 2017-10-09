% function S=generate(n)
% theta=pi*rand(1,n);
% phi=2*pi*rand(1,n);
% [x,y,z]=sph2cart(theta,phi,ones(1,n));
% S=[x;y;z];
% end

function S=generate(n)
u1=rand;u2=rand;u3=rand;
theta1=2*pi*u1;
theta2=acos(u2);
if u3<0.5
    theta2=pi-theta2;
else
    theta2=theta2;
end
[x,y,z]=sph2cart(theta1,theta2,ones(1,n));
S=[x;y;z];
end
