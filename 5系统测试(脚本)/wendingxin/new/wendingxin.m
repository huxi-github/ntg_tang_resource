function [ output_args ] = Untitled1( input_args )
%UNTITLED1 Summary of this function goes here
%  Detailed explanation goes here
clc;
clear;
figure(2);

name1='filter\traffic_out.txt'
name2='filter\cpu_out.txt'
name3='filter\mem_out.txt'
name4='filter\load_out.txt'


start=1;
subplot(2,2,1);
%�����仯
T1=load(name1);%�ļ���
t1=T1(10:586);
hold on;
plot(t1,'r-','linewidth',1.5);
ylabel('������B��','fontsize',12,'FontWeight','Bold');
hold on;

%cpu
subplot(2,2,2);
T2=load(name2);%�ļ���
%Y=T(1:80,1);%����ʱ��
%Len=length(Y);
cpu1=T2(50:626);

plot(cpu1,'b-','linewidth',1.5);
hold on;
ylabel('CPU������(%)','fontsize',12,'FontWeight','Bold');
hold on;

%�ڴ�
subplot(2,2,3);
T3=load(name3);%�ļ���
t3=T3(10:586);

plot(t3,'r-','linewidth',1.5);

ylabel('Memory�������(MB)','fontsize',12,'FontWeight','Bold');
hold on;



subplot(2,2,4);
T4=load(name4)
m1=T4(5:581,1);
m2=T4(5:581,2);
m3=T4(5:581,3);
len = length(T1);
%Y=0:1:6000;
%Y=T(1,1);%����ʱ��
plot(m1,'b-','linewidth',1.5);

hold on
plot(m2,'g-','linewidth',1.5);

hold on
plot(m3,'r-','linewidth',1.5);

ylabel('CPU����(��)','fontsize',12,'FontWeight','Bold');


