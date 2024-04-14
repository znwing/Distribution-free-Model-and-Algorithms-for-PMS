function [w,xw,c_1,min_MRV]=getxw(mu,halfsigma,c_2,a,x,fval)
c_1=c_2*a;
gxy=-fval;
theta_e=(x(2)*((a-x(2))/(1+x(2)))^0.5-x(1)*((1-x(1))/(a+x(1)))^0.5)/(x(1)+x(2));
if a>=1
    w=2*(1+(theta_e)^2+((theta_e)^2*(1+(theta_e)^2))^0.5) /(1+a);
elseif a<=1
    w=2*a*(1+(theta_e)^2+((theta_e)^2*(1+(theta_e)^2))^0.5) /(1+a);
end
xw=mu+halfsigma*theta_e;
min_MRV=halfsigma*c_2*gxy;
end