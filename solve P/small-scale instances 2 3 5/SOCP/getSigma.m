function [mu,sigma,halfsigma]=getSigma(m,n,lb,ub,l_para,u_para)

%mu=rand(m,n)*90+10;
mu=unifrnd(lb,ub,m,n);%����10-100��Χ�ڵľ��ȷֲ���Ϊm*nά
low_mu=l_para*mu;
up_mu=u_para*mu;
sigma=unifrnd(low_mu,up_mu).^2;
halfsigma=sqrt(sigma);%��׼�������������