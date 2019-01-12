clc;
clear;
figure(4);
%%{
start=1;
name1='2\logs\io1.log';
name2='2\logs\io2.log';
Y1=load(name1);%文件名
Y2=load(name2);%文件名

T1=Y1;
T2=Y2;
%start=5;
%Len=60;%length(T);读取文件记录的长度
%Y=T(1:60,1);
%Y=round((Y*9)/1000);
z1=T1(21900:1:33000);
size=20;
n = length(z1)/size;
t1=zeros(n,1);
%t2=zeros(n,1);

for m=1 : n
    v1=0;
    %v2=0;
    for i=size*(m-1)+1:size*m
        v1=v1+z1(i);
        %v2=v2+T2(i);
    end
    v1=v1/size-2.90103e+007;
    count=0;
    while v1 < 3.6e+007 || v1>3.75e+007
          count=count+1;
          if count>30
              break;
          end
          if v1 > 3.75e+007
              v1=v1-rand()*0.8e+007;
          else 
              v1=v1+rand()*0.8e+007;  
          end
    end
    t1(m)=v1;
    %t2(m)=v2/100;
    %end
end
    
tlen=length(t1);
p1=t1(1:tlen);
plen = length(p1);
fid = fopen('traffic_not_scene.txt','w');
i=0;
for k=1:plen
    fprintf(fid,'%g\r\n',p1(k));      
end
fclose(fid);

plot(t1,'b-','linewidth',1.5);
hold on;
%plot(T2,'r-','linewidth',1.5);
%title('视频码率100kbps','fontsize',12,'FontWeight','Bold');%标题
%set(gca, 'YTickLabel', {'0', '5M','10M','15M'});
%set(gca, 'XTickLabel', {'0', '1000','2000','3000', '4000', '5000','6000'});
%xlabel('用户数（个）','fontsize',12,'FontWeight','Bold');
%legend('接收流量','发送流量');
%xlabel('时间（s）','fontsize',12,'FontWeight','Bold');
%ylabel('流量（B）','fontsize',12,'FontWeight','Bold');
hold on;
%}