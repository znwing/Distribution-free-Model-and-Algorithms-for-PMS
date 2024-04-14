function [x,fval]=solveg(a)
f=@(x)-x(1)*x(2)/(x(1)+x(2))*(((a-x(2))/(1+x(2)))^0.5+((1-x(1))/(a+x(1)))^0.5);
A=[-1,0;1,0;0,-1;0,1];
b=[0;1;0;a];
x0=[0.5,0.0];
[x,fval]=fmincon(f,x0,A,b);
end