function [ output_args ] = Untitled1( input_args )
%UNTITLED1 Summary of this function goes here

Y1=load('traffic_24.txt');%文件名
T1=Y1(1:13800);%文件名

size=20;
len = length(T1);
n = len/size;

t1=zeros(n,1);
%t2=zeros(n,1);

for m=1 : n
    v1=0;
    %v2=0;
    for i=size*(m-1)+1:size*m
        v1=v1+T1(i);
        %v2=v2+T2(i);
    end
    t1(m)=v1/size;
    %t2(m)=v2/100;
end

tlen=length(t1);
p1=t1(1:tlen);
plen = length(p1);
fid = fopen('traffic_out_web.txt','w');
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