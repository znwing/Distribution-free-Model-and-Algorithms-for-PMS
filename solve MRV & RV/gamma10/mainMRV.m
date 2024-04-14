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
MRV_dw_matrix=zeros(19,100);
MRV_d0_matrix=zeros(19,100);
MRV_d05_matrix=zeros(19,100);
MRV_d1_matrix=zeros(19,100);
MRV_dN_matrix=zeros(19,100);
MRV_dG_matrix=zeros(19,100);
MRV_dP_matrix=zeros(19,100);
MRV_dS_matrix=zeros(19,100);
for i=1:100 %本来是想生成100个均值和方差组合，这里直接看成100个工件即可
    disp(['第',num2str(i),'个算例']);
    index=1;
    for gamma=[1/10,1/9,1/8,1/7,1/6,1/5,1/4,1/3,1/2,1,2,3,4,5,6,7,8,9,10]
        disp(['gamma=',num2str(gamma)]);
        [x,fval]=solveg(gamma);
        [w,xw(i),c_1,min_MRV]=getxw(mu(i),halfsigma(i),c_2,gamma,x,fval); % 求解d_{w^*}
        MRV_dw_matrix(index,i)=min_MRV; %求w=w^*时的MRV
        
        [xw1(i)]=getxwo(c_1,c_2,w1,mu(i),halfsigma(i));  %给w的值，求d_w
        [MRV1]=getMRV(c_2,xw1(i),xw(i),mu(i),halfsigma(i),gamma); %求w=w1时的MRV
        MRV_d0_matrix(index,i)=MRV1; 
        
        [xw2(i)]=getxwo(c_1,c_2,w2,mu(i),halfsigma(i));
        [MRV2]=getMRV(c_2,xw2(i),xw(i),mu(i),halfsigma(i),gamma);
        MRV_d05_matrix(index,i)=MRV2;
        
        
        [xw3(i)]=getxwo(c_1,c_2,w3,mu(i),halfsigma(i));
        [MRV3]=getMRV(c_2,xw3(i),xw(i),mu(i),halfsigma(i),gamma);
        MRV_d1_matrix(index,i)=MRV3;
        
        level=ceil(10^4 * c_1/(c_1+c_2));
        sort_normal_t=sort(normal_t(:,i));
        sort_gamma_t=sort(gamma_t(:,i));
        sort_pareto_t=sort(pareto_t(:,i));
        sort_shuangfeng_t=sort(shuangfeng_t(:,i));
        x_normal(i)= sort_normal_t(level);
        x_gamma(i)= sort_gamma_t(level);
        x_pareto(i)=sort_pareto_t(level);
        x_shuangfeng(i)=sort_shuangfeng_t(level);
        
        [MRV4]=getMRV(c_2,x_normal(i),xw(i),mu(i),halfsigma(i),gamma);
        MRV_dN_matrix(index,i)=MRV4;
        [MRV5]=getMRV(c_2,x_gamma(i),xw(i),mu(i),halfsigma(i),gamma);
        MRV_dG_matrix(index,i)=MRV5;
        [MRV6]=getMRV(c_2,x_pareto(i),xw(i),mu(i),halfsigma(i),gamma);
        MRV_dP_matrix(index,i)=MRV6;
        [MRV7]=getMRV(c_2,x_shuangfeng(i),xw(i),mu(i),halfsigma(i),gamma);
        MRV_dS_matrix(index,i)=MRV7;
        
        disp(['gamma=',num2str(gamma),'时']);
        disp(['w=',num2str(w),'时,MRV为',num2str(MRV_dw_matrix(index,i))]);
        disp(['w=0时,MRV为',num2str(MRV_d0_matrix(index,i))]);
        disp(['w=0.5时,MRV为',num2str(MRV_d05_matrix(index,i))]);
        disp(['w=1时,MRV为',num2str(MRV_d1_matrix(index,i))]);
        disp(['正态分布下，x=x^*时,MRV为',num2str(MRV_dN_matrix(index,i))]);
        disp(['gamma分布下，x=x^*时,MRV为',num2str(MRV_dG_matrix(index,i))]);
        disp(['pareto分布下，x=x^*时,MRV为',num2str(MRV_dP_matrix(index,i))]);
        disp(['双峰分布下，x=x^*时,MRV为',num2str(MRV_dS_matrix(index,i))]);
        index=index+1;
    end
end
filename=strcat('MRV_matrix.mat');
save(filename,'MRV_dw_matrix','MRV_d0_matrix','MRV_d05_matrix','MRV_d1_matrix','MRV_dN_matrix','MRV_dG_matrix','MRV_dP_matrix','MRV_dS_matrix');

