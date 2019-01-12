function [ output_args ] = Untitled1( input_args )
%UNTITLED1 Summary of this function goes here
%  Detailed explanation goes here
clc;
clear;
figure(2);

name1='filter1\traffic_out.txt'
name2='filter1\cpu_out.txt'
name3='filter\mem_out.txt'
name4='filter\load_out.txt'




%内存
subplot(1,1,1);
T3=load(name3);%文件名
t3=T3(10:586);

plot(t3,'r-','linewidth',1.5);

ylabel('Memory利用情况(MB)','fontsize',12,'FontWeight','Bold');
hold on;


