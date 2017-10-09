function [p,mu,q,E] = FindElasticMean(Data)

Niter= 20;
n=size(Data,3); 
figure(1); clf; 
for i=1:n
%     X = ReSampleCurve(Data(:,:,i),200);
    q(:,:,i) = curve_to_q(Data(:,:,i));
    q(:,:,i) = ProjectC(q(:,:,i));
end

del = .5;
mu =  q(:,:,3);
E(1)=1;
iter=2;

while (iter<=Niter && E(iter-1)>0.05)
    vm = 0;    
    for i=1:n
        [iter i]
        v = ElasticShootingVector(mu,q(:,:,i),1);
        vm = vm + v;

    end
       vm = vm/n;

       E(iter) = norm(vm,'fro');
       mu = ElasticShooting(mu,del*vm);
       mu = ProjectC(mu);
       iter=iter+1;
       E   
end



figure(11);clf; 
plot(E(2:end));


figure(21); clf; 
p = q_to_curve(mu);
plot(p(1,:),p(2,:),'LineWidth',3);
axis equal;

