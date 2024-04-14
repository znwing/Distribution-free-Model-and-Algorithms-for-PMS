function [MRV]=getMRV(c_2,x,x_w,mu,sigma,gamma)
theta=(x-mu)/sigma;
if x>x_w
    [xtheta,maxg1]=solvex(theta,gamma);        %solvex是为了得到x>x_w^*的时候，计算MRV
    MRV=c_2*sigma*maxg1;
%     disp(['w=0时，x_w=',num2str(x),'，MRV=',num2str(MRV)]);
elseif x<=x_w
    [ytheta,maxg2]=solvey(theta,gamma);        %solvey是为了得到x<x_w^*的时候，计算MRV
    MRV=c_2*sigma*maxg2;
end