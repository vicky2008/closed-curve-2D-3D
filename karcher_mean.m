function [mu]=karcher_mean(w)
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
                v(:,:,i)=d/sin(d)*(p1-cos(d)*p0);
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
    