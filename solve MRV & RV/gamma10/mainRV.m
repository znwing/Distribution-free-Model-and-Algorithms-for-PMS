filename=strcat('mu10_100sigma0.1_0.25_m1n100.mat');
load(filename);

filename=strcat('normal_t.mat');
load(filename);
filename=strcat('gamma_t.mat');
load(filename);
filename=strcat('pareto_t.mat');
load(filename);
filename=strcat('shuangfeng_t.mat');
load(filename);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
c_2=10;
w1=0;
w2=0.5;
w3=1;
xw=zeros(1,100);
xw1=zeros(1,100);
xw2=zeros(1,100);
xw3=zeros(1,100);
x_normal=zeros(1,100);
x_gamma=zeros(1,100);
x_pareto=zeros(1,100);
x_shuangfeng=zeros(1,100);


%正态
N_gamma_meancost1=zeros(19,100);%w^*
N_gamma_meancost2=zeros(19,100);%w=0
N_gamma_meancost3=zeros(19,100);%w=0.5
N_gamma_meancost4=zeros(19,100);%w=1
N_gamma_meancost5=zeros(19,100);%normal
N_gamma_meancost6=zeros(19,100);%gamma
N_gamma_meancost7=zeros(19,100);%pareto
N_gamma_meancost8=zeros(19,100);%shuangfeng

%Gamma
G_gamma_meancost1=zeros(19,100);
G_gamma_meancost2=zeros(19,100);
G_gamma_meancost3=zeros(19,100);
G_gamma_meancost4=zeros(19,100);
G_gamma_meancost5=zeros(19,100);
G_gamma_meancost6=zeros(19,100);
G_gamma_meancost7=zeros(19,100);
G_gamma_meancost8=zeros(19,100);


%pareto
P_gamma_meancost1=zeros(19,100);
P_gamma_meancost2=zeros(19,100);
P_gamma_meancost3=zeros(19,100);
P_gamma_meancost4=zeros(19,100);
P_gamma_meancost5=zeros(19,100);
P_gamma_meancost6=zeros(19,100);
P_gamma_meancost7=zeros(19,100);
P_gamma_meancost8=zeros(19,100);

%双峰分布
S_gamma_meancost1=zeros(19,100);%w^*
S_gamma_meancost2=zeros(19,100);%w=0
S_gamma_meancost3=zeros(19,100);%w=0.5
S_gamma_meancost4=zeros(19,100);%w=1
S_gamma_meancost5=zeros(19,100);%正态分布
S_gamma_meancost6=zeros(19,100);%gamma
S_gamma_meancost7=zeros(19,100);%pareto
S_gamma_meancost8=zeros(19,100);%双峰


