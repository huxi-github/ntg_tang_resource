
start=1;
T=load('io.log');%�ļ���
Y=T(1:3600);%����ʱ��
plot(Y,'b-','linewidth',1.3);
%title('�ȶ��Բ���','fontsize',12,'FontWeight','Bold');%����
xlabel('����ʱ�䣨s��','fontsize',12,'FontWeight','Bold');
ylabel('���������ʣ�Bps��','fontsize',12,'FontWeight','Bold');
hold on;
