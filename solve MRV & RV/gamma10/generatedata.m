MachineArray=[2,3,5];
% JobArray=[4*m,5*m,6*m];
l_paraArray=[0.1];
u_paraArray=[0.25];
lbArray=[10];%均匀分布下界   
ubArray=[100];%均匀分布上界   
Groups=10;

for lb=lbArray
    for ub=ubArray
        sheetname=[num2str(lb),'-',num2str(ub)];
        location1=1;
        for l_para=l_paraArray
            for u_para=u_paraArray
                
                disp(['均值分布范围：',num2str(lb),'-',num2str(ub),';标准差分布：',num2str(l_para),'mu','-',num2str(u_para),'mu'])
                for m=MachineArray
                    for n=[4*m,5*m,6*m]
                        disp(['########## m=',num2str(m),',n=',num2str(n),' ######'])
                        index=1;
                        for k=1:Groups
                            disp(['k=',num2str(k)])
                            %存sigma
                            [mu,sigma,halfsigma]=getSigma(m,n,lb,ub,l_para,u_para);
                            filename=strcat('.\jobdata\mu',num2str(lb),'_',num2str(ub),'\sigma',num2str(l_para),'_',num2str(u_para),'_m',num2str(m),'n',num2str(n),'group',num2str(k),'.mat');
                            save(filename,'mu','sigma');
                        end
                    end
                end
            end
        end
    end
end
