function [mu]=kmean(w)
    [n,T,k] = size(w)
    q = zeros(n, T, k);
    for ii = 1:k
        q(:, :, ii) = curve_to_q(w(:, :, ii))
%         l=w(:,:,ii);
%         plot(l(1,:),l(2,:))
    end

   % Initialize mu as one of the shapes
   % mu is the mean srvf,Cmean is mean curve
   % v is shooting vector
   % q is array of srvfs
   
%     Cmean =w(:, :, 1);
    mu = q(:, :, 1);
    del = 0.5;
    itr = 10;
    for j=1:itr
        
            for i=1:k
                sum=zeros(2,T);
                p0=mu;
                p1=q(:,:,i);
                p01=q_to_curve(p0);p11=q_to_curve(p1);
                [d,Geod] = GeodesicElasticClosed(p01,p11);
                
                [q2n,R] = Find_Rotation_and_Seed_unique(p0,p1,1);
                q2n = q2n/sqrt(InnerProd_Q(q2n,q2n));
                u=q2n-d*p1;
                normu=norm(u);
                v(:,:,i)=u*d/normu;
                sum=sum+v(:,:,i);
    
            end
            vbar(:,:,j)=sum./k;
%             vbarn(1)=0;
        
            vbarn(j)=norm(vbar(:,:,j));
            if vbarn(j)<0.0001
                itr=j;
                break
            end;
          
            d1=norm(vbar(:,:,j));
            muC=cos(del*d1)*mu+sin(del*d1)/d1*vbar(:,:,j);
    end
        mu=muC;
   
end
    
% cbar=q_to_curve(mu); plot(cbar(1,:),cbar(2,:),'g','LineWidth',2)
    