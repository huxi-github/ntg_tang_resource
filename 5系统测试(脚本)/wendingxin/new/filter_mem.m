function [ output_args ] = Untitled1( input_args )
%UNTITLED1 Summary of this function goes here
%  Detailed explanation goes here
Y1=load('logs\mem_used.log');%文件名
%Y2=load('logs\io_tx.log');%文件名

size=9;
len = length(Y1);
n = len/size;

t1=zeros(n,1);
%t2=zeros(n,1);
%fid = fopen('filter\mem_out.txt','w');

for m=1 : n
    v1=0;
    v2=0;

    for i=size*(m-1)+1:size*m
        v1=v1+Y1(i);
       % v2=v2+Y2(i);
    end
    t1(m)=v1/size - m*0.4899;
    %t2(m)=v2/size;
    %fprintf(fid,'%d\r\n',t1(m));    
end
%fclose(fid);
plot(t1,'b-','linewidth',1.5);

%hold on
%plot(t2,'g-','linewidth',1.5);


hold on;