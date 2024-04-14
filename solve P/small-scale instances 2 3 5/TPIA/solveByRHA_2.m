function [S,S_]=solveByRHA_2(i,j,S,T,R,array,sigma_,pi_,n)
%�������� i��j��Ҫ�������̨����
%T=x(j,:)+x(i,:);  ��ʾ����i��j��̨�����Ϸ���Ĺ���
%R=T;              ���濪ʼʱ���ж��ٹ���û�����·���
%array=T;
%sigma_=sigma([j,i],:); 
%pi_=pi([j,i],:);
% S=zeros(1,n);

while sum(R)~=0
    u=zeros(2,n);
    f_S=getf(S,array-S,n,sigma_,pi_);  %S��¼��Щ�����i ��ʼʱΪ0���� ��ʾ�ռ����������ķ�ʽ
    f_T=getf(T,array-T,n,sigma_,pi_);  %Tͬ����¼��Щ�����������1̨����  ��ʼʱΪȫ�������ļ��ϣ������ų��ķ�ʽ
    for k=1:n
        if R(k)==0
            continue
        end
        S_=S;
        S_(k)=1;
        u(1,k)=getf(S_,array-S_,n,sigma_,pi_)-f_S;   %a_k
        T_=T;
        T_(k)=0;
        u(2,k)=f_T-getf(T_,array-T_,n,sigma_,pi_);   %b_k
        if u(1,k)>=0                                 %a_k>0������k�����������i
            T=T_;                                    %T_(k)=0;
            R(k)=0;
            f_T=getf(T,array-T,n,sigma_,pi_);
        end
        if u(2,k)<=0                                 %b_k<0������k���������i
            S=S_;                                    %S_(k)=1;
            R(k)=0;
            f_S=getf(S,array-S,n,sigma_,pi_);
        end
        length_R=sum(R);
        if sum(u(1,:).*R<0)==length_R&&sum(u(2,:).*R>0)==length_R
            break
        end
    end
    if sum(R)==0
        break
    end
    %job_index3=job_index3+1;
    [max1,index1]=max(-u(1,:).*R);        %�ҵ�R���δ����Ĺ������� ����ֵ����a_k�����Ӧ��k
    [max2,index2]=max(u(2,:).*R);         %�ҵ�R���δ����Ĺ������� ����b_k�����Ӧ��k
    b=max1+max2;
    a=b*rand(1,1);
    if a <= max1  
        S(index1)=1;                     
        R(index1)=0;
    else
        T(index2)=0;
        R(index2)=0;
    end
end

S_=array-S;                              %S_����û�з����i�ģ��Ǿ��Ƿ������j��

