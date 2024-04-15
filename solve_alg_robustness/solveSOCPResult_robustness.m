clc
clear all
warning('off');

MachineArray=[20]; %机器数
%工件数 JobArray=[4*MachineArray,5*MachineArray,6*MachineArray];
% Groups=10;
Groups=10;

timelimit=600;
display=0;
tol=5;
tolerance=10^(-tol);
optionsgurobi = sdpsettings('verbose',display,'usex0',1,'solver','gurobi','showprogress',display,'gurobi.TimeLimit',timelimit...
    ,'gurobi.MIPGap',tolerance,'savesolveroutput',1,'gurobi.TuneTimeLimit', 0);

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

for k=1:Groups
    for sig_ratio = 0:4
        l_para = 0.1*sig_ratio;
        for m=MachineArray
            for n=[6*m]
                disp(['########## m=',num2str(m),',n=',num2str(n),' ######'])
                index=1;
                %将SOCP中部分约束及目标函数抽出
                if k == 1 && sig_ratio == 0
                    [constraint,objective,x_con,z_con,y_con,modeltime1_SOCP]=prepareForSOCP(m,n);
                    eval(strcat('constraint','_m',num2str(m),'_n',num2str(n),'= constraint;'))
                    eval(strcat('objective','_m',num2str(m),'_n',num2str(n),'= objective;'))
                    eval(strcat('x_con','_m',num2str(m),'_n',num2str(n),'= x_con;'))
                    eval(strcat('z_con','_m',num2str(m),'_n',num2str(n),'= z_con;'))
                    eval(strcat('y_con','_m',num2str(m),'_n',num2str(n),'= y_con;'))
                    eval(strcat('modeltime1_SOCP','_m',num2str(m),'_n',num2str(n),'= modeltime1_SOCP;'))
                else
                    eval(strcat('constraint=','constraint','_m',num2str(m),'_n',num2str(n),';'))
                    eval(strcat('objective=','objective','_m',num2str(m),'_n',num2str(n),';'))
                    eval(strcat('x_con=','x_con','_m',num2str(m),'_n',num2str(n),';'))
                    eval(strcat('z_con=','z_con','_m',num2str(m),'_n',num2str(n),';'))
                    eval(strcat('y_con=','y_con','_m',num2str(m),'_n',num2str(n),';'))
                    eval(strcat('modeltime1_SOCP=','modeltime1_SOCP','_m',num2str(m),'_n',num2str(n),';'))
                end
                % for k=1:Groups
                disp(['k=',num2str(k)])
                %加载m个机器n个job第k组sigma
                filename=strcat('./solve_alg_robustness/jobdata/sigma_range/sigma',num2str(l_para),'_',num2str(l_para+0.1),'_m',num2str(m),'n',num2str(n),'group',num2str(k),'.mat');
                load(filename);
                halfsigma=sqrt(sigma);%求标准差
                [sorted_sigma,pi]=sort(sigma,2);
                [time_GA(index),x_GA,obj_GA(index),ComparedMat_GA]=getInitialSolutionByGreedyAlgorithm(m,n,sigma,pi); 
                disp(['GA obj=',num2str(obj_GA(index)),',GA time=',num2str(time_GA(index))])
                
                [time_SOCP(index),x_SOCP,y_SOCP,z_SOCP,obj_SOCP(index),obj_bound_SOCP(index),modeltime_SOCP(index),solvetime_SOCP(index),gap_SOCP(index)]=solveByMixedIntegerSOCPnew_new(m,n,halfsigma,pi,optionsgurobi,constraint,x_con,y_con,z_con,objective);
                disp(['obj_SOCP',num2str(index),'=',num2str(obj_SOCP(index))]);
                index=index+1;
                % %对SOCP的解x，每个算例存一次
                % filename=strcat('.\GAresult\GA_X_m',num2str(m),'n',num2str(n),'group',num2str(k),'.mat');
                % save(filename,'x_GA');
                % 
                % filename=strcat('.\result\SOCP_X_m',num2str(m),'n',num2str(n),'group',num2str(k),'.mat');
                % save(filename,'x_SOCP','y_SOCP','z_SOCP');
                
                filename=strcat('./solve_alg_robustness/rubustness_results/SOCP_result/SOCP_m',num2str(m),'n',num2str(n),'l_para',num2str(l_para),'group',num2str(k),'.mat');
                save(filename,'time_SOCP','modeltime_SOCP','solvetime_SOCP','obj_SOCP','obj_bound_SOCP','gap_SOCP');
                filename=strcat('./solve_alg_robustness/rubustness_results/GA_result_SOCP/GA_m',num2str(m),'n',num2str(n),'l_para',num2str(l_para),'group',num2str(k),'.mat');
                save(filename,'obj_GA','time_GA');
            end
        end
    end
end



