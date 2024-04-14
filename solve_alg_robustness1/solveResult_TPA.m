%2021.8.18 chengzihan
clc
clear all
MachineArray=[20]; %机器数
%工件数 JobArray=[4*MachineArray,5*MachineArray,6*MachineArray];
Groups=10;            %每组m,m，共生成10组数据
time_GA=zeros(1,Groups);  %用来储存GA算法的时间
obj_GA=zeros(1,Groups);   %用来储存GA算法的目标值

totaltime_RHA=zeros(1,Groups); %用来储存RHA算法的时间(每一次局部搜索迭代会覆盖掉这个值)
sum_time_RHA=zeros(1,Groups); %用来储存RHA算法的时间
obj_RHA=zeros(1,Groups);  %用来储存RHA算法的目标值


time_Insert=zeros(1,Groups); %用来储存Insert操作的时间
sum_time_Insert=zeros(1,Groups); %用来储存Insert操作的时间
obj_Insert=zeros(1,Groups);  %用来储存InsertExchange算法的目标值


time_Exchange=zeros(1,Groups); %用来储存Exchange操作的时间
sum_time_Exchange=zeros(1,Groups); %用来储存Exchange操作的时间
obj_Exchange=zeros(1,Groups);  %用来储存InsertExchange算法的目标值


time=zeros(1,Groups);     %用来储存总的时间
Iteration=zeros(1,Groups);     %用来每组数据的局部搜索次数

for k=1:Groups
    for sig_ratio = 0:4
        l_para = 0.1*sig_ratio;
    for m=MachineArray
        for n=[6*m]
            disp(['########## m=',num2str(m),',n=',num2str(n),' ######'])
            index=1;
            obj_Insert_matrix=zeros(Groups,1);
            obj_Exchange_matrix=zeros(Groups,1);
            time_Insert_matrix=zeros(Groups,1);
            time_Exchange_matrix=zeros(Groups,1);
            obj_RHA_matrix=zeros(Groups,1);
            Iteration_RHA_matrx=zeros(Groups,1);%用来储存进行了多少次RHA
            Iteration_time_RHA_matrx=zeros(Groups,1);
            
        % for k=1:Groups
            disp(['k=',num2str(k)])
            filename=strcat('./solve_alg_robustness/jobdata/sigma_range/sigma',num2str(l_para),'_',num2str(l_para+0.1),'_m',num2str(m),'n',num2str(n),'group',num2str(k),'.mat');
            load(filename);
            [sorted_sigma,pi]=sort(sigma,2);
            
            %1.获取贪婪算法初始解x_GA
            [time_GA(index),x_GA,obj_GA(index),ComparedMat_GA]=getInitialSolutionByGreedyAlgorithm(m,n,sigma,pi);
            disp(['GA obj=',num2str(obj_GA(index))]);
            
            %2对m个机器n个job 第k组数据 进行插入操作
            [flag1,time_Insert(index),x_Insert,obj_Insert(index),ComparedMat_Insert]=ImproveSolutionByInsert(x_GA,m,n,sigma,ComparedMat_GA,obj_GA(index),pi);
            disp(['Insert obj=',num2str(obj_Insert(index))])
            time_Insert_matrix(index,end+1)=time_Insert(index);
            sum_time_Insert(index)=sum_time_Insert(index)+time_Insert(index);
            obj_Insert_matrix(index,end+1)=obj_Insert(index);
            obj_Insert_matrix(find(obj_Insert_matrix==0))=[1000000];
            
            %3对m个机器n个job 第k组数据 进行交换操作
            [flag2,time_Exchange(index),x_Exchange,obj_Exchange(index),ComparedMat_Exchange]=ImproveSolutionByExchange(x_Insert,m,n,sigma,ComparedMat_Insert,obj_Insert(index),pi);
            disp(['Exchange obj=',num2str(obj_Exchange(index))])
            time_Exchange_matrix(index,end+1)=time_Exchange(index);
            sum_time_Exchange(index)=sum_time_Exchange(index)+time_Exchange(index);
            obj_Exchange_matrix(index,end+1)=obj_Exchange(index);
            obj_Exchange_matrix(find(obj_Exchange_matrix==0))=[1000000];
            
            %4.RHA with multiMachine
            [x_RHA,obj_RHA(index),ComparedMat_RHA,totaltime_RHA(index),Iteration_time,Iteration_RHA,flag_impro_RHA]=solveByRHAWithMultiM(x_Exchange,m,n,sigma,pi,obj_Exchange(index),ComparedMat_Exchange);
            disp(['RHA obj=',num2str(obj_RHA(index))])
            Iteration_RHA_matrx(index,end+1)=0;
            Iteration_RHA_matrx(index,end+1)=Iteration_RHA;
            Iteration_time_RHA_matrx(index,end+1)=0;
            q=length(Iteration_time);
            Iteration_time_RHA_matrx(index,end+1:end+q)=Iteration_time;
            sum_time_RHA(index)=sum_time_RHA(index)+totaltime_RHA(index);
            obj_RHA_matrix(index,end+1)=obj_RHA(index);
            obj_RHA_matrix(find(obj_RHA_matrix==0))=[1000000];
            
            Iteration(index)=1;
            flag=1;
            while flag==1
                disp(['第',num2str(Iteration(index)),'次局部搜索']);
                %3对m个机器n个job 第k组数据 进行插入操作
                [flag1,time_Insert(index),x_Insert,obj_Insert(index),ComparedMat_Insert]=ImproveSolutionByInsert(x_RHA,m,n,sigma,ComparedMat_RHA,obj_RHA(index),pi);
                disp(['Insert obj=',num2str(obj_Insert(index))])
                time_Insert_matrix(index,end+1)=time_Insert(index);
                sum_time_Insert(index)=sum_time_Insert(index)+time_Insert(index);
                obj_Insert_matrix(index,end+1)=obj_Insert(index);
                
                %4对m个机器n个job 第k组数据 进行交换操作
                [flag2,time_Exchange(index),x_Exchange,obj_Exchange(index),ComparedMat_Exchange]=ImproveSolutionByExchange(x_Insert,m,n,sigma,ComparedMat_Insert,obj_Insert(index),pi);
                disp(['Exchange obj=',num2str(obj_Exchange(index))])
                time_Exchange_matrix(index,end+1)=time_Exchange(index);
                sum_time_Exchange(index)=sum_time_Exchange(index)+time_Exchange(index);
                
