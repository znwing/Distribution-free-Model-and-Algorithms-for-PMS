function [x,obj,ComparedMat,totaltime,Iteration_time,Iteration,flag_impro]=solveByRHAWithMultiM(x,m,n,sigma,pi,obj,ComparedMat)
curtime=clock;
obj0=obj;
flag=1;
flag_impro=0;
Iteration=1;
Iteration_time=zeros(1);
while flag==1
    obj1=obj;
    curtime_Iteration=clock;
    for i=1:m
        for j=1:m
            if i~=j
                T=x(j,:)+x(i,:);
                R=T;
                array=T;
                sigma_=sigma([j,i],:);
                pi_=pi([j,i],:);
                S=zeros(1,n);
                %1，第i个机器和第j个机器中的job重新分配
                [S,S_]=solveByRHA_2(i,j,S,T,R,array,sigma_,pi_,n);
                
                %2，判断是否更新新的分配S
                [x,obj,ComparedMat]=ifupdateX(i,j,x,S,S_,ComparedMat,sigma,pi,obj,array,n);
            end
        end
    end
    Iteration_time(Iteration)=etime(clock,curtime_Iteration);
    
    if obj1-obj<10^(-6)
        flag=0;
    elseif Iteration==10;
        flag=0;
    else
        Iteration=Iteration+1;
    end
end

if obj0-obj>10^(-7)
    flag_impro=1;
end
totaltime=etime(clock,curtime);
end


