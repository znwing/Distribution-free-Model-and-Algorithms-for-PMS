%该函数的功能是把k行的i列插入到s行的p列
function [delta,ComparedMat_changed,x_changed]=InsertOperation(n,i,p,k,s,sigma,ComparedMat,pi,x)
delta=0;
k_sigma_Vector=zeros(1,n-i+1);  % 储存pi排序情况下， k_sigma_Vector(1,i)存第k行前i列方差和，以此类推
s_sigma_Vector=zeros(1,n-p+1);  % 储存pi排序情况下， s_sigma_Vector(1,p)存第s行前p列方差和，以此类推
for j=i+1:n
    k_sigma_Vector(j-i+1)=ComparedMat(k,j)-sigma(k,pi(k,i))*x(k,pi(k,j));
    delta=delta+sqrt(k_sigma_Vector(j-i+1));
end
for j=p+1:n
    s_sigma_Vector(j-p+1)=ComparedMat(s,j)+sigma(s,pi(s,p))*x(s,pi(s,j));
    delta=delta+sqrt(s_sigma_Vector(j-p+1));
end

t=p-1;
while t>0&&ComparedMat(s,t)==0
    t=t-1;
end
if t<=0
    s_sigma_Vector(1)=sigma(s,pi(s,p));
else
    s_sigma_Vector(1)=ComparedMat(s,t)+sigma(s,pi(s,p));
end

delta=delta+sqrt(s_sigma_Vector(1))-sum(sqrt(ComparedMat(k,i:n)))-sum(sqrt(ComparedMat(s,p:n)));
ComparedMat_changed=ComparedMat;
ComparedMat_changed(k,i:n)=k_sigma_Vector; %更新ComparedMat，pi排序情况下，ComparedMat(k,i)存第k行前i列方差和，
ComparedMat_changed(s,p:n)=s_sigma_Vector;
x_changed=x;
x_changed(k,pi(k,i))=0; %更新x
x_changed(s,pi(s,p))=1;