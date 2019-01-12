function [ output_args ] = Untitled1( input_args )
%UNTITLED1 Summary of this function goes here
%  Detailed explanation goes here
Y1=load('logs\load_m1.log');%文件名
Y2=load('logs\load_m5.log');%文件名
Y3=load('logs\load_m15.log');%文件名

size=25;
len = length(Y1);
n = len/size;

t1=zeros(n,1);
t2=zeros(n,1);
t3=zeros(n,1);
%fid = fopen('filter\load_out.txt','w');
for m=1 : n
    v1=0;
    v2=0;
    v3=0;
    for i=size*(m-1)+1:size*m
        v1=v1+Y1(i);
        v2=v2+Y2(i);
        v3=v3+Y3(i);
    end
    t1(m)=v1/size;
    t2(m)=v2/size;
    t3(m)=v3/size;
  %  fprintf(fid,'%d %d %d\r\n',t1(m),t2(m),t3(m));
end
%fclose(fid);
plot(t1,'b-','linewidth',1.5);

hold on
plot(t2,'g-','linewidth',1.5);

hold on
plot(t3,'r-','linewidth',1.5);

hold on;