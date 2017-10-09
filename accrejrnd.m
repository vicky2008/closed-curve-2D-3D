function X = accrejrnd(n)
               
X = zeros(3,n); % Preallocate memory
for i = 1:n
    accept = false;
    
    while accept == false
        u2=rand;p=50;
        x(:,i)=generate(1);mut=generate(1);
        R(i)=exp(p*(mut'*x(:,i)-1));
        if u2<R(i)
           X(:,i) = x(:,i);
           accept = true;
        end
    end
end