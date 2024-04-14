clc
clear all

mu=90;
sigma=12;

gxy1=zeros(1,10);
xy1 = zeros(10,2);
theta_e1=zeros(1,10);
w1=zeros(1,10);
x_w1=zeros(1,10);
min_MRV1=zeros(1,10);

index=1;
for a=1:10
    [x,fval]=solveg(a);
    gxy1(index)=-fval;
    xy1(index,1)=x(1);
    xy1(index,2)=x(2);
    theta_e1(index)=(x(2)*((a-x(2))/(1+x(2)))^0.5-x(1)*((1-x(1))/(a+x(1)))^0.5)/(x(1)+x(2));
    w1(index)=2/(1+a)*(1+(theta_e1(index))^2+((theta_e1(index))^2*(1+(theta_e1(index))^2))^0.5);
    x_w1(index)=mu+sigma*theta_e1(index);
%     min_MRV1(index)=sigma*c_2*gxy1(index);
    index=index+1;
end


gxy=zeros(1,11);
xy = zeros(11,2);
theta_e=zeros(1,11);
w=zeros(1,11);
x_w=zeros(1,11);
min_MRV=zeros(1,11);

index=1;
for a=0:0.1:1
    [x,fval]=solveg(a);
    gxy(index)=-fval;
    xy(index,1)=x(1);
    xy(index,2)=x(2);
    theta_e(index)=(x(2)*((a-x(2))/(1+x(2)))^0.5-x(1)*((1-x(1))/(a+x(1)))^0.5)/  (x(1)+x(2));
    w(index)=(2*a)/(1+a)*(1+(theta_e(index))^2+((theta_e(index))^2*(1+(theta_e(index))^2))^0.5);
    x_w(index)=mu+sigma*theta_e(index);
%     min_MRV(index)=sigma*c_2*gxy(index);
    index=index+1;
end
disp(theta_e)
% disp(w1)
% disp(w)
% disp(x_w1)
% disp(x_w)


% u=0.0:0.1:0.9;
% t=1:10;
% ut=[u,t];
% ww=[w,w1];


% x_w(1)=0;
% figure;
% yyaxis left
% plot(u,w);
% hold on;
% yyaxis right
% plot(u,x_w);
% hold on;
% yyaxis left
% plot(t,w1);
% hold on;
% yyaxis right
% plot(t,x_w1);


u=0.0:0.1:0.9;
w(11)=[];
x_w(1)=0;
x_w(11)=[];
t=1:10;
ut=[u,t];
ww=[w,w1];
xww=[x_w,x_w1];
ind=0:19;
y1=ww;
y2=xww;
% warning off
% axis_label_font_size = 24;
% tick_label_font_size = 24;
% legend_font_size = 20;
% legend_position = [0.23,0.75,0.1,0.1];
% 
% Line_Width = 3;
% Marker_Size = 12;
% set(0,'defaultfigurecolor','w')
% set(gcf,'unit','centimeters','position',[5 5 23 20]);
% 
% yyaxis left
% plot(ind(1:),y1(1:),'r-', 'LineWidth',Line_Width,'MarkerSize',Marker_Size);
% hold on;
% yyaxis right
% plot(ind(1:),y2(1:),'s-');
% set(gca,'XTick',ind);
% set(gca,'XTickLabel',{'0.1','0.2','0.3','0.4','0.5','0.6','0.7','0.8','0.9','1','2','3','4','5','6','7','8','9','10'});
% 



axis_label_font_size = 24;
tick_label_font_size = 25;
legend_font_size = 25;
% legend_position = [0.23,0.75,0.1,0.1];

Line_Width = 3;
Marker_Size = 12;
set(0,'defaultfigurecolor','w')
set(gcf,'unit','centimeters','position',[5 5 30 25]);
yyaxis left; 
plot(ind(2:19),y1(2:19),'ks-', 'LineWidth',Line_Width,'MarkerSize',Marker_Size)

ylabel('$w^*$','interpreter','Latex','fontsize',tick_label_font_size,'Units','normalized','Color','k')
set(gca,'ycolor','k')
set(gca,'FontName','Times New Roman', 'FontSize',tick_label_font_size);

set(gca,'YLim',[0.3,1.1],'fontsize',axis_label_font_size);
% set(gca,'YTickLabel','fontsize',axis_label_font_size);

yyaxis right; 
plot(ind(2:19),y2(2:19),'kd--', 'LineWidth',Line_Width,'MarkerSize',Marker_Size)
ylabel('$d_{w^*}$','interpreter','Latex','fontsize',tick_label_font_size,'Units','normalized','Color','k')
set(gca,'ycolor','k')
set(gca,'FontName','Times New Roman', 'FontSize',tick_label_font_size);

legend({'$w^*$','$d_{w^*}$'},'Interpreter','latex','fontsize',legend_font_size,'position',[0.7,0.25,0.1,0.1])
set(gca,'YLim',[40,120],'fontsize',axis_label_font_size);
% set(gca,'YTick',[0,120]);
% set(gca,'YTickLabel','fontsize',axis_label_font_size);

xlim([0, 19])
xticks(0:1:19)
xlabel('$\gamma$','interpreter','Latex','fontsize',axis_label_font_size,'Units','normalized')
set(gca,'XTickLabel',{'0.1','0.2','0.3','0.4','0.5','0.6','0.7','0.8','0.9','1','2','3','4','5','6','7','8','9','10','11'},'fontsize',axis_label_font_size);



% box off
exportgraphics(gcf,fullfile('solve w & d_w', 'gamma-w-dw-major.png'),'Resolution',600);
exportgraphics(gcf,fullfile('solve w & d_w', 'gamma-w-dw-major.pdf'),'ContentType','vector');
exportgraphics(gcf,fullfile('solve w & d_w', 'gamma-w-dw-major.eps'));





