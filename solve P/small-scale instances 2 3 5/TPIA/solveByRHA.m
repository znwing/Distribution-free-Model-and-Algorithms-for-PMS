function [time,x,obj,ComparedMat,job_num2,job_index2,job_index3]=solveByRHA(m,n,sigma,pi) 
curtime=clock;
x=zeros(m,n); %��¼�����ķ������
S=zeros(1,n); %��¼��Щ�����������1̨����  ��ʼʱΪ0���� ��ʾ�ռ����������ķ�ʽ
T=ones(1,n);  %ͬ����¼��Щ�����������1̨����  ��ʼʱΪ1���� ��ʾȫ�������ļ��ϣ������ų��ķ�ʽ
R=ones(1,n);  %��¼ʣ����Щ����û�з���

job_num2=0;
job_index2=0;
job_index3=0;
ComparedMat=zeros(m,n);%pi��������� ComparedMat(k,i)���k��ǰi�з���ͣ�

while sum(R)~=0  %�ж��Ƿ���ʣ�๤��û����
    u=zeros(m,n); % u(1,k)=a_k, u(2,k)=b_k    a_k��b_k ����ʾk��1�ɱ����ӵ���  ��ȥ  k��2�ɱ���������
                  %����a_k��kΪ  b_k��kΪ����1����֮��Ĺ���
    f_S=getf(S,1-S,n,sigma,pi); % 1-S�൱�ڽ�1��չ��nάȻ���ȥS
    f_T=getf(T,1-T,n,sigma,pi); % 1-T�൱�ڽ�1��չ��nάȻ���ȥT
    for k=1:n
        if R(k)==0
            continue
        end
        S_=S;
        S_(k)=1;
        u(1,k)=getf(S_,1-S_,n,sigma,pi)-f_S;
        T_=T;
        T_(k)=0;
        u(2,k)=f_T-getf(T_,1-T_,n,sigma,pi);
        if u(1,k)>=0                        %a_k>=0  ����Щ���������������1 k��2��1�ɱ�������
            T=T_;                           %T_(k)=0
            R(k)=0;
            f_T=getf(T,1-T,n,sigma,pi);
        end
        if u(2,k)<=0                        %b_k<=0  ����Щ�������������1 k��1��2�ɱ�������
            S=S_;                           %S_(k)=1
            R(k)=0;
            f_S=getf(S,1-S,n,sigma,pi);
        end
        if u(1,k)>=0||u(2,k)<=0
            job_num2=job_num2+1;           %job_num2��¼�ж��ٹ�����ֱ�Ӿ��ܷ����
        end
        job_index2=job_index2+1;
        length_R=sum(R);
        if sum(u(1,:).*R<0)==length_R && sum(u(2,:).*R>0)==length_R
            break
        end
    end
    
    if sum(R)==0
        break
    end
    job_index3=job_index3+1;
    [max1,index1]=max(-u(1,:).*R); %�ҵ�R���δ����Ĺ������� ����ֵ����a_k�����Ӧ��k
    [max2,index2]=max(u(2,:).*R);  %�ҵ�R���δ����Ĺ������� ����b_k�����Ӧ��k
    b=max1+max2;
    a=b*rand(1,1);
    if a <= max1                   %a_k �������Ϊ��k��2��S_���ó��� ��1��S �ĳɱ��仯
        S(index1)=1;               %b_k �������Ϊ��k��1��T���ó��� ��2��T_ �ĳɱ��仯
        R(index1)=0;
    else
        T(index2)=0;
        R(index2)=0;
    end
end
[obj,ComparedMat]=getf(S,1-S,n,sigma,pi);
x(1,:)=S;
x(2,:)=1-S;
time=etime(clock,curtime);
%disp(['time=',num2str(time)]);