clc
clear all
MachineArray=[2,3,6];%2,3,6,9   10,20,30
JobArray=[10,15,20];%10,15,20,25,30,35,40,45,50,|60,80,100    10,20,40,60,80,100
Groups=10;


time_GA=zeros(1,Groups);  %用来储存GA算法的时间
obj_GA=zeros(1,Groups);   %用来储存GA算法的目标值
time_RHA=zeros(1,Groups); %用来储存RHA算法的时间
obj_RHA=zeros(1,Groups);  %用来储存RHA算法的目标值
time=zeros(1,Groups);     %用来储存总的时间


for m=MachineArray
    for n=JobArray
        disp(['########## m=',num2str(m),',n=',num2str(n),' ######'])
        index=1;
        for k=1:Groups
            disp(['k=',num2str(k)])
            filename=strcat('.\jobdata\mu10_100\sigma0.1_0.25','_m',num2str(m),'n',num2str(n),'group',num2str(k),'.mat');
            load(filename);
            [sorted_sigma,pi]=sort(sigma,2);
            %获取贪婪算法初始解x_GA
            [time_GA(index),x_GA,obj_GA(index),ComparedMat_GA]=getInitialSolutionByGreedyAlgorithm(m,n,sigma,pi);
            
            %1,RHA with multiMachine
            [x,obj_RHA(index),ComparedMat,time_RHA(index),flag_impro]=solveByRHAWithMultiM(x_GA,m,n,sigma,pi,obj_GA(index),ComparedMat_GA);
            disp([num2str(obj_RHA(index))])
            index=index+1;
        end
        
        %储存GA 的时间和目标值
        filename=strcat('.\GAresult\GA_m',num2str(m),'n',num2str(n),'.mat');
        save(filename,'obj_GA','time_GA');
        load(filename);
        
        %储存RHA 的时间和目标值
        filename=strcat('.\RHAresult\RHA_m',num2str(m),'n',num2str(n),'.mat');
        save(filename,'obj_RHA','time_RHA');
        load(filename);
        
        %储存总的时间
        time=time_GA+time_RHA;
        filename=strcat('.\timeresult\total_m',num2str(m),'n',num2str(n),'.mat');
        save(filename,'time');
    end
end
