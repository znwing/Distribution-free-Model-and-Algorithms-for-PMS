MachineArray=[10,15,20];%2,3,6,9   10,20,30
% JobArray=[10,15,20];%10,15,20,25,30,35,40,45,50,|60,80,100    10,20,40,60,80,100
% JobArray=[4*MachineArray,5*MachineArray,6*MachineArray];
l_paraArray=[0.1];
u_paraArray=[0.25];%u_para*mu�Ǳ�׼��ֲ����Ͻ磬��׼��ֲ��½�ȡ0.1*mu   %,0.3,0.35,0.4
lbArray=[10];%���ȷֲ��½�   %5,
ubArray=[100];%���ȷֲ��Ͻ�   %,125,150
Groups=10;

for lb=lbArray
    for ub=ubArray
        sheetname=[num2str(lb),'-',num2str(ub)];
        location1=1;
        for l_para=l_paraArray
            for u_para=u_paraArray
                
                disp(['��ֵ�ֲ���Χ��',num2str(lb),'-',num2str(ub),';��׼��ֲ���',num2str(l_para),'mu','-',num2str(u_para),'mu'])
                for m=MachineArray
                    for n=[4*m,5*m,6*m]
                        disp(['########## m=',num2str(m),',n=',num2str(n),' ######'])
                        index=1;
                        for k=1:Groups
                            disp(['k=',num2str(k)])
                            %[sigma,halfsigma,sorted_sigma,pi]=getSigma(m,n,lb,ub,l_para,u_para);
                            
                            %��sigma
                            [mu,sigma,halfsigma]=getSigma(m,n,lb,ub,l_para,u_para);
                            filename=strcat('.\jobdata\mu',num2str(lb),'_',num2str(ub),'\sigma',num2str(l_para),'_',num2str(u_para),'_m',num2str(m),'n',num2str(n),'group',num2str(k),'.mat');
                            save(filename,'sigma');
                        end
                    end
                end
            end
        end
    end
end




