function [ output_args ] = Untitled1( input_args )
%UNTITLED1 Summary of this function goes here
%  Detailed explanation goes here

figure(2);

name3='newIO1/io1.log';
Y1=load(name3);%文件名

T1=Y1(250:13420);
%T1=Y1(1000:53800);%文件名
size=9;
len = length(T1);
n = len/size;

%fid = fopen('traffic_24.txt','w');
%for k=1:len
%    fprintf(fid,'%g\r\n',T1(k));
%end
%fclose(fid);

t1=zeros(n,1);
%t2=zeros(n,1);

for m=1 : n
    v1=0;
    %v2=0;
    for i=size*(m-1)+1:size*m
        v1=v1+T1(i);
        %v2=v2+T2(i);
    end
    %t1(m)=v1/size;
    t1(m)=T1(size*(m-1)+1) + 17000000;
    %t2(m)=v2/100;
end

tlen=length(t1);
p1=t1(1:tlen);
plen = length(p1);
fid = fopen('traffic_out_web_new.txt','w');
i=0;
for k=1:plen
    i=i+1;
    if mod(i,10)==0
        fprintf(fid,'%d,\r\n',p1(k));    
    else        
        fprintf(fid,'%d, ',p1(k));
    
    end

end
fclose(fid);

%Y2=load('logs\io_tx.log');%文件名
%Y=Y1(1:350,:);
%plot(p1,'r.-','linewidth',1.5);
plot(t1,'b-','linewidth',1.5);
%axis([1 24 80 87])
%axis([1 24 0 7])
%set(gca,'XTick',x)
hold on;
