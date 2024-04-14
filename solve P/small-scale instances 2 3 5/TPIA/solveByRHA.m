function [time,x,obj,ComparedMat,job_num2,job_index2,job_index3]=solveByRHA(m,n,sigma,pi) 
curtime=clock;
x=zeros(m,n); %记录工件的分配情况
S=zeros(1,n); %记录哪些工件分配给第1台机器  开始时为0向量 表示空集，采用填充的方式
T=ones(1,n);  %同样记录哪些工件分配给第1台机器  开始时为1向量 表示全部工件的集合，采用排除的方式
R=ones(1,n);  %记录剩余哪些工件没有分配

job_num2=0;
job_index2=0;
job_index3=0;
ComparedMat=zeros(m,n);%pi排序情况下 ComparedMat(k,i)存第k行前i列方差和，

while sum(R)~=0  %判断是否还有剩余工件没分配
    u=zeros(m,n); % u(1,k)=a_k, u(2,k)=b_k    a_k和b_k 均表示k给1成本增加的量  减去  k给2成本的增加量
                  %但是a_k的k为  b_k的k为机器1本身之外的工件
    f_S=getf(S,1-S,n,sigma,pi); % 1-S相当于将1扩展到n维然后减去S
    f_T=getf(T,1-T,n,sigma,pi); % 1-T相当于将1扩展到n维然后减去T
    for k=1:n
        if R(k)==0
            continue
        end
        S_=S;
        S_(k)=1;
        u(1,k)=getf(S_,1-S_,n,sigma,pi)-f_S;
        T_=T;
        T_(k)=0;
        u(2,k)=f_T-getf(T_,1-T_,n,sigma,pi);
        if u(1,k)>=0                        %a_k>=0  看那些工件不分配给机器1 k从2到1成本增加了
            T=T_;                           %T_(k)=0
            R(k)=0;
            f_T=getf(T,1-T,n,sigma,pi);
        end
        if u(2,k)<=0                        %b_k<=0  看哪些工件分配给机器1 k从1到2成本增加了
            S=S_;                           %S_(k)=1
            R(k)=0;
            f_S=getf(S,1-S,n,sigma,pi);
        end
        if u(1,k)>=0||u(2,k)<=0
            job_num2=job_num2+1;           %job_num2记录有多少工件是直接就能分配的
        end
        job_index2=job_index2+1;
        length_R=sum(R);
        if sum(u(1,:).*R<0)==length_R && sum(u(2,:).*R>0)==length_R
            break
        end
    end
    
    if sum(R)==0
        break
    end
    job_index3=job_index3+1;
    [max1,index1]=max(-u(1,:).*R); %找到R里，即未分配的工件里面 绝对值最大的a_k及其对应的k
    [max2,index2]=max(u(2,:).*R);  %找到R里，即未分配的工件里面 最大的b_k及其对应的k
    b=max1+max2;
    a=b*rand(1,1);
    if a <= max1                   %a_k 可以理解为把k从2即S_中拿出来 给1即S 的成本变化
        S(index1)=1;               %b_k 可以理解为把k从1即T中拿出来 给2即T_ 的成本变化
        R(index1)=0;
    else
        T(index2)=0;
        R(index2)=0;
    end
end
[obj,ComparedMat]=getf(S,1-S,n,sigma,pi);
x(1,:)=S;
x(2,:)=1-S;
time=etime(clock,curtime);
%disp(['time=',num2str(time)]);