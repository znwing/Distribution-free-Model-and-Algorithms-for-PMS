clc
clear
MachineArray=[2,3,5]; %������
%������ JobArray=[4*MachineArray,5*MachineArray,6*MachineArray];
Groups=10;
tol=5;

j=1;
for m=MachineArray
    for n=[4*m,5*m,6*m]
        disp(['########## m=',num2str(m),',n=',num2str(n),' ######'])
        
        %����RHA ��ʱ���Ŀ��ֵ
        filename=strcat('.\RHAresult\RHA_m',num2str(m),'n',num2str(n),'.mat');
        load(filename);
        
        %����InsertExchange��ʱ���Ŀ��ֵ
        filename=strcat('.\InsertExchangeresult\InsertExchange_m',num2str(m),'n',num2str(n),'.mat');
        load(filename);
        
        %�����ݷֱ�д��excel��
        xlswrite('.\matrixresult\objRHAresult.xlsx',[obj_RHA_matrix],['Sheet',num2str(j)]);
        xlswrite('.\matrixresult\objInsertresult.xlsx',[obj_Insert_matrix],['Sheet',num2str(j)]);
        xlswrite('.\matrixresult\objExchangeresult.xlsx',[obj_Exchange_matrix],['Sheet',num2str(j)]);
        xlswrite('.\matrixresult\timeRHAresult.xlsx',[Iteration_time_RHA_matrx],['Sheet',num2str(j)]);
        xlswrite('.\matrixresult\timeInsertresult.xlsx',[time_Insert_matrix],['Sheet',num2str(j)]);
        xlswrite('.\matrixresult\timeExchangeresult.xlsx',[time_Exchange_matrix],['Sheet',num2str(j)]);
        j=j+1;
    end
end


