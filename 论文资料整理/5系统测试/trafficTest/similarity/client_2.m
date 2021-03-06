clc;
clear;
figure(4);
%%{
start=1;

Y1=load('logs\io_rx.log');%文件名
Y2=load('logs\io_tx.log');%文件名

T1=Y1(1:20000,1);
T2=Y2(1:20000,1);
%start=5;
%Len=60;%length(T);读取文件记录的长度
%Y=T(1:60,1);
%Y=round((Y*9)/1000);
plot(T1,'b-','linewidth',1.5);
hold on;
plot(T2,'r-','linewidth',1.5);
%title('视频码率100kbps','fontsize',12,'FontWeight','Bold');%标题
%set(gca, 'YTickLabel', {'0', '5M','10M','15M'});
%set(gca, 'XTickLabel', {'0', '1000','2000','3000', '4000', '5000','6000'});
%xlabel('用户数（个）','fontsize',12,'FontWeight','Bold');
legend('接收流量','发送流量');
xlabel('时间（s）','fontsize',12,'FontWeight','Bold');
ylabel('流量（B）','fontsize',12,'FontWeight','Bold');
hold on;
%}