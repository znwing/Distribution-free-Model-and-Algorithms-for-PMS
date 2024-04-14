function [Expect_cost]=getf(x,p,c_1,c_2)
if x>=p
    Expect_cost=c_2*(x-p);
elseif x<=p
    Expect_cost=c_1*(p-x);
end
















end