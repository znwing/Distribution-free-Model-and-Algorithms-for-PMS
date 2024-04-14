function [xtheta,maxg1]=solvex(theta,a)
f = @(x)4*theta^2*(1-x)*(a+x)^3-(2*a-3*a*x+x-2*x^2)^2;    % �����������.����еı����������ű���������Ҫ���壡
syms x exp1;    % ������ű��� x, exp1��
exp1 = 4*theta^2*(1-x)*(a+x)^3-(2*a-3*a*x+x-2*x^2)^2;    % ���ű��ʽ���������ű���. ���ű�������������һ�ж��壡
solx=solve(exp1 == 0, x);    % ����������a������һ���������ű��ʽ�ĵ�ʽ��xΪ��Ҫ��ı���
xtheta=zeros(1,4);
g1=zeros(1,4);
for i=1:4
    if (0<=double(solx(i))) && (double(solx(i))<1)
        xtheta(i)=double(solx(i));
        g1(i)=xtheta(i)*(theta+((1-xtheta(i))/(a+xtheta(i)))^0.5);
    end
end
maxg1=max(g1);
end