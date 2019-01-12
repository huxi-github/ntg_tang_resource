clc;
clear;
figure(2);
%%{
start=1;
subplot(2,2,1);
T1=load('logs\load_m1.log');%文件名
T2=load('logs\load_m5.log');%文件名
T3=load('logs\load_m15.log');%文件名
len = length(T1);
%Y=0:1:6000;
%Y=T(1,1);%启动时长
plot(T1,'b-','linewidth',1.5);

hold on
plot(T2,'g-','linewidth',1.5);

hold on
plot(T3,'r-','linewidth',1.5);

%axis([0,600, 0, 4]);
%set(gca, 'XTick', [0 1 2 3]);
%set(gca, 'XTickLabel', {'0', '1000','2000','3000', '4000', '5000','6000'});
%title('用户数量','fontsize',12,'FontWeight','Bold');%标题
%legend('Timer = 1分','Timer = 5分','Timer = 15分')
%xlabel('用户数（个）','fontsize',12,'FontWeight','Bold');
ylabel('CPU负载(个)','fontsize',12,'FontWeight','Bold');

subplot(2,2,2);
T=load('MuiltCPU.log');%文件名
cpu=load('totalCPU.log');
%Y=T(1:80,1);%启动时长
%Len=length(Y);
cpu1=T(:,1);
cpu2=T(:,2);
plot(cpu1,'b-','linewidth',1.5);
hold on;
plot(cpu,'r-','linewidth',1.5);
%axis([0,600, 34.35, 34.6]);
title('CPU使用率','fontsize',12,'FontWeight','Bold');%标题
%set(gca, 'YTickLabel', {'0', '1000','2000','3000', '4000', '5000','6000'});

%xlabel('运行时间（s）','fontsize',12,'FontWeight','Bold');
ylabel('CPU利用率(%)','fontsize',12,'FontWeight','Bold');
hold on;


subplot(2,2,3);

T1=load('logs\mem_free.log');%文件名
T2=load('logs\mem_total.log');%文件名
T3=load('logs\mem_used.log');%文件名
len = length(T1);
t=T3(1:3000);
%Y=0:1:6000;
%Y=T(1,1);%启动时长
%plot(T1,'b-.','linewidth',1.5);

hold on
%plot(T2,'g:','linewidth',1.5);

hold on
plot(t,'r-','linewidth',1.5);
%legend('free','total','used');
%T4=load('logs\mem_used.log')%文件名
%Y=T(1:60,1);%启动时长
%Y1=Y(1,1)
%Max=max(Y);
%Y=Max-Y;
%plot(T4,'b-','linewidth',1.5);
title('内存','fontsize',12,'FontWeight','Bold');%标题
%set(gca, 'XTickLabel', {'0', '1000','2000','3000', '4000', '5000','6000'});
%xlabel('用户数（个）','fontsize',12,'FontWeight','Bold');
ylabel('Memory利用情况(MB)','fontsize',12,'FontWeight','Bold');
hold on;

%%{
subplot(2,2,4);
T1=load('logs\io_rx.log');%文件名
T2=load('logs\io_tx.log');%文件名
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
ylabel('流量（B）','fontsize',12,'FontWeight','Bold');
hold on;
%}