%�ǵ��޸ľ�������ɵ�ʵ������
function [optimal_x]=getoptimalx(c_1,c_2,p)
if c_1==0
    optimal_x=0;
else
    level=ceil(10^4*c_1/(c_1+c_2));%�ǵ��޸ľ�������ɵ�ʵ������
    X=sort(p,2);
    optimal_x=X(1,level);
end
end