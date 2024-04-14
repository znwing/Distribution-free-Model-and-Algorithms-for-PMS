function [time,x,obj,ComparedMat]=getInitialSolutionByGreedyAlgorithm(m,n,sigma,pi) 
curtime=clock;
%m
%n
%sigma
%pi
x=zeros(m,n);
sum_sigma=zeros(1,m);
d=zeros(1,n);
obj=0;
p=ones(1,m);
ComparedMat=zeros(m,n); %pi排序情况下 ComparedMat(k,i)存第k行前i列方差和，
%用于在improve函数中和exchange/insert后的函数比较

%[sorted_sigma,pi]=sort(sigma,2); 
% [obj,index]=min(  sqrt(  sort_sigma(1:m,1)  )  );
% x(index,sigma_index(index,1))=1;
% ComparedMat(index,1)=obj;
% sum_sigma(index)=sort_sigma(index,1);
increment=zeros(1,m);
%i_index=zeros(1,m);

while sum(d)~=n
    for k=1:m
        while d(pi(k,p(k)))==1                                         %检查第k台机器的第p(k)个工件是否已经分配
            p(k)=p(k)+1;                                               %p(k)用来记录第k台机器上分配到了几个工件，如果第p(k)个工件已经分配了，就要看下第k台机器上的一个工件
        end                                                            %注意，排序后实际上每台机器上有n个工件，只不过排序不一样，所以第k台机器的第1个很可能安排到了其他机器上
        increment(1,k)=sum_sigma(k)+sigma(k,pi(k,p(k)));               %所以就要直接看第k台机器的下一个
    end
    [min_increment,index]=min(increment);                              %min_increment记录 increment的最小值，index记录最小的increment的列数，即决定在第几台机器上加工
    x(index,pi(index,p(index)))=1;                                     %p=ones(1,m)，p(index)用来记录第index台机器上分配了几个工件，即该工件是index机器上的第几个工件   pi应该是m*n的
    d(  pi(index,p(index)) )=1;                                        %d=zeros(1,n); pi应该是m*n的  看第index台机器的第p(index)个工件到底是哪个，在d里面让它等于1，后面检查其他机器如果要加工的还是这个工件就跳过
    ComparedMat(index,p(index))=min_increment;                         %记录每一步的增量，ComparedMat=zeros(m,n); %pi排序情况下 ComparedMat(k,i)存第k行前i列方差和 %第index行前p(index)列方差和
    sum_sigma(index)=sum_sigma(index)+sigma(index,pi(index,p(index))); %记录第index机器上的目标值
    p(index)=p(index)+1;                                               %第index台机器就要看下一个了
    obj=obj+sqrt(min_increment);                                       %记录总目标值
end 


% while ~isempty(J)
%     for k=1:m
%         [min_sigma_k,i_index(k)]=min(sigma(k,J));
%         increment(1,k)=sum_sigma(k)+min_sigma_k;
%     end
%     [min_increment,index]=min(increment);
%     i=J(i_index(index));
%     x(index,i)=1;
%     ComparedMat(index,i)=sqrt(min_increment);
%     sum_sigma(index)=sum_sigma(index)+sigma(index,i);
%     J(i_index(index))=[];
%     obj=obj+sqrt(min_increment);
% end
% x 
% obj

time=etime(clock,curtime);
%disp(['time=',num2str(time)]);