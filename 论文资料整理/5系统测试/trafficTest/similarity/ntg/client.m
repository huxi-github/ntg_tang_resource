clc;
clear;
figure(2);
%%{
start=1;
subplot(2,2,1);
T1=load('logs\load_m1.log');%�ļ���
T2=load('logs\load_m5.log');%�ļ���
T3=load('logs\load_m15.log');%�ļ���
len = length(T1);
%Y=0:1:6000;
%Y=T(1,1);%����ʱ��
plot(T1,'b-','linewidth',1.5);

hold on
plot(T2,'g-','linewidth',1.5);

hold on
plot(T3,'r-','linewidth',1.5);

%axis([0,600, 0, 4]);
%set(gca, 'XTick', [0 1 2 3]);
%set(gca, 'XTickLabel', {'0', '1000','2000','3000', '4000', '5000','6000'});
%title('�û�����','fontsize',12,'FontWeight','Bold');%����
%legend('Timer = 1��','Timer = 5��','Timer = 15��')
%xlabel('�û���������','fontsize',12,'FontWeight','Bold');
ylabel('CPU����(��)','fontsize',12,'FontWeight','Bold');

subplot(2,2,2);
T=load('logs\cpu.log');%�ļ���
%Y=T(1:80,1);%����ʱ��
%Len=length(Y);
plot(T,'b-','linewidth',1.5);
%axis([0,600, 34.35, 34.6]);
title('CPUʹ����','fontsize',12,'FontWeight','Bold');%����
%set(gca, 'YTickLabel', {'0', '1000','2000','3000', '4000', '5000','6000'});

%xlabel('����ʱ�䣨s��','fontsize',12,'FontWeight','Bold');
ylabel('CPU������(%)','fontsize',12,'FontWeight','Bold');
hold on;


subplot(2,2,3);

T1=load('logs\mem_free.log');%�ļ���
T2=load('logs\mem_total.log');%�ļ���
T3=load('logs\mem_used.log');%�ļ���
len = length(T1);
%Y=0:1:6000;
%Y=T(1,1);%����ʱ��
plot(T1,'b-.','linewidth',1.5);

hold on
plot(T2,'g:','linewidth',1.5);

hold on
plot(T3,'r-','linewidth',1.5);
%legend('free','total','used');
%T4=load('logs\mem_used.log')%�ļ���
%Y=T(1:60,1);%����ʱ��
%Y1=Y(1,1)
%Max=max(Y);
%Y=Max-Y;
%plot(T4,'b-','linewidth',1.5);
title('�ڴ�','fontsize',12,'FontWeight','Bold');%����
%set(gca, 'XTickLabel', {'0', '1000','2000','3000', '4000', '5000','6000'});
%xlabel('�û���������','fontsize',12,'FontWeight','Bold');
ylabel('Memory�������(MB)','fontsize',12,'FontWeight','Bold');
hold on;

%%{
subplot(2,2,4);
T1=load('logs\io_rx.log');%�ļ���
T2=load('logs\io_tx.log');%�ļ���
%start=5;
%Len=60;%length(T);��ȡ�ļ���¼�ĳ���
%Y=T(1:60,1);
%Y=round((Y*9)/1000);
plot(T1,'b-','linewidth',1.5);
hold on;
plot(T2,'r-','linewidth',1.5);
%title('��Ƶ����100kbps','fontsize',12,'FontWeight','Bold');%����
%set(gca, 'YTickLabel', {'0', '5M','10M','15M'});
%set(gca, 'XTickLabel', {'0', '1000','2000','3000', '4000', '5000','6000'});
%xlabel('�û���������','fontsize',12,'FontWeight','Bold');
ylabel('������B��','fontsize',12,'FontWeight','Bold');
hold on;
%}