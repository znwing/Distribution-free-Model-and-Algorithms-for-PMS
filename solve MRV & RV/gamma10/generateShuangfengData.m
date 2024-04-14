%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%��һ����ʱΪ���ҳ��������ֲ����Ա�����˫��ֲ�%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear all


filename=strcat('mu28.5499sigma20.5385.mat');
load(filename);

c_2=10;

%��һ����ʱΪ���ҳ��������ֲ����Ա�����˫��ֲ�
q1_delta=zeros(1,8);
q2_delta=zeros(1,8);
p=zeros(1,8);
q=zeros(1,8);
index=1;
for gamma=[0.2,0.5,0.8,1,2,5,8,10]
    [x,fval]=solveg(gamma);
    [w,xw,c_1,min_MRV]=getxw(mu,halfsigma,c_2,gamma,x,fval);
    [delta,V]=getdelta(mu,halfsigma,x,xw,c_2,c_1); %V��Ϊ����ֲ���Ӧ��MRV
    q1_delta(index)=mu-halfsigma*((c_2-delta)/(c_1+delta))^0.5;
    q2_delta(index)=mu+halfsigma*((c_1+delta)/(c_2-delta))^0.5;
    p(index)=(c_1+delta)/(c_1+c_2);
    q(index)=1-p(index);
    [MRV]=getMRV(c_2,xw,xw,mu,halfsigma,gamma);
    index=index+1;
end


%��1�����
% mu1=25.8;%p=0.75
% halfsigma1=1;
% mu2=36.5;%q=0.25
% halfsigma2=1;


% %��2�����
% mu1=26.5;%p=0.8
% halfsigma1=1;
% mu2=38;%q=0.2
% halfsigma2=1;

% %��3�����
% mu1=27;%p=0.9
% halfsigma1=1;
% mu2=45;%q=0.1
% halfsigma2=1;

% %��4�����
% mu1=20;%p=0.35
% halfsigma1=1;
% mu2=32;%q=0.65
% halfsigma2=1;

% %��5�����
% mu1=22.78;%p=0.38
% halfsigma1=1;
% mu2=32.11;%q=0.62
% halfsigma2=1;

% %��6�����
% mu1=22.78;%p=0.38
% halfsigma1=0.5;
% mu2=32.11;%q=0.62
% halfsigma2=0.5;


% %��7�����
% mu1=22.78;%p=0.38
% halfsigma1=2;
% mu2=32.11;%q=0.62
% halfsigma2=2;

%��8�����
mu1=28.31;%p=0.997
halfsigma1=2;
mu2=112.68;%q=0.003
halfsigma2=2;

% %ֱ������matlab����������˫��ֲ�
% f = @(x) normpdf(x,mu1,halfsigma1)+normpdf(x,mu2,halfsigma);
% D = slicesample(1,10^4,'pdf',f);

%���ݸ��ʵķ�ʽ����һ��˫��ֲ�
shuangfeng_t=zeros(1,10^4);
for i=1:10^4
    k=rand(1);
    if k<=0.997
        shuangfeng_t(i)=normrnd(mu1,halfsigma1,1,1);
    else
        shuangfeng_t(i)=normrnd(mu2,halfsigma2,1,1);
    end
end

meanx=mean(shuangfeng_t);
halfsigmax=std(shuangfeng_t);
Y=(shuangfeng_t-meanx)/halfsigmax;
shuangfeng_t=mu+Y*halfsigma;
filename=strcat('shuangfeng_t.mat');
save(filename,'shuangfeng_t');