function [ytheta,maxg2]=solvey(theta,a)
% f = @(x)4*theta^2*(a-x)*(1+x)^3-(2*a-3*x+a*x-2*x^2)^2;    
syms x exp1;   
exp1 = 4*theta^2*(a-x)*(1+x)^3-(2*a-3*x+a*x-2*x^2)^2;   
soly=solve(exp1 == 0, x); 
ytheta=zeros(1,4);
g2=zeros(1,4);
for i=1:4
    if (0<=double(soly(i))) && (double(soly(i))<=a)
        ytheta(i)=double(soly(i));
        g2(i)=ytheta(i)*(-theta+((a-ytheta(i))/(1+ytheta(i))) ^0.5 );
    end
end
maxg2=max(g2);
end