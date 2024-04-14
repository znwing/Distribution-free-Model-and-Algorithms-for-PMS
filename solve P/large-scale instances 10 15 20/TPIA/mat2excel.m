clc
clear
MachineArray=[10,15,20]; %������
%������ JobArray=[4*MachineArray,5*MachineArray,6*MachineArray];
Groups=10;
tol=5;


j=1;
for m=MachineArray
    k=0;
    for n=[4*m,5*m,6*m]
        disp(['########## m=',num2str(m),',n=',num2str(n),' ######'])
        
        %����GA ��ʱ���Ŀ��ֵ
        filename=strcat('.\GAresult\GA_m',num2str(m),'n',num2str(n),'.mat');
        load(filename);
        
        %����RHA ��ʱ���Ŀ��ֵ
        filename=strcat('.\RHAresult\RHA_m',num2str(m),'n',num2str(n),'.mat');
        load(filename);
        
        %����InsertExchange��ʱ���Ŀ��ֵ
        filename=strcat('.\InsertExchangeresult\InsertExchange_m',num2str(m),'n',num2str(n),'.mat');
        load(filename);
        
        %������ ��ʱ��
        filename=strcat('.\timeresult\total_m',num2str(m),'n',num2str(n),'.mat');
        load(filename);
        
        %�����ݷֱ�д��excel��
        k=k+1;
        xlswrite('.\excelresult\GAresult.xlsx',[time_GA,obj_GA],['Sheet',num2str(j)],['A',num2str(k)]);
        xlswrite('.\excelresult\RHAresult.xlsx',[sum_time_RHA,obj_RHA],['Sheet',num2str(j)],['A',num2str(k)]);
        xlswrite('.\excelresult\InsertExchangeresult result.xlsx',[sum_time_Insert,sum_time_Exchange,obj_Insert,obj_Exchange],['Sheet',num2str(j)],['A',num2str(k)]);
        xlswrite('.\excelresult\time result.xlsx',time,['Sheet',num2str(j)],['A',num2str(k)]);
    end
    j=j+1;
end