%                 if obj_Exchange(index)>=min( obj_Exchange_matrix(index,:));
%                     flag=0;
%                 end
                obj_Exchange_matrix(index,end+1)=obj_Exchange(index);
                %flag=max(flag1,flag2);
                
                if obj_Exchange(index)>=min( obj_RHA_matrix(index,:))
                    flag=0;
                end
                
                
                
                if flag==1
                    [x_RHA,obj_RHA(index),ComparedMat_RHA,totaltime_RHA(index),Iteration_time,Iteration_RHA,flag_impro_RHA]=solveByRHAWithMultiM(x_Exchange,m,n,sigma,pi,obj_Exchange(index),ComparedMat_Exchange);
                    disp(['RHA obj=',num2str(obj_RHA(index))])
                    Iteration_RHA_matrx(index,end+1)=0;
                    Iteration_RHA_matrx(index,end+1)=Iteration_RHA;
                    Iteration_time_RHA_matrx(index,end+1)=0;
                    q=length(Iteration_time);
                    Iteration_time_RHA_matrx(index,end+1:end+q)=Iteration_time;
                    sum_time_RHA(index)=sum_time_RHA(index)+totaltime_RHA(index);
                    obj_RHA_matrix(index,end+1)=obj_RHA(index);
                    Iteration(index)=Iteration(index)+1;
                end
            end
            obj_Exchange(index)=min( obj_Exchange_matrix(index,:));
            obj_Insert(index)=min( obj_Insert_matrix(index,:)); 
            obj_RHA(index)=min( obj_RHA_matrix(index,:)); 
            disp(['最终目标值为',num2str(obj_Exchange(index))])
            index=index+1;

            %储存GA 的时间和目标值
            filename=strcat('./solve_alg_robustness/rubustness_results/GA_result/GA_sigma',num2str(l_para),'_',num2str(l_para+0.1),'_m',num2str(m),'n',num2str(n),'group',num2str(k),'.mat');
            save(filename,'obj_GA','time_GA');
            % load(filename);
            %储存RHA 的时间和目标值
            filename=strcat('./solve_alg_robustness/rubustness_results/RHAresult/RHA_sigma',num2str(l_para),'_',num2str(l_para+0.1),'_m',num2str(m),'n',num2str(n),'group',num2str(k),'.mat');
            save(filename,'obj_RHA','obj_RHA_matrix','sum_time_RHA','Iteration_time_RHA_matrx','Iteration_RHA_matrx');
            load(filename);
            
            %储存InsertExchange的时间和目标值
            filename=strcat('./solve_alg_robustness/rubustness_results/InsertExchangeresult/InsertExchange_sigma',num2str(l_para),'_',num2str(l_para+0.1),'_m',num2str(m),'n',num2str(n),'group',num2str(k),'.mat');
            save(filename,'obj_Insert', 'obj_Exchange','obj_Insert_matrix','obj_Exchange_matrix','time_Insert_matrix','time_Exchange_matrix','sum_time_Insert','sum_time_Exchange');
            load(filename);
            
            
            %储存总的时间
            time=time_GA+sum_time_RHA+sum_time_Insert+sum_time_Exchange;
            filename=strcat('./solve_alg_robustness/rubustness_results/timeresult/total_sigma',num2str(l_para),'_',num2str(l_para+0.1),'_m',num2str(m),'n',num2str(n),'group',num2str(k),'.mat');
            save(filename,'time');
        end
    end
        
    end
end


