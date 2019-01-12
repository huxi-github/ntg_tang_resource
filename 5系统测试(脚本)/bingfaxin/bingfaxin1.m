function [ output_args ] = Untitled1( input_args )
%UNTITLED1 Summary of this function goes here
%  Detailed explanation goes here
clc;
clear;
figure(2);

name1='data\uses.txt'
name2='data\usecpu.txt'
name3='data\traffic.txt'
name4='data\responsetime.txt'


start=1;
subplot(1,2,1);
%流量变化
T1=load(name1);%文件名
t1=T1;
hold on;
plot(t1,'r-','linewidth',1.5);

hold on;

%cpu
subplot(1,2,2);
T2=load(name2);%文件名
%Y=T(1:80,1);%启动时长
%Len=length(Y);
t2=T2;

plot(t2,'b-','linewidth',1.5);
hold on;



