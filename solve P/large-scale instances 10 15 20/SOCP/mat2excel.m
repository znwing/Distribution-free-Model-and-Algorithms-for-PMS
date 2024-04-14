clc
clear
MachineArray=[10,15,20];
% JobArray=[10,15,20];
Groups=10;
tol=5;



j=1;
for m=MachineArray
    k=0;
    for n=[4*m,5*m,6*m]
        disp(['########## m=',num2str(m),',n=',num2str(n),' ######'])
        filename=strcat('.\result\SOCP_m',num2str(m),'n',num2str(n),'tol',num2str(5),'.mat');
        load(filename);
        filename=strcat('.\GAresult\GA_m',num2str(m),'n',num2str(n),'tol',num2str(5),'.mat');
        load(filename);
        k=k+1;
        xlswrite('.\excelresult\SOCPresult.xlsx',[obj_SOCP,obj_bound_SOCP,gap_SOCP,modeltime_SOCP,solvetime_SOCP,time_SOCP],['Sheet',num2str(j)],['A',num2str(k)]);
        xlswrite('.\excelresult\GAresult.xlsx',[obj_GA,time_GA],['Sheet',num2str(j)],['A',num2str(k)]);
    end
    j=j+1;
end

