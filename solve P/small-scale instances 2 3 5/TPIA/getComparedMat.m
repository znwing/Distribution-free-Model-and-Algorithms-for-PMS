function [ComparedMat]=getComparedMat(m,n,x,pi,sorted_sigma)
ComparedMat=zeros(m,n);
sum_sigma=zeros(1,m);

for k=1:m
    index=0;
    u_index=x(k,pi(k,:));
    sum_1=sum(u_index);
    for i=1:n
        if index>=sum_1
            break
        end
        if u_index(i)==0
            continue
        end
        sum_sigma(k)=sum_sigma(k)+sorted_sigma(k,i);
        ComparedMat(k,i)=sum_sigma(k);
        index=index+1;
    end
end