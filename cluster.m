function s=cluster(n);

for i=1:n
p=zeros(3,i);
A=generate(i)
p(:,i)=A(:,i);
mu0=generate(1);
B=rand(i*1);
theta=zeros(i*1);
theta(i)=B(i);
v(:,i)=(theta(i)/sin(theta(i))).*(p(:,i)-mu0*cos(theta(i)));
nv(i)=norm(v(:,i));
s(:,i)=cos(0.5*nv(i))*mu0+sin(0.5*nv(i))*v(:,i)/nv(i); 

end
