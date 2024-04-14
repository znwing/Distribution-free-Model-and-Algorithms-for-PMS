function [flag,time,x,obj,ComparedMat,Exchangedelta_num]=ImproveSolutionByExchange(x,m,n,sigma,ComparedMat,obj,pi)
origin_obj=obj;
curtime=clock;
flag=0;
%if_changed=zeros(1,m);%用于表示x某行是否变化，如果变化为1，不变为0；
Exchangedelta_num=0;
for k=1:m
    for s=1:k-1
        for i=1:n
            if x(k,pi(k,i))~=0
                for j=1:n
                    if x(s,pi(s,j))~=0
                        p1=find(pi(s,:)==pi(k,i));
                        p2=find(pi(k,:)==pi(s,j));
                        %把k行的i插入到s行的p1
                        [delta1,ComparedMat_changed,x_changed]=InsertOperation(n,i,p1,k,s,sigma,ComparedMat,pi,x);
                        %把s行的j插入到k行的p2
                        [delta2,ComparedMat_changed,x_changed]=InsertOperation(n,j,p2,s,k,sigma,ComparedMat_changed,pi,x_changed);
                        delta=delta1+delta2;
                        if delta<0
                            x=x_changed;
                            ComparedMat=ComparedMat_changed;
                            obj=obj+delta;
                            Exchangedelta_num=Exchangedelta_num+1;
                            break;
                        end
                    end
                end
            end
        end
    end
end
if origin_obj-obj>exp(-10)
    flag=1;
end
time=etime(clock,curtime);
%disp(['model time=',num2str(modeltime)]);
