clc
clear all
warning('off');

MachineArray=[2,3,5]; %机器数
%工件数 JobArray=[4*MachineArray,5*MachineArray,6*MachineArray];
% Groups=10;
Groups=1;

timelimit=600;
display=1;
tol=5;
tolerance=10^(-tol);
optionsgurobi = sdpsettings('verbose',display,'usex0',1,'solver','gurobi','showprogress',display,'gurobi.TimeLimit',timelimit...
    ,'gurobi.MIPGap',tolerance,'savesolveroutput',1);

%GA给出一个初始解
time_GA=zeros(1,Groups);
obj_GA=zeros(1,Groups);

%SOCP的time,obj,modeltime,solvetime每10个算例存一次
time_SOCP=zeros(1,Groups);
obj_SOCP=zeros(1,Groups);
obj_bound_SOCP=zeros(1,Groups);
gap_SOCP=zeros(1,Groups);
modeltime_SOCP=zeros(1,Groups);
solvetime_SOCP=zeros(1,Groups);


for m=MachineArray
    for n=[4*m,5*m,6*m]
        disp(['########## m=',num2str(m),',n=',num2str(n),' ######'])
        index=1;
        %将SOCP中部分约束及目标函数抽出
        [constraint,objective,x_con,z_con,y_con,modeltime1_SOCP]=prepareForSOCP(m,n);
        for k=1:Groups
            disp(['k=',num2str(k)])
            %加载m个机器n个job第k组sigma
            filename=strcat('.\jobdata\mu10_100\sigma0.1_0.25','_m',num2str(m),'n',num2str(n),'group',num2str(k),'.mat');
            load(filename);
            halfsigma=sqrt(sigma);%求标准差
            [sorted_sigma,pi]=sort(sigma,2);
            [time_GA(index),x_GA,obj_GA(index),ComparedMat_GA]=getInitialSolutionByGreedyAlgorithm(m,n,sigma,pi); 
            disp(['GA obj=',num2str(obj_GA(index)),',GA time=',num2str(time_GA(index))])
            
            [time_SOCP(index),x_SOCP,y_SOCP,z_SOCP,obj_SOCP(index),obj_bound_SOCP(index),modeltime_SOCP(index),solvetime_SOCP(index),gap_SOCP(index)]=solveByMixedIntegerSOCPnew(m,n,halfsigma,pi,optionsgurobi,constraint,x_con,y_con,z_con,objective,x_GA);
            disp(['obj_SOCP',num2str(index),'=',num2str(obj_SOCP(index))]);
            index=index+1;
            %对SOCP的解x，每个算例存一次
%             filename=strcat('.\GAresult\GA_X_m',num2str(m),'n',num2str(n),'group',num2str(k),'.mat');
%             save(filename,'x_GA');
            
%             filename=strcat('.\result\SOCP_X_m',num2str(m),'n',num2str(n),'group',num2str(k),'.mat');
%             save(filename,'x_SOCP','y_SOCP','z_SOCP');
        end
%         filename=strcat('.\result\SOCP_m',num2str(m),'n',num2str(n),'tol',num2str(tol),'.mat');
%         save(filename,'time_SOCP','modeltime_SOCP','solvetime_SOCP','obj_SOCP','obj_bound_SOCP','gap_SOCP');
%         filename=strcat('.\GAresult\GA_m',num2str(m),'n',num2str(n),'tol',num2str(tol),'.mat');
%         save(filename,'obj_GA','time_GA');
    end
    
    
   
end


