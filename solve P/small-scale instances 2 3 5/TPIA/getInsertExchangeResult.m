clc 
clear all

MachineArray=[2,3,6];%3,6,9
JobArray=[10,15,20];%,40,60,80,90,100,120,150
Groups=10;

time_InsertExchange=zeros(1,Groups);
obj_InsertExchange=zeros(1,Groups);
time=zeros(1,Groups);

for m=MachineArray
    for n=JobArray
        disp(['########## m=',num2str(m),',n=',num2str(n),' ######'])
        index=1;
        %����m������n��job��GA objֵ
        filename=strcat('.\GAresult\GA_m',num2str(m),'n',num2str(n),'.mat');
        load(filename);
        for k=1:Groups
            disp(['k=',num2str(k)])
            %����m������n��job��k��sigma
            filename=strcat('.\jobdata\mu10_100\sigma0.1_0.25','_m',num2str(m),'n',num2str(n),'group',num2str(k),'.mat');
            load(filename);
            
            %����m������n��job��k���x_GAֵ����Ӧ��ComparedMat_GA
            filename=strcat('.\GAresult\GA_X_m',num2str(m),'n',num2str(n),'group',num2str(k),'.mat');
            load(filename);
            
            %��m������n��job ��k������ ���в���ͽ�������
            [sorted_sigma,pi]=sort(sigma,2);
            [time_InsertExchange(index),x_InsertExchange,obj_InsertExchange(index),ComparedMat]=Insert_Exchange_Improvement(x_GA,m,n,sigma,ComparedMat_GA,obj_GA(index),pi);
            disp(['InsertExchange obj=',num2str(obj_InsertExchange(index)),',InsertExchange time=',num2str(time_InsertExchange(index))])
            
            index=index+1;
            %��Insert+Exchange�Ľ�x��ÿ��������һ��
            filename=strcat('.\I+E result\InsertExchange_X_m',num2str(m),'n',num2str(n),'group',num2str(k),'.mat');
            save(filename,'x_InsertExchange');
            
        end
        %����Insert+Exchange��ʱ���Ŀ��ֵ �ܵĴ�һ�� ������
        filename=strcat('.\I+E result\InsertExchange_m',num2str(m),'n',num2str(n),'.mat');
        save(filename,'time_InsertExchange','obj_InsertExchange');
        load(filename);
        
        %����m������n��job�ܵ� ��GA ��ʱ���Ŀ��ֵ 
        filename=strcat('.\GAresult\GA_m',num2str(m),'n',num2str(n),'.mat');
        load(filename);
        
        %�����ȡ��ʼ��ͽ����Ͳ����������ʱ�䲢����
        time=time_InsertExchange+time_GA;
        filename=strcat('.\timeresult\time_m',num2str(m),'n',num2str(n),'.mat');
        save(filename,'time');
        
    end
end