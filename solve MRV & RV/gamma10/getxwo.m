function [xw]=getxwo(c_1,c_2,w,mu,sigma)
if c_1==0
    xw=0;
else
    thetaw1=(2*c_1-w*c_1-w*c_2)/((4*c_1*(w*c_1+w*c_2-c_1))^0.5);
    thetaw2=(w*c_1+w*c_2-2*c_2)/((4*c_2*(w*c_1+w*c_2-c_2))^0.5);
    if w<= 2*min(c_1,c_2)/(c_1+c_2)
        xw=mu;
    elseif c_1<c_2 && w>= 2*c_1/(c_1+c_2)
        xw=mu+sigma*thetaw1;
    elseif c_1>c_2 && w>= 2*c_2/(c_1+c_2)
        xw=mu+sigma*thetaw2;
    end
end
end