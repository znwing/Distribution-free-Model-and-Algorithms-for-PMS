clc
clear
MachineArray=[10,15,20]; %机器数
%工件数 JobArray=[4*MachineArray,5*MachineArray,6*MachineArray];
Groups=10;
tol=5;


j=1;
for m=MachineArray
    k=0;
    for n=[4*m,5*m,6*m]
        disp(['########## m=',num2str(m),',n=',num2str(n),' ######'])
        
        %加载GA 的时间和目标值
        filename=strcat('.\GAresult\GA_m',num2str(m),'n',num2str(n),'.mat');
        load(filename);
        
        %加载RHA 的时间和目标值
        filename=strcat('.\RHAresult\RHA_m',num2str(m),'n',num2str(n),'.mat');
        load(filename);
        
        %加载InsertExchange的时间和目标值
        filename=strcat('.\InsertExchangeresult\InsertExchange_m',num2str(m),'n',num2str(n),'.mat');
        load(filename);
        
        %加载总 的时间
        filename=strcat('.\timeresult\total_m',num2str(m),'n',num2str(n),'.mat');
        load(filename);
        
        %将数据分别写入excel表
        k=k+1;
        xlswrite('.\excelresult\GAresult.xlsx',[time_GA,obj_GA],['Sheet',num2str(j)],['A',num2str(k)]);
        xlswrite('.\excelresult\RHAresult.xlsx',[sum_time_RHA,obj_RHA],['Sheet',num2str(j)],['A',num2str(k)]);
        xlswrite('.\excelresult\InsertExchangeresult result.xlsx',[sum_time_Insert,sum_time_Exchange,obj_Insert,obj_Exchange],['Sheet',num2str(j)],['A',num2str(k)]);
        xlswrite('.\excelresult\time result.xlsx',time,['Sheet',num2str(j)],['A',num2str(k)]);
    end
    j=j+1;
end


