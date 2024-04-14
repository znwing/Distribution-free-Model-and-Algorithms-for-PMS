c_2=10;
Theta_e_matrix=zeros(19);
index=1;
for gamma=[1/10,1/9,1/8,1/7,1/6,1/5,1/4,1/3,1/2,1,2,3,4,5,6,7,8,9,10]
        disp(['gamma=',num2str(gamma)]);
        [c_1,theta_e]=getThetaE(c_2,a,x);
        Theta_e_matrix(index) = theta_e;
        index=index+1;
end
filename=strcat('Theta_e_matrix.mat');
save(filename,'Theta_e_matrix');

