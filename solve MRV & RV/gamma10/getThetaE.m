function [c_1,theta_e]=getThetaE(c_2,a,x)
c_1=c_2*a;
theta_e=(x(2)*((a-x(2))/(1+x(2)))^0.5-x(1)*((1-x(1))/(a+x(1)))^0.5)/(x(1)+x(2));
end
