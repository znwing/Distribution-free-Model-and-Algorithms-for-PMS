function [constraint,objective,x,z,y,modeltime1]=prepareForSOCP(m,n)
curtime=clock;
x=binvar(m,n,'full');
z=binvar(n,n,m,'full'); % z(i,j,k)¶ÔÓ¦x(k,i,j)
y=sdpvar(m,n,'full');

em=ones(1,m);
en=ones(1,n);
constraint=[em*x==en,y>=0];
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
modeltime1=etime(clock,curtime);