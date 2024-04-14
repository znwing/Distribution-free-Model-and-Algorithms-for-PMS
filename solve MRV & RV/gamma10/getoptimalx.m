%记得修改具体的生成的实例数量
function [optimal_x]=getoptimalx(c_1,c_2,p)
if c_1==0
    optimal_x=0;
else
    level=ceil(10^4*c_1/(c_1+c_2));%记得修改具体的生成的实例数量
    X=sort(p,2);
    optimal_x=X(1,level);
end
end