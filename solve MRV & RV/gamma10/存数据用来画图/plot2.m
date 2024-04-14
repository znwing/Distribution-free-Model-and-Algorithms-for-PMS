
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%画方差图%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %正态
% N_dw_std=zeros(1,9);
% N_d0_std=zeros(1,9);
% N_d05_std=zeros(1,9);
% N_d1_std=zeros(1,9);
% N_dN_std=zeros(1,9);
% %gamma
% G_dw_std=zeros(1,9);
% G_d0_std=zeros(1,9);
% G_d05_std=zeros(1,9);
% G_d1_std=zeros(1,9);
% G_dG_std=zeros(1,9);
% %pareto
% P_dw_std=zeros(1,9);
% P_d0_std=zeros(1,9);
% P_d05_std=zeros(1,9);
% P_d1_std=zeros(1,9);
% P_dP_std=zeros(1,9);
% %bimodal
% S_dw_std=zeros(1,9);
% S_d0_std=zeros(1,9);
% S_d05_std=zeros(1,9);
% S_d1_std=zeros(1,9);
% S_dS_std=zeros(1,9);
% index=1;
% for gamma=[1/5,1/4,1/3,1/2,1,2,3,4,5]
%     filename=strcat('gamma=',num2str(gamma),'_N_cost.mat');
%     load(filename);
%     filename=strcat('gamma=',num2str(gamma),'_G_cost.mat');
%     load(filename);
%     filename=strcat('gamma=',num2str(gamma),'_P_cost.mat');
%     load(filename);
%     filename=strcat('gamma=',num2str(gamma),'_S_cost.mat');
%     load(filename);
%     
%     %正态
%     N_dw_std(index)=mean(std(N_cost1));
%     N_d0_std(index)=mean(std(N_cost2));
%     N_d05_std(index)=mean(std(N_cost3));
%     N_d1_std(index)=mean(std(N_cost4));
%     N_dN_std(index)=mean(std(N_cost5));
%     %gamma
%     G_dw_std(index)=mean(std(G_cost1));
%     G_d0_std(index)=mean(std(G_cost2));
%     G_d05_std(index)=mean(std(G_cost3));
%     G_d1_std(index)=mean(std(G_cost4));
%     G_dG_std(index)=mean(std(G_cost6));
%     %pareto
%     P_dw_std(index)=mean(std(P_cost1));
%     P_d0_std(index)=mean(std(P_cost2));
%     P_d05_std(index)=mean(std(P_cost3));
%     P_d1_std(index)=mean(std(P_cost4));
%     P_dP_std(index)=mean(std(P_cost7));
%     %bimodal
%     S_dw_std(index)=mean(std(S_cost1));
%     S_d0_std(index)=mean(std(S_cost2));
%     S_d05_std(index)=mean(std(S_cost3));
%     S_d1_std(index)=mean(std(S_cost4));
%     S_dS_std(index)=mean(std(S_cost8));
%     index=index+1;
% end

