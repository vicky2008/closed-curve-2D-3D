
function [kmu]=curve_karcher_mean(w)
    [n,T,k] = size(w)
    q = zeros(n, T, k);
    for ii = 1:k
        q(:, :, ii) = curve_to_q(w(:, :, ii))
    end

   % Initialize mu as one of the shapes
   % mu is the mean srvf,Cmean is mean curve
   % v is shooting vector
   % q is array of srvfs
    mu = q(:, :, 1);
%     Cmean =w(:, :, 1);

    del = 0.5;
    itr = 50;
    for j=1:itr
        for r=1:100
            sum=zeros(2,1);
            for i=1:k
                p0=mu(:,r);
                p1=q(:,r,i);
                d=acos(p0'*p1);
               
                if norm(d)<0.0001
                    v(:,i)=zeros(2,1);
                else
                    v(:,i)=d/sin(d)*(p1-cos(d)*p0);
                end
                sum(:,1)=sum(:,1)+v(:,i);
            end
            vbar(:,r)=sum(:,1)/k;
        end
        vbarn(j)=0;
        for r=1:100
            vbarn(j)=norm(vbar(:,r));
            if vbarn(j)<0.0001
                niter=j;
                break;
            end
        end
        for r=1:100
            d1=norm(vbar(:,r));
            muC(:,r)=cos(del*d1)*mu(:,r)+sin(del*d1)/d1*vbar(:,r);
        end
        kmu=muC;
    end
    cbar=q_to_curve(kmu)
    plot(cbar(1,:),cbar(2,:),'b','LineWidth',2)
end
    

%         % TODO: parallelize
%        
%         for i = 1:N
%             v1, d = karcher_calc(beta[:,:,n],q[:,:,n], betamean, mu, mode=mode,
%                                  wscale=wscale);
%             v[:,:,i] = v1;
%             sumd[itr+1] = sumd[itr+1] + d^2;
%         end
% 
%         sumv = sum(v,3);
% 
%         %compute average direction of tangent vectors v_i
%         vbar = sumv./float(N);
% 
%         normvbar[itr] = sqrt(innerprod_q2(vbar,vbar));
%         normv = normvbar[itr];
% 
%         if (normv > tolv && abs(sumd[itr+1]-sumd[itr])>told)
%             % update mu in direction of vbar
%             mu = cos(delta*normvbar[itr])*mu + sin(delta*normvbar[itr]) *
%                 vbar/normvbar[itr];
% 
%             if mode == 'C'
%                 mu = project_curve(mu);
%             end
% 
%             x = q_to_curve(mu);
%             a = -1 * calculatecentroid(x);
%             betamean = x + repmat(a,1,T);
%         else
%             break
%         end
% 
%         itr += 1;
% 
%     end
% 
%     return (mu, betamean, v, q)
% end
