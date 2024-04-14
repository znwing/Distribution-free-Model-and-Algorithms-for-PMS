clc 
clear all

MachineArray=[2,3,6];%,2,3,6,9
JobArray=[10,15,20];%10,15,20,25,30,35,40,45,50,60,80,100
Groups=10;
time_GA=zeros(1,Groups);
obj_GA=zeros(1,Groups);

for m=MachineArray
    for n=JobArray
        disp(['########## m=',num2str(m),',n=',num2str(n),' ######'])
        index=1;
        for k=1:Groups
            disp(['k=',num2str(k)])
            %����m������n��job��k��sigma
            filename=strcat('.\jobdata\mu10_100\sigma0.1_0.25','_m',num2str(m),'n',num2str(n),'group',num2str(k),'.mat');
            load(filename);
            [sorted_sigma,pi]=sort(sigma,2);
            [time_GA(index),x_GA,obj_GA(index),ComparedMat_GA]=getInitialSolutionByGreedyAlgorithm(m,n,sigma,pi); 
            disp(['GA obj=',num2str(obj_GA(index)),',GA time=',num2str(time_GA(index))])
            index=index+1;
            
            %��GA �Ľ�x��ÿ��������һ��
            filename=strcat('.\GAresult\GA_X_m',num2str(m),'n',num2str(n),'group',num2str(k),'.mat');
            save(filename,'x_GA','ComparedMat_GA');
        end
        
        %��GA ��ʱ���Ŀ��ֵ �ܴ�һ�Σ��Է����������
        filename=strcat('.\GAresult\GA_m',num2str(m),'n',num2str(n),'.mat');
        save(filename,'time_GA','obj_GA');
        
    end
end