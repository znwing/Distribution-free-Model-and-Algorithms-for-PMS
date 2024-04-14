%2021.8.18 chengzihan
clc
clear all
MachineArray=[10,15,20]; %������
%������ JobArray=[4*MachineArray,5*MachineArray,6*MachineArray];
Groups=10;            %ÿ��m,m��������10������
time_GA=zeros(1,Groups);  %��������GA�㷨��ʱ��
obj_GA=zeros(1,Groups);   %��������GA�㷨��Ŀ��ֵ

totaltime_RHA=zeros(1,Groups); %��������RHA�㷨��ʱ��(ÿһ�ξֲ����������Ḳ�ǵ����ֵ)
sum_time_RHA=zeros(1,Groups); %��������RHA�㷨��ʱ��
obj_RHA=zeros(1,Groups);  %��������RHA�㷨��Ŀ��ֵ


time_Insert=zeros(1,Groups); %��������Insert������ʱ��
sum_time_Insert=zeros(1,Groups); %��������Insert������ʱ��
obj_Insert=zeros(1,Groups);  %��������InsertExchange�㷨��Ŀ��ֵ


time_Exchange=zeros(1,Groups); %��������Exchange������ʱ��
sum_time_Exchange=zeros(1,Groups); %��������Exchange������ʱ��
obj_Exchange=zeros(1,Groups);  %��������InsertExchange�㷨��Ŀ��ֵ


time=zeros(1,Groups);     %���������ܵ�ʱ��
Iteration=zeros(1,Groups);     %����ÿ�����ݵľֲ���������


for m=MachineArray
    for n=[4*m,5*m,6*m]
        disp(['########## m=',num2str(m),',n=',num2str(n),' ######'])
        index=1;
        obj_Insert_matrix=zeros(Groups,1);
        obj_Exchange_matrix=zeros(Groups,1);
        time_Insert_matrix=zeros(Groups,1);
        time_Exchange_matrix=zeros(Groups,1);
        obj_RHA_matrix=zeros(Groups,1);
        Iteration_RHA_matrx=zeros(Groups,1);%������������˶��ٴ�RHA
        Iteration_time_RHA_matrx=zeros(Groups,1);
        
        for k=1:Groups
            disp(['k=',num2str(k)])
            filename=strcat('.\jobdata\mu10_100\sigma0.1_0.25','_m',num2str(m),'n',num2str(n),'group',num2str(k),'.mat');
            load(filename);
            [sorted_sigma,pi]=sort(sigma,2);
            
            %1.��ȡ̰���㷨��ʼ��x_GA
            [time_GA(index),x_GA,obj_GA(index),ComparedMat_GA]=getInitialSolutionByGreedyAlgorithm(m,n,sigma,pi);
            disp(['GA obj=',num2str(obj_GA(index))]);
            
            %2��m������n��job ��k������ ���в������
            [flag1,time_Insert(index),x_Insert,obj_Insert(index),ComparedMat_Insert]=ImproveSolutionByInsert(x_GA,m,n,sigma,ComparedMat_GA,obj_GA(index),pi);
            disp(['Insert obj=',num2str(obj_Insert(index))])
            time_Insert_matrix(index,end+1)=time_Insert(index);
            sum_time_Insert(index)=sum_time_Insert(index)+time_Insert(index);
            obj_Insert_matrix(index,end+1)=obj_Insert(index);
            obj_Insert_matrix(find(obj_Insert_matrix==0))=[1000000];
            
            %3��m������n��job ��k������ ���н�������
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
                disp(['��',num2str(Iteration(index)),'�ξֲ�����']);
                %3��m������n��job ��k������ ���в������
                [flag1,time_Insert(index),x_Insert,obj_Insert(index),ComparedMat_Insert]=ImproveSolutionByInsert(x_RHA,m,n,sigma,ComparedMat_RHA,obj_RHA(index),pi);
                disp(['Insert obj=',num2str(obj_Insert(index))])
                time_Insert_matrix(index,end+1)=time_Insert(index);
                sum_time_Insert(index)=sum_time_Insert(index)+time_Insert(index);
                obj_Insert_matrix(index,end+1)=obj_Insert(index);
                
                %4��m������n��job ��k������ ���н�������
                [flag2,time_Exchange(index),x_Exchange,obj_Exchange(index),ComparedMat_Exchange]=ImproveSolutionByExchange(x_Insert,m,n,sigma,ComparedMat_Insert,obj_Insert(index),pi);
                disp(['Exchange obj=',num2str(obj_Exchange(index))])
                time_Exchange_matrix(index,end+1)=time_Exchange(index);
                sum_time_Exchange(index)=sum_time_Exchange(index)+time_Exchange(index);
                
%                 if obj_Exchange(index)>=min( obj_Exchange_matrix(index,:));
%                     flag=0;
%                 end
                obj_Exchange_matrix(index,end+1)=obj_Exchange(index);
                %flag=max(flag1,flag2);
                
                if obj_Exchange(index)>=min( obj_RHA_matrix(index,:));
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
            disp(['����Ŀ��ֵΪ',num2str(obj_Exchange(index))])
            index=index+1;
        end
        
        %����GA ��ʱ���Ŀ��ֵ
        filename=strcat('.\GAresult\GA_m',num2str(m),'n',num2str(n),'.mat');
        save(filename,'obj_GA','time_GA');
        load(filename);
        
        %����RHA ��ʱ���Ŀ��ֵ
        filename=strcat('.\RHAresult\RHA_m',num2str(m),'n',num2str(n),'.mat');
        save(filename,'obj_RHA','obj_RHA_matrix','sum_time_RHA','Iteration_time_RHA_matrx','Iteration_RHA_matrx');
        load(filename);
        
        %����InsertExchange��ʱ���Ŀ��ֵ
        filename=strcat('.\InsertExchangeresult\InsertExchange_m',num2str(m),'n',num2str(n),'.mat');
        save(filename,'obj_Insert', 'obj_Exchange','obj_Insert_matrix','obj_Exchange_matrix','time_Insert_matrix','time_Exchange_matrix','sum_time_Insert','sum_time_Exchange');
        load(filename);
        
        
        %�����ܵ�ʱ��
        time=time_GA+sum_time_RHA+sum_time_Insert+sum_time_Exchange;
        filename=strcat('.\timeresult\total_m',num2str(m),'n',num2str(n),'.mat');
        save(filename,'time');
    end
end