% figure;
% ind=1:9;
% plot(ind,N_dw_std);
% hold on;
% plot(ind,N_d0_std);
% hold on;
% plot(ind,N_d05_std);
% hold on;
% plot(ind,N_d1_std);
% set(gca,'XTick',ind);
% set(gca,'XTickLabel',{'0.2','0.25','0.33','0.5','1','2','3','4','5'});
% xlabel('gamma');
% ylabel('std');
% title('normal');
% legend('d_{w^*}','d_0','d_{0.5}','d_1');
% 
% figure;
% ind=1:9;
% plot(ind,G_dw_std);
% hold on;
% plot(ind,G_d0_std);
% hold on;
% plot(ind,G_d05_std);
% hold on;
% plot(ind,G_d1_std);
% set(gca,'XTick',ind);
% set(gca,'XTickLabel',{'0.2','0.25','0.33','0.5','1','2','3','4','5'});
% xlabel('gamma');
% ylabel('std');
% title('gamma');
% legend('d_{w^*}','d_0','d_{0.5}','d_1');
% 
% figure;
% ind=1:9;
% plot(ind,P_dw_std);
% hold on;
% plot(ind,P_d0_std);
% hold on;
% plot(ind,P_d05_std);
% hold on;
% plot(ind,P_d1_std);
% set(gca,'XTick',ind);
% set(gca,'XTickLabel',{'0.2','0.25','0.33','0.5','1','2','3','4','5'});
% xlabel('gamma');
% ylabel('std');
% title('pareto');
% legend('d_{w^*}','d_0','d_{0.5}','d_1');
% 
% 
% figure;
% ind=1:9;
% plot(ind,S_dw_std);
% hold on;
% plot(ind,S_d0_std);
% hold on;
% plot(ind,S_d05_std);
% hold on;
% plot(ind,S_d1_std);
% set(gca,'XTick',ind);
% set(gca,'XTickLabel',{'0.2','0.25','0.33','0.5','1','2','3','4','5'});
% xlabel('gamma');
% ylabel('std');
% title('bimodal');
% legend('d_{w^*}','d_0','d_{0.5}','d_1');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%画VaR分位点图%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %正态
% N_dw_VaR=zeros(1,19);
% N_d0_VaR=zeros(1,19);
% N_d05_VaR=zeros(1,19);
% N_d1_VaR=zeros(1,19);
% N_dN_VaR=zeros(1,19);
% %gamma
% G_dw_VaR=zeros(1,19);
% G_d0_VaR=zeros(1,19);
% G_d05_VaR=zeros(1,19);
% G_d1_VaR=zeros(1,19);
% G_dG_VaR=zeros(1,9);
% %pareto
% P_dw_VaR=zeros(1,19);
% P_d0_VaR=zeros(1,19);
% P_d05_VaR=zeros(1,19);
% P_d1_VaR=zeros(1,19);
% P_dP_VaR=zeros(1,19);
% %bimodal
% S_dw_VaR=zeros(1,19);
% S_d0_VaR=zeros(1,19);
% S_d05_VaR=zeros(1,19);
% S_d1_VaR=zeros(1,19);
% S_dS_VaR=zeros(1,19);
% index=1;
% for gamma=[1/10,1/9,1/8,1/7,1/6,1/5,1/4,1/3,1/2,1,2,3,4,5,6,7,8,9,10]
%     disp(['gamma=',num2str(gamma)])
%     filename=strcat('gamma=',num2str(gamma),'_N_cost.mat');
%     load(filename);
%     filename=strcat('gamma=',num2str(gamma),'_G_cost.mat');
%     load(filename);
%     filename=strcat('gamma=',num2str(gamma),'_P_cost.mat');
%     load(filename);
%     filename=strcat('gamma=',num2str(gamma),'_S_cost.mat');
%     load(filename);
%     
%     level=10^4*0.8;
%     sorted_N_cost1=sort(N_cost1);
%     sorted_N_cost2=sort(N_cost2);
%     sorted_N_cost3=sort(N_cost3);
%     sorted_N_cost4=sort(N_cost4);
%     sorted_N_cost5=sort(N_cost5);
%     %正态
%     N_dw_VaR(index)=mean(sorted_N_cost1(level,:));
%     N_d0_VaR(index)=mean(sorted_N_cost2(level,:));
%     N_d05_VaR(index)=mean(sorted_N_cost3(level,:));
%     N_d1_VaR(index)=mean(sorted_N_cost4(level,:));
%     N_dN_VaR(index)=mean(sorted_N_cost5(level,:));
%     %gamma
%     sorted_G_cost1=sort(G_cost1);
%     sorted_G_cost2=sort(G_cost2);
%     sorted_G_cost3=sort(G_cost3);
%     sorted_G_cost4=sort(G_cost4);
%     sorted_G_cost6=sort(G_cost6);
%     G_dw_VaR(index)=mean(sorted_G_cost1(level,:));
%     G_d0_VaR(index)=mean(sorted_G_cost2(level,:));
%     G_d05_VaR(index)=mean(sorted_G_cost3(level,:));
%     G_d1_VaR(index)=mean(sorted_G_cost4(level,:));
%     G_dG_VaR(index)=mean(sorted_G_cost6(level,:));
%     %pareto
%     sorted_P_cost1=sort(P_cost1);
%     sorted_P_cost2=sort(P_cost2);
%     sorted_P_cost3=sort(P_cost3);
%     sorted_P_cost4=sort(P_cost4);
%     sorted_P_cost7=sort(P_cost7);
%     P_dw_VaR(index)=mean(sorted_P_cost1(level,:));
%     P_d0_VaR(index)=mean(sorted_P_cost2(level,:));
%     P_d05_VaR(index)=mean(sorted_P_cost3(level,:));
%     P_d1_VaR(index)=mean(sorted_P_cost4(level,:));
%     P_dP_VaR(index)=mean(sorted_P_cost7(level,:));
%     %bimodal
%     sorted_S_cost1=sort(S_cost1);
%     sorted_S_cost2=sort(S_cost2);
%     sorted_S_cost3=sort(S_cost3);
%     sorted_S_cost4=sort(S_cost4);
%     sorted_S_cost8=sort(S_cost8);
%     S_dw_VaR(index)=mean(sorted_S_cost1(level,:));
%     S_d0_VaR(index)=mean(sorted_S_cost2(level,:));
%     S_d05_VaR(index)=mean(sorted_S_cost3(level,:));
%     S_d1_VaR(index)=mean(sorted_S_cost4(level,:));
%     S_dS_VaR(index)=mean(sorted_S_cost8(level,:));
%     index=index+1;
% end
% 
% figure;
% ind=1:19;
% plot(ind,N_dw_VaR);
% hold on;
% plot(ind,N_d0_VaR);
% hold on;
% plot(ind,N_d05_VaR);
% hold on;
% plot(ind,N_d1_VaR);
% set(gca,'XTick',ind);
% set(gca,'XTickLabel',{'1/10','1/9','1/8','1/7','1/6','1/5','1/4','1/3','1/2','1','2','3','4','5','6','7','8','9','10'});
% xlabel('gamma');
% ylabel('VaR_{0.8}');
% title('normal');
% legend('d_{w^*}','d_0','d_{0.5}','d_1');
% 
% figure;
% ind=1:19;
% plot(ind,G_dw_VaR);
% hold on;
% plot(ind,G_d0_VaR);
% hold on;
% plot(ind,G_d05_VaR);
% hold on;
% plot(ind,G_d1_VaR);
% set(gca,'XTick',ind);
% set(gca,'XTickLabel',{'1/10','1/9','1/8','1/7','1/6','1/5','1/4','1/3','1/2','1','2','3','4','5','6','7','8','9','10'});
% xlabel('gamma');
% ylabel('VaR_{0.8}');
% title('gamma');
% legend('d_{w^*}','d_0','d_{0.5}','d_1');
% 
% figure;
% ind=1:19;
% plot(ind,P_dw_VaR);
% hold on;
% plot(ind,P_d0_VaR);
% hold on;
% plot(ind,P_d05_VaR);
% hold on;
% plot(ind,P_d1_VaR);
% set(gca,'XTick',ind);
% set(gca,'XTickLabel',{'1/10','1/9','1/8','1/7','1/6','1/5','1/4','1/3','1/2','1','2','3','4','5','6','7','8','9','10'});
% xlabel('gamma');
% ylabel('VaR_{0.8}');
% title('pareto');
% legend('d_{w^*}','d_0','d_{0.5}','d_1');
% 
% 
% figure;
% ind=1:19;
% plot(ind,S_dw_VaR);
% hold on;
% plot(ind,S_d0_VaR);
% hold on;
% plot(ind,S_d05_VaR);
% hold on;
% plot(ind,S_d1_VaR);
% set(gca,'XTick',ind);
% set(gca,'XTickLabel',{'1/10','1/9','1/8','1/7','1/6','1/5','1/4','1/3','1/2','1','2','3','4','5','6','7','8','9','10'});
% xlabel('gamma');
% ylabel('VaR_{0.8}');
% title('bimodal');
% legend('d_{w^*}','d_0','d_{0.5}','d_1');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%平均成本%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% filename=strcat('N_meancost.mat');
% load(filename);
% filename=strcat('G_meancost.mat');
% load(filename);
% filename=strcat('P_meancost.mat');
% load(filename);
% filename=strcat('S_meancost.mat');
% load(filename);
% 
% %正态
% N_dw_Ecost=mean(N_gamma_meancost1,2);
% N_d0_Ecost=mean(N_gamma_meancost2,2);
% N_d05_Ecost=mean(N_gamma_meancost3,2);
% N_d1_Ecost=mean(N_gamma_meancost4,2);
% N_dN_Ecost=mean(N_gamma_meancost5,2);
% %gamma
% G_dw_Ecost=mean(G_gamma_meancost1,2);
% G_d0_Ecost=mean(G_gamma_meancost2,2);
% G_d05_Ecost=mean(G_gamma_meancost3,2);
% G_d1_Ecost=mean(G_gamma_meancost4,2);
% G_dG_Ecost=mean(G_gamma_meancost6,2);
% %pareto
% P_dw_Ecost=mean(P_gamma_meancost1,2);
% P_d0_Ecost=mean(P_gamma_meancost2,2);
% P_d05_Ecost=mean(P_gamma_meancost3,2);
% P_d1_Ecost=mean(P_gamma_meancost4,2);
% P_dP_Ecost=mean(P_gamma_meancost7,2);
% %bimodal
% S_dw_Ecost=mean(S_gamma_meancost1,2);
% S_d0_Ecost=mean(S_gamma_meancost2,2);
% S_d05_Ecost=mean(S_gamma_meancost3,2);
% S_d1_Ecost=mean(S_gamma_meancost4,2);
% S_dS_Ecost=mean(S_gamma_meancost8,2);
% 
% 
% figure;
% ind=1:19;
% plot(ind,N_dw_Ecost);
% hold on;
% plot(ind,N_d0_Ecost);
% hold on;
% plot(ind,N_d05_Ecost);
% hold on;
% plot(ind,N_d1_Ecost);
% set(gca,'XTick',ind);
% set(gca,'XTickLabel',{'1/10','1/9','1/8','1/7','1/6','1/5','1/4','1/3','1/2','1','2','3','4','5','6','7','8','9','10'});
% xlabel('gamma');
% ylabel('Ecost');
% title('normal');
% legend('d_{w^*}','d_0','d_{0.5}','d_1');
% 
% figure;
% ind=1:19;
% plot(ind,G_dw_Ecost);
% hold on;
% plot(ind,G_d0_Ecost);
% hold on;
% plot(ind,G_d05_Ecost);
% hold on;
% plot(ind,G_d1_Ecost);
% set(gca,'XTick',ind);
% set(gca,'XTickLabel',{'1/10','1/9','1/8','1/7','1/6','1/5','1/4','1/3','1/2','1','2','3','4','5','6','7','8','9','10'});
% xlabel('gamma');
% ylabel('Ecost');
% title('gamma');
% legend('d_{w^*}','d_0','d_{0.5}','d_1');
% 
% figure;
% ind=1:19;
% plot(ind,P_dw_Ecost);
% hold on;
% plot(ind,P_d0_Ecost);
% hold on;
% plot(ind,P_d05_Ecost);
% hold on;
% plot(ind,P_d1_Ecost);
% set(gca,'XTick',ind);
% set(gca,'XTickLabel',{'1/10','1/9','1/8','1/7','1/6','1/5','1/4','1/3','1/2','1','2','3','4','5','6','7','8','9','10'});
% xlabel('gamma');
% ylabel('Ecost');
% title('pareto');
% legend('d_{w^*}','d_0','d_{0.5}','d_1');
% 
% 
% figure;
% ind=1:19;
% plot(ind,S_dw_Ecost);
% hold on;
% plot(ind,S_d0_Ecost);
% hold on;
% plot(ind,S_d05_Ecost);
% hold on;
% plot(ind,S_d1_Ecost);
% set(gca,'XTick',ind);
% set(gca,'XTickLabel',{'1/10','1/9','1/8','1/7','1/6','1/5','1/4','1/3','1/2','1','2','3','4','5','6','7','8','9','10'});
% xlabel('gamma');
% ylabel('Ecost');
% title('bimodal');
% legend('d_{w^*}','d_0','d_{0.5}','d_1');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%上半方差%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %正态
% N_dw_semistd=zeros(1,9);
% N_d0_semistd=zeros(1,9);
% N_d05_semistd=zeros(1,9);
% N_d1_semistd=zeros(1,9);
% N_dN_semistd=zeros(1,9);
% %gamma
% G_dw_semistd=zeros(1,9);
% G_d0_semistd=zeros(1,9);
% G_d05_semistd=zeros(1,9);
% G_d1_semistd=zeros(1,9);
% G_dG_semistd=zeros(1,9);
% %pareto
% P_dw_semistd=zeros(1,9);
% P_d0_semistd=zeros(1,9);
% P_d05_semistd=zeros(1,9);
% P_d1_semistd=zeros(1,9);
% P_dP_semistd=zeros(1,9);
% %bimodal
% S_dw_semistd=zeros(1,9);
% S_d0_semistd=zeros(1,9);
% S_d05_semistd=zeros(1,9);
% S_d1_semistd=zeros(1,9);
% S_dS_semistd=zeros(1,9);
% index=1;
% for gamma=[1/5,1/4,1/3,1/2,1,2,3,4,5]
%     filename=strcat('gamma=',num2str(gamma),'_N_cost.mat');
%     load(filename);
%     filename=strcat('gamma=',num2str(gamma),'_G_cost.mat');
%     load(filename);
%     filename=strcat('gamma=',num2str(gamma),'_P_cost.mat');
%     load(filename);
%     filename=strcat('gamma=',num2str(gamma),'_S_cost.mat');
%     load(filename);
%     
%     Nx1=mean(N_cost1);
%     Nx2=mean(N_cost2);
%     Nx3=mean(N_cost3);
%     Nx4=mean(N_cost4);
%     Nx5=mean(N_cost5);
%     Gx1=mean(G_cost1);
%     Gx2=mean(G_cost2);
%     Gx3=mean(G_cost3);
%     Gx4=mean(G_cost4);
%     Gx6=mean(G_cost6);
%     Px1=mean(P_cost1);
%     Px2=mean(P_cost2);
%     Px3=mean(P_cost3);
%     Px4=mean(P_cost4);
%     Px7=mean(P_cost7);
%     Sx1=mean(S_cost1);
%     Sx2=mean(S_cost2);
%     Sx3=mean(S_cost3);
%     Sx4=mean(S_cost4);
%     Sx8=mean(S_cost8);
%     for j=1:100
%         for i=1:10^4
%             if N_cost1(i,j)<Nx1(j)
%                 N_cost1(i,j)= Nx1(j);
%             end
%             if N_cost2(i,j)<Nx2(j)
%                 N_cost2(i,j)= Nx2(j);
%             end
%             if N_cost3(i,j)<Nx3(j)
%                 N_cost3(i,j)= Nx3(j);
%             end
%             if N_cost4(i,j)<Nx4(j)
%                 N_cost4(i,j)= Nx4(j);
%             end
%             if N_cost5(i,j)<Nx5(j)
%                 N_cost5(i,j)= Nx5(j);
%             end
%             %gamma
%             if G_cost1(i,j)<Gx1(j)
%                 G_cost1(i,j)= Gx1(j);
%             end
%             if G_cost2(i,j)<Gx2(j)
%                 G_cost2(i,j)= Gx2(j);
%             end
%             if G_cost3(i,j)<Gx3(j)
%                 G_cost3(i,j)= Gx3(j);
%             end
%             if G_cost4(i,j)<Gx4(j)
%                 G_cost4(i,j)= Gx4(j);
%             end
%             if G_cost6(i,j)<Gx6(j)
%                 G_cost6(i,j)= Gx6(j);
%             end
%             %pareto
%             if P_cost1(i,j)<Px1(j)
%                 P_cost1(i,j)= Px1(j);
%             end
%             if P_cost2(i,j)<Px2(j)
%                 P_cost2(i,j)= Px2(j);
%             end
%             if P_cost3(i,j)<Px3(j)
%                 P_cost3(i,j)= Px3(j);
%             end
%             if P_cost4(i,j)<Px4(j)
%                 P_cost4(i,j)= Px4(j);
%             end
%             if P_cost7(i,j)<Px7(j)
%                 P_cost7(i,j)= Px7(j);
%             end
%             %bimodal
%             if S_cost1(i,j)<Sx1(j)
%                 S_cost1(i,j)= Sx1(j);
%             end
%             if S_cost2(i,j)<Sx2(j)
%                 S_cost2(i,j)= Sx2(j);
%             end
%             if S_cost3(i,j)<Sx3(j)
%                 S_cost3(i,j)= Sx3(j);
%             end
%             if S_cost4(i,j)<Sx4(j)
%                 S_cost4(i,j)= Sx4(j);
%             end
%             if S_cost8(i,j)<Sx8(j)
%                 S_cost8(i,j)= Sx8(j);
%             end
%         end
%     end
%     %正态
%     for j=1:100
%         for i=1:10^4
%             N_cost1(i,j)=(N_cost1(i,j)-Nx1(j))^2;
%             N_cost2(i,j)=(N_cost2(i,j)-Nx2(j))^2;
%             N_cost3(i,j)=(N_cost3(i,j)-Nx3(j))^2;
%             N_cost4(i,j)=(N_cost4(i,j)-Nx4(j))^2;
%             N_cost5(i,j)=(N_cost5(i,j)-Nx5(j))^2;
%             G_cost1(i,j)=(G_cost1(i,j)-Gx1(j))^2;
%             G_cost2(i,j)=(G_cost2(i,j)-Gx2(j))^2;
%             G_cost3(i,j)=(G_cost3(i,j)-Gx3(j))^2;
%             G_cost4(i,j)=(G_cost4(i,j)-Gx4(j))^2;
%             G_cost6(i,j)=(G_cost6(i,j)-Gx6(j))^2;
%             P_cost1(i,j)=(P_cost1(i,j)-Px1(j))^2;
%             P_cost2(i,j)=(P_cost2(i,j)-Px2(j))^2;
%             P_cost3(i,j)=(P_cost3(i,j)-Px3(j))^2;
%             P_cost4(i,j)=(P_cost4(i,j)-Px4(j))^2;
%             P_cost7(i,j)=(P_cost7(i,j)-Px7(j))^2;
%             S_cost1(i,j)=(S_cost1(i,j)-Sx1(j))^2;
%             S_cost2(i,j)=(S_cost2(i,j)-Sx2(j))^2;
%             S_cost3(i,j)=(S_cost3(i,j)-Sx3(j))^2;
%             S_cost4(i,j)=(S_cost4(i,j)-Sx4(j))^2;
%             S_cost8(i,j)=(S_cost8(i,j)-Sx8(j))^2;
%         end
%     end
%     N_dw_semistd(index)=mean(mean(N_cost1).^(0.5));
%     N_d0_semistd(index)=mean(mean(N_cost2).^(0.5));
%     N_d05_semistd(index)=mean(mean(N_cost3).^(0.5));
%     N_d1_semistd(index)=mean(mean(N_cost4).^(0.5));
%     N_dN_semistd(index)=mean(mean(N_cost5).^(0.5));
%     %gamma
%     G_dw_semistd(index)=mean(mean(G_cost1).^(0.5));
%     G_d0_semistd(index)=mean(mean(G_cost2).^(0.5));
%     G_d05_semistd(index)=mean(mean(G_cost3).^(0.5));
%     G_d1_semistd(index)=mean(mean(G_cost4).^(0.5));
%     G_dG_semistd(index)=mean(mean(G_cost6).^(0.5));
%     %pareto
%     P_dw_semistd(index)=mean(mean(P_cost1).^(0.5));
%     P_d0_semistd(index)=mean(mean(P_cost2).^(0.5));
%     P_d05_semistd(index)=mean(mean(P_cost3).^(0.5));
%     P_d1_semistd(index)=mean(mean(P_cost4).^(0.5));
%     P_dP_semistd(index)=mean(mean(P_cost7).^(0.5));
%     %bimodal
%     S_dw_semistd(index)=mean(mean(S_cost1).^(0.5));
%     S_d0_semistd(index)=mean(mean(S_cost2).^(0.5));
%     S_d05_semistd(index)=mean(mean(S_cost3).^(0.5));
%     S_d1_semistd(index)=mean(mean(S_cost4).^(0.5));
%     S_dS_semistd(index)=mean(mean(S_cost8).^(0.5));
%     index=index+1;
% end
% 
% figure;
% ind=1:9;
% plot(ind,N_dw_semistd);
% hold on;
% plot(ind,N_d0_semistd);
% hold on;
% plot(ind,N_d05_semistd);
% hold on;
% plot(ind,N_d1_semistd);
% set(gca,'XTick',ind);
% set(gca,'XTickLabel',{'0.2','0.25','0.33','0.5','1','2','3','4','5'});
% xlabel('gamma');
% ylabel('Semistd');
% title('normal');
% legend('d_{w^*}','d_0','d_{0.5}','d_1');
% 
% figure;
% ind=1:9;
% plot(ind,G_dw_semistd);
% hold on;
% plot(ind,G_d0_semistd);
% hold on;
% plot(ind,G_d05_semistd);
% hold on;
% plot(ind,G_d1_semistd);
% set(gca,'XTick',ind);
% set(gca,'XTickLabel',{'0.2','0.25','0.33','0.5','1','2','3','4','5'});
% xlabel('gamma');
% ylabel('Semistd');
% title('gamma');
% legend('d_{w^*}','d_0','d_{0.5}','d_1');
% 
% figure;
% ind=1:9;
% plot(ind,P_dw_semistd);
% hold on;
% plot(ind,P_d0_semistd);
% hold on;
% plot(ind,P_d05_semistd);
% hold on;
% plot(ind,P_d1_semistd);
% set(gca,'XTick',ind);
% set(gca,'XTickLabel',{'0.2','0.25','0.33','0.5','1','2','3','4','5'});
% xlabel('gamma');
% ylabel('Semistd');
% title('pareto');
% legend('d_{w^*}','d_0','d_{0.5}','d_1');
% 
% 
% figure;
% ind=1:9;
% plot(ind,S_dw_semistd);
% hold on;
% plot(ind,S_d0_semistd);
% hold on;
% plot(ind,S_d05_semistd);
% hold on;
% plot(ind,S_d1_semistd);
% set(gca,'XTick',ind);
% set(gca,'XTickLabel',{'0.2','0.25','0.33','0.5','1','2','3','4','5'});
% xlabel('gamma');
% ylabel('Semistd');
% title('bimodal');
% legend('d_{w^*}','d_0','d_{0.5}','d_1');




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%画MRV图%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% filename=strcat('MRV_matrix.mat');
% load(filename);
% 
% MRV_dw=mean(MRV_dw_matrix,2);
% MRV_d0=mean(MRV_d0_matrix,2);
% MRV_d05=mean(MRV_d05_matrix,2);
% MRV_d1=mean(MRV_d1_matrix,2);
% MRV_dN=mean(MRV_dN_matrix,2);
% MRV_dG=mean(MRV_dG_matrix,2);
% MRV_dP=mean(MRV_dP_matrix,2);
% MRV_dS=mean(MRV_dS_matrix,2);
% figure;
% ind=1:19;
% plot(ind,MRV_dw);
% hold on;
% plot(ind,MRV_d0);
% hold on;
% plot(ind,MRV_d05);
% hold on;
% plot(ind,MRV_d1);
% set(gca,'XTick',ind);
% set(gca,'XTickLabel',{'1/10','1/9','1/8','1/7','1/6','1/5','1/4','1/3','1/2','1','2','3','4','5','6','7','8','9','10'});
% xlabel('gamma');
% ylabel('MRV');
% title('MRV');
% legend('d_{w^*}','d_0','d_{0.5}','d_1');

