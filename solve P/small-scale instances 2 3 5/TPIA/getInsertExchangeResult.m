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
        %加载m个机器n个job的GA obj值
        filename=strcat('.\GAresult\GA_m',num2str(m),'n',num2str(n),'.mat');
        load(filename);
        for k=1:Groups
            disp(['k=',num2str(k)])
            %加载m个机器n个job第k组sigma
            filename=strcat('.\jobdata\mu10_100\sigma0.1_0.25','_m',num2str(m),'n',num2str(n),'group',num2str(k),'.mat');
            load(filename);
            
            %加载m个机器n个job第k组的x_GA值和相应的ComparedMat_GA
            filename=strcat('.\GAresult\GA_X_m',num2str(m),'n',num2str(n),'group',num2str(k),'.mat');
            load(filename);
            
            %对m个机器n个job 第k组数据 进行插入和交换操作
            [sorted_sigma,pi]=sort(sigma,2);
            [time_InsertExchange(index),x_InsertExchange,obj_InsertExchange(index),ComparedMat]=Insert_Exchange_Improvement(x_GA,m,n,sigma,ComparedMat_GA,obj_GA(index),pi);
            disp(['InsertExchange obj=',num2str(obj_InsertExchange(index)),',InsertExchange time=',num2str(time_InsertExchange(index))])
            
            index=index+1;
            %对Insert+Exchange的解x，每个算例存一次
            filename=strcat('.\I+E result\InsertExchange_X_m',num2str(m),'n',num2str(n),'group',num2str(k),'.mat');
            save(filename,'x_InsertExchange');
            
        end
        %对于Insert+Exchange的时间和目标值 总的存一次 并加载
        filename=strcat('.\I+E result\InsertExchange_m',num2str(m),'n',num2str(n),'.mat');
        save(filename,'time_InsertExchange','obj_InsertExchange');
        load(filename);
        
        %加载m个机器n个job总的 对GA 的时间和目标值 
        filename=strcat('.\GAresult\GA_m',num2str(m),'n',num2str(n),'.mat');
        load(filename);
        
        %计算获取初始解和交换和插入操作的总时间并储存
        time=time_InsertExchange+time_GA;
        filename=strcat('.\timeresult\time_m',num2str(m),'n',num2str(n),'.mat');
        save(filename,'time');
        
    end
end