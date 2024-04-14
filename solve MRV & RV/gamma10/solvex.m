function [xtheta,maxg1]=solvex(theta,a)
f = @(x)4*theta^2*(1-x)*(a+x)^3-(2*a-3*a*x+x-2*x^2)^2;    % 创建函数句柄.句柄中的变量不属符号变量，不需要定义！
syms x exp1;    % 定义符号变量 x, exp1；
exp1 = 4*theta^2*(1-x)*(a+x)^3-(2*a-3*a*x+x-2*x^2)^2;    % 符号表达式，包含符号变量. 符号变量必须先有上一行定义！
solx=solve(exp1 == 0, x);    % 命令行输入a，传入一个包含符号表达式的等式，x为所要求的变量
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