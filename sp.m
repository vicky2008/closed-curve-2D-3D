function S=sp(n)
for i=1:n
z=2.*rand(1,i)-1;
theta=2*pi.*rand(1,i)-pi;
x(i)=sin(theta(i))*sqrt(1-z(i)^2);
y(i)=cos(theta(i))*sqrt(1-z(i)^2);

end
S=[x;y;z]
end

