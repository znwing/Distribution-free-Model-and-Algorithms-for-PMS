function [flag,time,x,obj,ComparedMat,Insertdelta_num]=DestructionConstruction(x,m,n,sigma,obj,pi,d)
curtime=clock;
origin_obj=obj;
flag=0;
Insertdelta_num=0;

disp(['δ�ƻ�ǰ��x='])
disp([num2str(x)])

disp(['δ�ƻ�ǰ������='])
disp([num2str(pi.*x)])

sigma_ed = sigma.*x; %sigma_ed�������й��������£�ÿ̨�����ϵĹ����ķ���
% [~,phi]=sort(sigma_ed,2,'descend'); %�����й��������£���ÿ̨�����ϵĹ������շ����С�Ӵ�С����

DCjob=zeros(m,d);%��¼��Щ������Destruction����
xstore=zeros(m,d);

%Destruction���� : Destruction�� ÿ̨���������Сǰd/2�Ĺ��� ���ѡȡʣ��d/2�Ĺ���
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

disp(['�ƻ��Ĺ���'])
disp(DCjob)

disp(['�ƻ����x='])
disp([num2str(x)])
%Construction����
%Insertmove��Swapmove�����ʽ���
for k=1:m
    for i=1:d  %��x(k,DCjob(k,i))���в���
        [ComparedMat_changed,x_changed,obj_changed,pi_3]=Insertmove(n,DCjob,xstore,k,i,sigma,pi,x);
        Insertdelta_num=Insertdelta_num+1;
        ComparedMat=ComparedMat_changed;
        x=x_changed;
        %pi(k,:)=pi_3;
        disp(['�ع������е�x='])
        disp([num2str(x)])
    end
end

obj=obj_changed;
if origin_obj-obj>exp(-10)
    flag=1;
end
time=etime(clock,curtime);

