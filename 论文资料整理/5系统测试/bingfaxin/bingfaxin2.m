function [ output_args ] = Untitled1( input_args )
%UNTITLED1 Summary of this function goes here
%  Detailed explanation goes here
clc;
clear;
figure(3);

name1='data\uses.txt'
name2='data\usecpu.txt'
name3='data\traffic.txt'
name4='data\responsetime.txt'


%内存
subplot(1,2,1);
T3=load(name3);%文件名
t3=T3;

plot(t3,'r-','linewidth',1.5);


hold on;



subplot(1,2,2);
T4=load(name4);
t4=T4;

hold on
plot(t4,'r-','linewidth',1.5);



