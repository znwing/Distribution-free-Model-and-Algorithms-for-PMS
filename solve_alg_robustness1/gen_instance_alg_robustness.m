

for sig_ratio = 0:4
MachineArray=[20];%2,3,6,9   10,20,30
% JobArray=[10,15,20];%10,15,20,25,30,35,40,45,50,|60,80,100    10,20,40,60,80,100
% JobArray=[4*MachineArray,5*MachineArray,6*MachineArray];
l_paraArray=0.1*sig_ratio;
u_paraArray=l_paraArray + 0.1;%u_para*mu是标准差分布的上界，标准差分布下界取0.1*mu   %,0.3,0.35,0.4
lbArray=[10];%均匀分布下界   %5,
ubArray=[100];%均匀分布上界   %,125,150
Groups=10;

for lb=lbArray
    for ub=ubArray
        sheetname=[num2str(lb),'-',num2str(ub)];
        location1=1;
        for l_para=l_paraArray
            for u_para=u_paraArray
                
                disp(['均值分布范围：',num2str(lb),'-',num2str(ub),';标准差分布：',num2str(l_para),'mu','-',num2str(u_para),'mu'])
                for m=MachineArray
                    for n=[6*m]
                        disp(['########## m=',num2str(m),',n=',num2str(n),' ######'])
                        index=1;
                        for k=1:Groups
                            disp(['k=',num2str(k)])
                            %[sigma,halfsigma,sorted_sigma,pi]=getSigma(m,n,lb,ub,l_para,u_para);
                            
                            %存sigma
                            [mu,sigma,halfsigma]=getSigma(m,n,lb,ub,l_para,u_para);
                            filename=strcat('./solve_alg_robustness/jobdata/sigma_range/sigma',num2str(l_para),'_',num2str(u_para),'_m',num2str(m),'n',num2str(n),'group',num2str(k),'.mat');
                            disp(filename)
                            save(filename,'sigma');
                        end
                    end
                end
            end
        end
    end
end

end


