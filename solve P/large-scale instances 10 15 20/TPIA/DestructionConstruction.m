function [flag,time,x,obj,ComparedMat,Insertdelta_num]=DestructionConstruction(x,m,n,sigma,obj,pi,d)
curtime=clock;
origin_obj=obj;
flag=0;
Insertdelta_num=0;

disp(['未破坏前的x='])
disp([num2str(x)])

disp(['未破坏前的排序='])
disp([num2str(pi.*x)])

sigma_ed = sigma.*x; %sigma_ed是在现有工件分配下，每台机器上的工件的方差
% [~,phi]=sort(sigma_ed,2,'descend'); %在现有工件分配下，对每台机器上的工件按照方差大小从大到小排列

DCjob=zeros(m,d);%记录哪些工件被Destruction掉了
xstore=zeros(m,d);

%Destruction过程 : Destruction掉 每台机器方差大小前d/2的工件 随机选取剩下d/2的工件
for k=1:m
    flag_i=0;
    flag_a=0;
    q=1;
    for i=1:d/2
        while flag_i==0
            if x(k,n-q+1)~=0
                x(k,n-q+1)=0;
                flag_i=1;
                DCjob(k,i)=pi(k,n-q+1);
                xstore(k,i)=n-q+1;
                q=q+1;
            else
                q=q+1;
            end
        end
        while flag_a==0
            a=randperm(n,1) ;
            if x(k,a)~=0
                x(k,a)=0;
                flag_a=1;
            end
            DCjob(k,i+d/2)=pi(k,a);
            xstore(k,i+d/2)=a;
        end
%         while flag_i==0
%             if x(k,pi(k,n-q+1))~=0
%                 x(k,pi(k,n-q+1))=0;
%                 flag_i=1;
%                 DCjob(k,i)=pi(k,n-q+1);
%                 q=q+1;
%             else
%                 q=q+1;
%             end
%         end
%         while flag_a==0
%             a=randperm(n,1) ;
%             if x(k,pi(k,a))~=0
%                 x(k,pi(k,a))=0;
%                 flag_a=1;
%             end
%             DCjob(k,i+d/2)=pi(k,a);
%         end
    end
end

disp(['破坏的工件'])
disp(DCjob)

disp(['破坏后的x='])
disp([num2str(x)])
%Construction过程
%Insertmove和Swapmove依概率进行
for k=1:m
    for i=1:d  %对x(k,DCjob(k,i))进行操作
        [ComparedMat_changed,x_changed,obj_changed,pi_3]=Insertmove(n,DCjob,xstore,k,i,sigma,pi,x);
        Insertdelta_num=Insertdelta_num+1;
        ComparedMat=ComparedMat_changed;
        x=x_changed;
        %pi(k,:)=pi_3;
        disp(['重构过程中的x='])
        disp([num2str(x)])
    end
end

obj=obj_changed;
if origin_obj-obj>exp(-10)
    flag=1;
end
time=etime(clock,curtime);

