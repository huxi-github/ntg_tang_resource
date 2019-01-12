clc;
clear;
figure(2);
%%{
start=1;

name1='IOlogs\io1.log';
name2='IOlogs\io2.log';

Y1=load(name1);%文件名
Y2=load(name2);%文件名

%start=5;
%Len=60;%length(T);读取文件记录的长度
%Y=T(1:60,1);
%Y=round((Y*9)/1000);
plot(Y1,'b-','linewidth',1.5);
hold on;
plot(Y2,'r-','linewidth',1.5);
%title('视频码率100kbps','fontsize',12,'FontWeight','Bold');%标题
%set(gca, 'YTickLabel', {'0', '5M','10M','15M'});
%set(gca, 'XTickLabel', {'0', '1000','2000','3000', '4000', '5000','6000'});
%xlabel('用户数（个）','fontsize',12,'FontWeight','Bold');
legend('接收流量','发送流量');
xlabel('时间（s）','fontsize',12,'FontWeight','Bold');
ylabel('流量（B）','fontsize',12,'FontWeight','Bold');
hold on;
%}