index=1;
for gamma=[1/10,1/9,1/8,1/7,1/6,1/5,1/4,1/3,1/2,1,2,3,4,5,6,7,8,9,10];
    disp(['gamma=',num2str(gamma)]);
    %正态
    N_cost1=zeros(10^4,100);%w^*
    N_cost2=zeros(10^4,100);%w=0;
    N_cost3=zeros(10^4,100);%w=0.5;
    N_cost4=zeros(10^4,100);%w=1;
    N_cost5=zeros(10^4,100);%正态
    N_cost6=zeros(10^4,100);%gamma
    N_cost7=zeros(10^4,100);%pareto
    N_cost8=zeros(10^4,100);%shuangfeng

    %Gamma
    G_cost1=zeros(10^4,100);
    G_cost2=zeros(10^4,100);
    G_cost3=zeros(10^4,100);
    G_cost4=zeros(10^4,100);
    G_cost5=zeros(10^4,100);
    G_cost6=zeros(10^4,100);
    G_cost7=zeros(10^4,100);
    G_cost8=zeros(10^4,100);

   
    %pareto
    P_cost1=zeros(10^4,100);
    P_cost2=zeros(10^4,100);
    P_cost3=zeros(10^4,100);
    P_cost4=zeros(10^4,100);
    P_cost5=zeros(10^4,100);
    P_cost6=zeros(10^4,100);
    P_cost7=zeros(10^4,100);
    P_cost8=zeros(10^4,100);

    %shuangfeng
    S_cost1=zeros(10^4,100);
    S_cost2=zeros(10^4,100);
    S_cost3=zeros(10^4,100);
    S_cost4=zeros(10^4,100);
    S_cost5=zeros(10^4,100);
    S_cost6=zeros(10^4,100);
    S_cost7=zeros(10^4,100);
    S_cost8=zeros(10^4,100);
    
    for i=1:100 %本来是想生成100搁均值和方差组合，这里直接看成100个工件即可
        [x,fval]=solveg(gamma);%解出来的x(1)和x(2)分别对应g(x,y)的x和y
        [w,xw(i),c_1,min_MRV]=getxw(mu(i),halfsigma(i),c_2,gamma,x,fval);
        [xw1(i)]=getxwo(c_1,c_2,w1,mu(i),halfsigma(i));
        [xw2(i)]=getxwo(c_1,c_2,w2,mu(i),halfsigma(i));
        [xw3(i)]=getxwo(c_1,c_2,w3,mu(i),halfsigma(i));
        level=ceil(10^4 * c_1/(c_1+c_2));
        sort_normal_t=sort(normal_t(:,i));
        sort_gamma_t=sort(gamma_t(:,i));
        sort_pareto_t=sort(pareto_t(:,i));
        sort_shuangfeng_t=sort(shuangfeng_t(:,i));
        x_normal(i)= sort_normal_t(level);
        x_gamma(i)= sort_gamma_t(level);
        x_pareto(i)=sort_pareto_t(level);
        x_shuangfeng(i)=sort_shuangfeng_t(level);
        
        disp(['第',num2str(i),'个工件的d_w^*=',num2str(xw(i))]);
        disp(['第',num2str(i),'个工件的d_0=',num2str(xw1(i))]);
        disp(['第',num2str(i),'个工件的d_05=',num2str(xw2(i))]);
        disp(['第',num2str(i),'个工件的d_1=',num2str(xw3(i))]);
        disp(['第',num2str(i),'个工件的d_normal=',num2str(x_normal(i))]);
        disp(['第',num2str(i),'个工件的d_gamma=',num2str(x_gamma(i))]);
        disp(['第',num2str(i),'个工件的d_pareto=',num2str(x_pareto(i))]);
        disp(['第',num2str(i),'个工件的d_shuangfeng=',num2str(x_shuangfeng(i))]);
        
        for j=1:10^4
            %10^4个算例成本计算
            disp(['第',num2str(i),'个工件，第',num2str(j),'个算例']);
            disp('正态分布下：');
            [N_Expect_cost1]=getf(xw(i),normal_t(j,i),c_1,c_2);
            [N_Expect_cost2]=getf(xw1(i),normal_t(j,i),c_1,c_2);
            [N_Expect_cost3]=getf(xw2(i),normal_t(j,i),c_1,c_2);
            [N_Expect_cost4]=getf(xw3(i),normal_t(j,i),c_1,c_2);
            [N_Expect_cost5]=getf(x_normal(i),normal_t(j,i),c_1,c_2);
            [N_Expect_cost6]=getf(x_gamma(i),normal_t(j,i),c_1,c_2);
            [N_Expect_cost7]=getf(x_pareto(i),normal_t(j,i),c_1,c_2);
            [N_Expect_cost8]=getf(x_shuangfeng(i),normal_t(j,i),c_1,c_2);
            N_cost1(j,i)=N_Expect_cost1;
            N_cost2(j,i)=N_Expect_cost2;
            N_cost3(j,i)=N_Expect_cost3;
            N_cost4(j,i)=N_Expect_cost4;
            N_cost5(j,i)=N_Expect_cost5;
            N_cost6(j,i)=N_Expect_cost6;
            N_cost7(j,i)=N_Expect_cost7;
            N_cost8(j,i)=N_Expect_cost8;
            
            
            disp('Gamma分布下：')
            [G_Expect_cost1]=getf(xw(i),gamma_t(j,i),c_1,c_2);
            [G_Expect_cost2]=getf(xw1(i),gamma_t(j,i),c_1,c_2);
            [G_Expect_cost3]=getf(xw2(i),gamma_t(j,i),c_1,c_2);
            [G_Expect_cost4]=getf(xw3(i),gamma_t(j,i),c_1,c_2);
            [G_Expect_cost5]=getf(x_normal(i),gamma_t(j,i),c_1,c_2);
            [G_Expect_cost6]=getf(x_gamma(i),gamma_t(j,i),c_1,c_2);
            [G_Expect_cost7]=getf(x_pareto(i),gamma_t(j,i),c_1,c_2);
            [G_Expect_cost8]=getf(x_shuangfeng(i),gamma_t(j,i),c_1,c_2);
            G_cost1(j,i)=G_Expect_cost1;
            G_cost2(j,i)=G_Expect_cost2;
            G_cost3(j,i)=G_Expect_cost3;
            G_cost4(j,i)=G_Expect_cost4;
            G_cost5(j,i)=G_Expect_cost5;
            G_cost6(j,i)=G_Expect_cost6;
            G_cost7(j,i)=G_Expect_cost7;
            G_cost8(j,i)=G_Expect_cost8;
            
            
            disp('Pareto分布下：')
            [P_Expect_cost1]=getf(xw(i),pareto_t(j,i),c_1,c_2);
            [P_Expect_cost2]=getf(xw1(i),pareto_t(j,i),c_1,c_2);
            [P_Expect_cost3]=getf(xw2(i),pareto_t(j,i),c_1,c_2);
            [P_Expect_cost4]=getf(xw3(i),pareto_t(j,i),c_1,c_2);
            [P_Expect_cost5]=getf(x_normal(i),pareto_t(j,i),c_1,c_2);
            [P_Expect_cost6]=getf(x_gamma(i),pareto_t(j,i),c_1,c_2);
            [P_Expect_cost7]=getf(x_pareto(i),pareto_t(j,i),c_1,c_2);
            [P_Expect_cost8]=getf(x_shuangfeng(i),pareto_t(j,i),c_1,c_2);
            P_cost1(j,i)=P_Expect_cost1;
            P_cost2(j,i)=P_Expect_cost2;
            P_cost3(j,i)=P_Expect_cost3;
            P_cost4(j,i)=P_Expect_cost4;
            P_cost5(j,i)=P_Expect_cost5;
            P_cost6(j,i)=P_Expect_cost6;
            P_cost7(j,i)=P_Expect_cost7;
            P_cost8(j,i)=P_Expect_cost8;
            
            [S_Expect_cost1]=getf(xw(i),shuangfeng_t(j,i),c_1,c_2);
            [S_Expect_cost2]=getf(xw1(i),shuangfeng_t(j,i),c_1,c_2);
            [S_Expect_cost3]=getf(xw2(i),shuangfeng_t(j,i),c_1,c_2);
            [S_Expect_cost4]=getf(xw3(i),shuangfeng_t(j,i),c_1,c_2);
            [S_Expect_cost5]=getf(x_normal(i),shuangfeng_t(j,i),c_1,c_2);
            [S_Expect_cost6]=getf(x_gamma(i),shuangfeng_t(j,i),c_1,c_2);
            [S_Expect_cost7]=getf(x_pareto(i),shuangfeng_t(j,i),c_1,c_2);
            [S_Expect_cost8]=getf(x_shuangfeng(i),shuangfeng_t(j,i),c_1,c_2);
            S_cost1(j,i)=S_Expect_cost1;
            S_cost2(j,i)=S_Expect_cost2;
            S_cost3(j,i)=S_Expect_cost3;
            S_cost4(j,i)=S_Expect_cost4;
            S_cost5(j,i)=S_Expect_cost5;
            S_cost6(j,i)=S_Expect_cost6;
            S_cost7(j,i)=S_Expect_cost7;
            S_cost8(j,i)=S_Expect_cost8;
        end
    end
    N_gamma_meancost1(index,:)=mean(N_cost1,1);
    N_gamma_meancost2(index,:)=mean(N_cost2,1);
    N_gamma_meancost3(index,:)=mean(N_cost3,1);
    N_gamma_meancost4(index,:)=mean(N_cost4,1);
    N_gamma_meancost5(index,:)=mean(N_cost5,1);
    N_gamma_meancost6(index,:)=mean(N_cost6,1);
    N_gamma_meancost7(index,:)=mean(N_cost7,1);
    N_gamma_meancost8(index,:)=mean(N_cost8,1);
    
    G_gamma_meancost1(index,:)=mean(G_cost1,1);
    G_gamma_meancost2(index,:)=mean(G_cost2,1);
    G_gamma_meancost3(index,:)=mean(G_cost3,1);
    G_gamma_meancost4(index,:)=mean(G_cost4,1);
    G_gamma_meancost5(index,:)=mean(G_cost5,1);
    G_gamma_meancost6(index,:)=mean(G_cost6,1);
    G_gamma_meancost7(index,:)=mean(G_cost7,1);
    G_gamma_meancost8(index,:)=mean(G_cost8,1);
    
    
    P_gamma_meancost1(index,:)=mean(P_cost1,1);
    P_gamma_meancost2(index,:)=mean(P_cost2,1);
    P_gamma_meancost3(index,:)=mean(P_cost3,1);
    P_gamma_meancost4(index,:)=mean(P_cost4,1);
    P_gamma_meancost5(index,:)=mean(P_cost5,1);
    P_gamma_meancost6(index,:)=mean(P_cost6,1);
    P_gamma_meancost7(index,:)=mean(P_cost7,1);
    P_gamma_meancost8(index,:)=mean(P_cost8,1);

    
    
    S_gamma_meancost1(index,:)=mean(S_cost1,1);
    S_gamma_meancost2(index,:)=mean(S_cost2,1);
    S_gamma_meancost3(index,:)=mean(S_cost3,1);
    S_gamma_meancost4(index,:)=mean(S_cost4,1);
    S_gamma_meancost5(index,:)=mean(S_cost5,1);
    S_gamma_meancost6(index,:)=mean(S_cost6,1);
    S_gamma_meancost7(index,:)=mean(S_cost7,1);
    S_gamma_meancost8(index,:)=mean(S_cost8,1);
 
    
    filename=strcat(['gamma=',num2str(gamma),'_N_cost.mat']);
    save(filename,'N_cost1','N_cost2','N_cost3','N_cost4','N_cost5','N_cost6','N_cost7','N_cost8');
    filename=strcat(['gamma=',num2str(gamma),'_G_cost.mat']);
    save(filename,'G_cost1','G_cost2','G_cost3','G_cost4','G_cost5','G_cost6','G_cost7','G_cost8');
    filename=strcat(['gamma=',num2str(gamma),'_P_cost.mat']);
    save(filename,'P_cost1','P_cost2','P_cost3','P_cost4','P_cost5','P_cost6','P_cost7','P_cost8');
    filename=strcat(['gamma=',num2str(gamma),'_S_cost.mat']);
    save(filename,'S_cost1','S_cost2','S_cost3','S_cost4','S_cost5','S_cost6','S_cost7','S_cost8');
    index=index+1;
