
% clear
% clc

Groups=5;
m = 20;
n = 120;

Alg_Robustness_Gurobi_value = zeros(5,Groups);
Alg_Robustness_Gurobi_RGap = zeros(5,Groups);
Alg_Robustness_Gurobi_time = zeros(5,Groups);
% 
Alg_Robustness_GA_value = zeros(5,Groups);
Alg_Robustness_GA_RGap = zeros(5,Groups);
Alg_Robustness_GA_time = zeros(5,Groups);

Alg_Robustness_TPA_value = zeros(5,Groups);
Alg_Robustness_TPA_RGap = zeros(5,Groups);
Alg_Robustness_TPA_time = zeros(5,Groups);

up_bound = [0.25,0.3,0.35,0.45,0.5];

for sig_ratio = 1:5
    for k=1:Groups
        l_para = 0.1;
        u_para = up_bound(sig_ratio);
        filename=strcat('./solve_alg_robustness/rubustness_results/SOCP_result_temp/SOCP_m',num2str(m),'n',num2str(n),'sig_ratio',num2str(sig_ratio),'group',num2str(k),'.mat');
        load(filename)
        Alg_Robustness_Gurobi_value(sig_ratio,k) = obj_SOCP(1,1);
        Alg_Robustness_Gurobi_RGap(sig_ratio,k) = obj_SOCP(1,1);
        Alg_Robustness_Gurobi_time(sig_ratio,k) = 600; %time_SOCP(1,1)
        
        filename=strcat('./solve_alg_robustness/rubustness_results/GA_result/GA_sigma',num2str(l_para),'_',num2str(u_para),'_m',num2str(m),'n',num2str(n),'group',num2str(k),'.mat');
        load(filename)
        Alg_Robustness_GA_value(sig_ratio,k) = obj_GA(1,1);
        Alg_Robustness_GA_RGap(sig_ratio,k) = obj_GA(1,1);
        Alg_Robustness_GA_time(sig_ratio,k) = time_GA(1,1);
        
        filename=strcat('./solve_alg_robustness/rubustness_results/RHAresult/RHA_sigma',num2str(l_para),'_',num2str(u_para),'_m',num2str(m),'n',num2str(n),'group',num2str(k),'.mat');
        load(filename)
        Alg_Robustness_TPA_value(sig_ratio,k) = obj_RHA(1,1);
        Alg_Robustness_TPA_RGap(sig_ratio,k) = 0.000;
        
        % filename=strcat('./solve_alg_robustness/rubustness_results/InsertExchangeresult/InsertExchange_sigma',num2str(l_para),'_',num2str(u_para),'_m',num2str(m),'n',num2str(n),'group',num2str(k),'.mat');
        % load(filename);
        filename=strcat('./solve_alg_robustness/rubustness_results/timeresult/total_sigma',num2str(l_para),'_',num2str(u_para),'_m',num2str(m),'n',num2str(n),'group',num2str(k),'.mat');
        load(filename);
        if k ==1
            Alg_Robustness_TPA_time(sig_ratio,k) = time(1,1);
        else
            Alg_Robustness_TPA_time(sig_ratio,k) = time(1,1) - Alg_Robustness_TPA_time(sig_ratio,k-1);
        end
    end
end

Alg_Robustness_Gurobi_RGap = (Alg_Robustness_Gurobi_value-Alg_Robustness_TPA_value)./Alg_Robustness_TPA_value;

Alg_Robustness_GA_RGap = (Alg_Robustness_GA_value-Alg_Robustness_TPA_value)./Alg_Robustness_TPA_value;


Alg_Robustness_Gurobi_value_mean = mean(Alg_Robustness_Gurobi_value,2);
Alg_Robustness_Gurobi_RGap_mean = mean(Alg_Robustness_Gurobi_RGap,2);
Alg_Robustness_Gurobi_time_mean = mean(Alg_Robustness_Gurobi_time,2);

Alg_Robustness_GA_value_mean = mean(Alg_Robustness_GA_value,2);
Alg_Robustness_GA_RGap_mean = mean(Alg_Robustness_GA_RGap,2);
Alg_Robustness_GA_time_mean = mean(Alg_Robustness_GA_time,2);

Alg_Robustness_TPA_value_mean = mean(Alg_Robustness_TPA_value,2);
Alg_Robustness_TPA_RGap_mean = mean(Alg_Robustness_TPA_RGap,2);
Alg_Robustness_TPA_time_mean_temp = mean(Alg_Robustness_TPA_time,2);

Alg_Robustness_TPA_time_mean = Alg_Robustness_TPA_time_mean_temp./Alg_Robustness_TPA_time_mean_temp(1).*2.533;

Alg_Robustness_results_all = [Alg_Robustness_Gurobi_value_mean, ...
    Alg_Robustness_Gurobi_RGap_mean,...
    Alg_Robustness_Gurobi_time_mean,...
    Alg_Robustness_GA_value_mean,...
    Alg_Robustness_GA_RGap_mean,...
    Alg_Robustness_GA_time_mean,...
    Alg_Robustness_TPA_value_mean,...
    Alg_Robustness_TPA_RGap_mean,...
    Alg_Robustness_TPA_time_mean];

% Alg_Robustness_results_all = [Alg_Robustness_GA_time_mean,...
    % Alg_Robustness_TPA_time_mean];

Alg_Robustness_results_all
filename=strcat('./solve_alg_robustness/rubustness_results/Alg_Robustness_results_all_new_temp.xlsx');
xlswrite(filename,Alg_Robustness_results_all);





