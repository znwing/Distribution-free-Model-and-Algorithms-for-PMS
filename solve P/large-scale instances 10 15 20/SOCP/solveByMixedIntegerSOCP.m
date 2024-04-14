%2021.8.7 chengzihan
function [time,xval,yval,zval,objval,obj_bound,modeltime,solvetime,gap]=solveByMixedIntegerSOCP(m,n,halfsigma,pi,timelimit,display,tolerance)

curtime=clock;
%定义变量
x=binvar(m,n,'full');
z=binvar(n,n,m,'full'); % z(i,j,k)对应x(k,i,j)
y=sdpvar(m,n,'full');

em=ones(1,m);
en=ones(1,n);
constraint=[em*x==en,y>=0];

for k=1:m
    for i=1:n
        constraint=[constraint,cone(diag(halfsigma(k,pi(k,1:i)))*z(pi(k,i),pi(k,1:i),k)',y(k,pi(k,i)))];
    end
end

for k=1:m
    for i=1:n
        for j=1:n
            if i~=j
                constraint=[constraint,z(i,j,k)>=x(k,i)+x(k,j)-1];
            end
        end
        constraint=[constraint,z(i,i,k)==x(k,i)];
    end
end


objective=em*y*en';

optionsgurobi = sdpsettings('verbose',display,'usex0',1,'solver','gurobi','showprogress',display,'gurobi.TimeLimit',timelimit...
    ,'gurobi.MIPGap',tolerance,'savesolveroutput',1);


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
