function [time,time_Insert,time_Exchange,x,obj,ComparedMat,Exchange_num,Insert_num,tag]=Insert_Exchange_Improvement(x,m,n,sigma,ComparedMat,obj,pi)
curtime=clock;
obj0=obj;
tag=0;
flag1=1;
flag2=1;
Exchange_num=0;
Insert_num=0;


curtime1=clock;
while flag1==1
    [flag1,time1,x,obj,ComparedMat]=ImproveSolutionByInsert(x,m,n,sigma,ComparedMat,obj,pi);
    if flag1==1
        Insert_num=Insert_num+1;
    end
end
time_Insert=etime(clock,curtime1);

curtime2=clock;
while flag2==1
    [flag2,time2,x,obj,ComparedMat]=ImproveSolutionByExchange(x,m,n,sigma,ComparedMat,obj,pi);%用exchange方法改进初始解
    if flag2==1
        Exchange_num=Exchange_num+1;
    end
end
time_Exchange=etime(clock,curtime2);

if obj0-obj>0
    tag=1;
end
time=etime(clock,curtime);