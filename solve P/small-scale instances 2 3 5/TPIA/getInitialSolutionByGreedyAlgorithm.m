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
ComparedMat=zeros(m,n); %pi��������� ComparedMat(k,i)���k��ǰi�з���ͣ�
%������improve�����к�exchange/insert��ĺ����Ƚ�

%[sorted_sigma,pi]=sort(sigma,2); 
% [obj,index]=min(  sqrt(  sort_sigma(1:m,1)  )  );
% x(index,sigma_index(index,1))=1;
% ComparedMat(index,1)=obj;
% sum_sigma(index)=sort_sigma(index,1);
increment=zeros(1,m);
%i_index=zeros(1,m);

while sum(d)~=n
    for k=1:m
        while d(pi(k,p(k)))==1                                         %����k̨�����ĵ�p(k)�������Ƿ��Ѿ�����
            p(k)=p(k)+1;                                               %p(k)������¼��k̨�����Ϸ��䵽�˼��������������p(k)�������Ѿ������ˣ���Ҫ���µ�k̨�����ϵ�һ������
        end                                                            %ע�⣬�����ʵ����ÿ̨��������n��������ֻ��������һ�������Ե�k̨�����ĵ�1���ܿ��ܰ��ŵ�������������
        increment(1,k)=sum_sigma(k)+sigma(k,pi(k,p(k)));               %���Ծ�Ҫֱ�ӿ���k̨��������һ��
    end
    [min_increment,index]=min(increment);                              %min_increment��¼ increment����Сֵ��index��¼��С��increment���������������ڵڼ�̨�����ϼӹ�
    x(index,pi(index,p(index)))=1;                                     %p=ones(1,m)��p(index)������¼��index̨�����Ϸ����˼������������ù�����index�����ϵĵڼ�������   piӦ����m*n��
    d(  pi(index,p(index)) )=1;                                        %d=zeros(1,n); piӦ����m*n��  ����index̨�����ĵ�p(index)�������������ĸ�����d������������1�������������������Ҫ�ӹ��Ļ����������������
    ComparedMat(index,p(index))=min_increment;                         %��¼ÿһ����������ComparedMat=zeros(m,n); %pi��������� ComparedMat(k,i)���k��ǰi�з���� %��index��ǰp(index)�з����
    sum_sigma(index)=sum_sigma(index)+sigma(index,pi(index,p(index))); %��¼��index�����ϵ�Ŀ��ֵ
    p(index)=p(index)+1;                                               %��index̨������Ҫ����һ����
    obj=obj+sqrt(min_increment);                                       %��¼��Ŀ��ֵ
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