clc;
clear;
figure(4);
%%{
start=1;
name1='3\logs\io1.log';
name2='3\logs\io2.log';
Y1=load(name1);%�ļ���
Y2=load(name2);%�ļ���

T1=Y1;
T2=Y2;
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
%legend('��������','��������');
%xlabel('ʱ�䣨s��','fontsize',12,'FontWeight','Bold');
%ylabel('������B��','fontsize',12,'FontWeight','Bold');
hold on;
%}