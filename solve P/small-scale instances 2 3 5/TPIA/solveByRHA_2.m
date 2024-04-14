function [S,S_]=solveByRHA_2(i,j,S,T,R,array,sigma_,pi_,n)
%传进来的 i，j是要分配的两台机器
%T=x(j,:)+x(i,:);  表示现在i和j两台机器上分配的工件
%R=T;              储存开始时还有多少工件没有重新分配
%array=T;
%sigma_=sigma([j,i],:); 
%pi_=pi([j,i],:);
% S=zeros(1,n);

while sum(R)~=0
    u=zeros(2,n);
    f_S=getf(S,array-S,n,sigma_,pi_);  %S记录哪些分配给i 开始时为0向量 表示空集，采用填充的方式
    f_T=getf(T,array-T,n,sigma_,pi_);  %T同样记录哪些工件分配给第1台机器  开始时为全部工件的集合，采用排除的方式
    for k=1:n
        if R(k)==0
            continue
        end
        S_=S;
        S_(k)=1;
        u(1,k)=getf(S_,array-S_,n,sigma_,pi_)-f_S;   %a_k
        T_=T;
        T_(k)=0;
        u(2,k)=f_T-getf(T_,array-T_,n,sigma_,pi_);   %b_k
        if u(1,k)>=0                                 %a_k>0，工件k不分配给机器i
            T=T_;                                    %T_(k)=0;
            R(k)=0;
            f_T=getf(T,array-T,n,sigma_,pi_);
        end
        if u(2,k)<=0                                 %b_k<0，工件k分配给机器i
            S=S_;                                    %S_(k)=1;
            R(k)=0;
            f_S=getf(S,array-S,n,sigma_,pi_);
        end
        length_R=sum(R);
        if sum(u(1,:).*R<0)==length_R&&sum(u(2,:).*R>0)==length_R
            break
        end
    end
    if sum(R)==0
        break
    end
    %job_index3=job_index3+1;
    [max1,index1]=max(-u(1,:).*R);        %找到R里，即未分配的工件里面 绝对值最大的a_k及其对应的k
    [max2,index2]=max(u(2,:).*R);         %找到R里，即未分配的工件里面 最大的b_k及其对应的k
    b=max1+max2;
    a=b*rand(1,1);
    if a <= max1  
        S(index1)=1;                     
        R(index1)=0;
    else
        T(index2)=0;
        R(index2)=0;
    end
end

S_=array-S;                              %S_就是没有分配给i的，那就是分配给了j的

