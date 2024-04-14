function [time,xval,yval,zval,objval,obj_bound,modeltime,solvetime,gap]=solveByMixedIntegerSOCPnew(m,n,halfsigma,pi,optionsgurobi,constraint,x,y,z,objective,x_GA)
curtime=clock;
for k=1:m
    for i=1:n
        constraint=[constraint,cone(diag(halfsigma(k,pi(k,1:i)))*z(pi(k,i),pi(k,1:i),k)',y(k,pi(k,i)))];
    end
end

%assign(x,initialx) %1.如何设置初始解，起作用
%****** 2. 读取计算结果的bestbd, Incumbent
assign(x,x_GA);
modeltime=etime(clock,curtime);
%disp(['model time=',num2str(modeltime)]);
%saveampl(constraint,objective,'socpmodel.mod') %保存模型

curtime=clock;
sol = solvesdp(constraint,objective,optionsgurobi);
if sol.problem~=0
    disp(['SOCP求解出现问题'])
    sol
end

solvetime=etime(clock,curtime);
%disp(['solve time=',num2str(time)]);
% sol
time=modeltime+solvetime;
obj_bound=double(sol.solveroutput.result.objbound);
gap=double(sol.solveroutput.result.mipgap);
xval=double(x);
yval=double(y);
zval=double(z);
objval=double(objective);