end

N_RV_dw=N_gamma_meancost1-N_gamma_meancost5;
N_RV_d0=N_gamma_meancost2-N_gamma_meancost5;
N_RV_d05=N_gamma_meancost3-N_gamma_meancost5;
N_RV_d1=N_gamma_meancost4-N_gamma_meancost5;

G_RV_dw=G_gamma_meancost1-G_gamma_meancost6;
G_RV_d0=G_gamma_meancost2-G_gamma_meancost6;
G_RV_d05=G_gamma_meancost3-G_gamma_meancost6;
G_RV_d1=G_gamma_meancost4-G_gamma_meancost6;


P_RV_dw=P_gamma_meancost1-P_gamma_meancost7;
P_RV_d0=P_gamma_meancost2-P_gamma_meancost7;
P_RV_d05=P_gamma_meancost3-P_gamma_meancost7;
P_RV_d1=P_gamma_meancost4-P_gamma_meancost7;

S_RV_dw=S_gamma_meancost1-S_gamma_meancost8;
S_RV_d0=S_gamma_meancost2-S_gamma_meancost8;
S_RV_d05=S_gamma_meancost3-S_gamma_meancost8;
S_RV_d1=S_gamma_meancost4-S_gamma_meancost8;

%存数据
filename=strcat('N_meancost.mat');
save(filename,'N_gamma_meancost1','N_gamma_meancost2','N_gamma_meancost3','N_gamma_meancost4','N_gamma_meancost5','N_gamma_meancost6','N_gamma_meancost7','N_gamma_meancost8');
filename=strcat('G_meancost.mat');
save(filename,'G_gamma_meancost1','G_gamma_meancost2','G_gamma_meancost3','G_gamma_meancost4','G_gamma_meancost5','G_gamma_meancost6','G_gamma_meancost7','G_gamma_meancost8');
filename=strcat('P_meancost.mat');
save(filename,'P_gamma_meancost1','P_gamma_meancost2','P_gamma_meancost3','P_gamma_meancost4','P_gamma_meancost5','P_gamma_meancost6','P_gamma_meancost7','P_gamma_meancost8');
filename=strcat('S_meancost.mat');
save(filename,'S_gamma_meancost1','S_gamma_meancost2','S_gamma_meancost3','S_gamma_meancost4','S_gamma_meancost5','S_gamma_meancost6','S_gamma_meancost7','S_gamma_meancost8');



filename=strcat('N_RV.mat');
save(filename,'N_RV_d0','N_RV_d05','N_RV_d1','N_RV_dw');
filename=strcat('S_RV.mat');
save(filename,'S_RV_d0','S_RV_d05','S_RV_d1','S_RV_dw');
filename=strcat('G_RV.mat');
save(filename,'G_RV_d0','G_RV_d05','G_RV_d1','G_RV_dw');
filename=strcat('P_RV.mat');
save(filename,'P_RV_d0','P_RV_d05','P_RV_d1','P_RV_dw');
