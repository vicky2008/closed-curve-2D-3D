function [Z,mup]=pmean(S)
[n,T,k]=size(S);
mitr=30;j=1;
mu0=S(:,1);
mu(:,1)=mu0;del=0.5;
while j<mitr
    sum=zeros(3,1);
    for i=1:T
        p1=S(:,i);
        d=acos(p1'*mu(:,j));
        if norm(d)<0.001
            v(:,i)=zeros(3,1);
        else
        v(:,i)=(d/sin(d)).*(p1-mu(:,j)*cos(d));
        end
        sum(:,1)=sum(:,1)+v(:,i);
    end
    
        vbar(:,j)=sum(:,1)/T;
        vbarn(j)=norm(vbar(:,j));
       if vbarn(j)>0.01
%             normv=norm(vbarn(j));
            mu(:,j+1)=cos(del*vbarn(j)).*mu(:,j)+sin(del*vbarn(j)).*vbar(:,j)/vbarn(j);
            j=j+1;
        else
            break;
       end   
        

Z=mu;
mup=Z(:,j);
end
 
% [x,y,z] = sphere;figure;A=surf(x,y,z,'edgealpha',0);shading interp;set(A,'edgecolor','none','facecolor',[0.5 0.5 0.5]);
% direction = [1 0 0];
% rotate(A,direction,25);
% light;lighting gouraud;colormap(gray); set(A, 'linestyle','none')
% alpha('0.15');axis off;axis square;hold on;
% plot3(X(1,:),X(2,:),X(3,:),'.','MarkerSize',15);hold on;plot3(Z(1,:),Z(2,:),Z(3,:),'+r','MarkerSize',15);hold on;plot3(mup(1),mup(2),mup(3),'ok','MarkerSize',15,'MarkerFaceColor',[.49 1 .63])