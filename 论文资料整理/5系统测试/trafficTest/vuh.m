
start=1;
T=load('io.log');%文件名
Y=T(1:3600);%启动时长
plot(Y,'b-','linewidth',1.3);
%title('稳定性测试','fontsize',12,'FontWeight','Bold');%标题
xlabel('运行时间（s）','fontsize',12,'FontWeight','Bold');
ylabel('网络吞吐率（Bps）','fontsize',12,'FontWeight','Bold');
hold on;