% figure;
% ind=1:9;
% plot(ind,MRV_dN);
% hold on;
% plot(ind,MRV_dG);
% hold on;
% plot(ind,MRV_dP);
% hold on;
% plot(ind,MRV_dS);
% set(gca,'XTick',ind);
% set(gca,'XTickLabel',{'1/10','1/9','1/8','1/7','1/6','1/5','1/4','1/3','1/2','1','2','3','4','5','6','7','8','9','10'});
% xlabel('gamma');
% ylabel('MRV');
% title('MRV');
% legend('d_{normal}','d_{gamma}','d_{pareto}','d_{bimodal}');

% figure;
% ind=1:19;
% plot(ind,MRV_dw);
% hold on;
% plot(ind,MRV_d0);
% hold on;
% plot(ind,MRV_d05);
% hold on;
% plot(ind,MRV_d1);
% hold on;
% plot(ind,MRV_dN);
% hold on;
% plot(ind,MRV_dG);
% hold on;
% plot(ind,MRV_dP);
% hold on;
% plot(ind,MRV_dS);
% set(gca,'XTick',ind);
%  set(gca,'XTickLabel',{'1/10','1/9','1/8','1/7','1/6','1/5','1/4','1/3','1/2','1','2','3','4','5','6','7','8','9','10'});
% xlabel('gamma');
% ylabel('MRV');
% title('MRV');
% legend('d_{w^*}','d_0','d_{0.5}','d_1','d_{normal}','d_{gamma}','d_{pareto}','d_{bimodal}');


v=2;
u=6;
mu=4;
sigma=2;

i=0:0.1:1;
y1=zeros(1,11);
y2=zeros(1,11);
y3=zeros(1,11);
y4=zeros(1,11);
j=1;
for alpha=0:0.1:1
    y1(j)=u;
    y2(j)=mu+sqrt((1-alpha)/alpha)*sigma;
    y3(j)=(mu-(1-alpha)*v)/alpha;
    j=j+1;
end


l=1;
for k=0:0.1:1
    if k<=0.5
        y4(l)=y1(l)-0.01;
    end
%     if (0.2<5)&& (k<=0.8)
%         y4(l)=y2(l)-0.01;
%     end
    if (0.5<k)&& (k<=1)
        y4(l)=y3(l)-0.01;
    end
    
    l=l+1;
end
figure;
plot(i,y1);
hold on;
plot(i,y2);
hold on;
plot(i,y3);
hold on;
plot(i,y4);
legend('u','\mu+((1-\alpha)\sigma^2/\alpha)^{1/2}','(\mu-(1-\alpha)v)/\alpha','W-CVaR');



