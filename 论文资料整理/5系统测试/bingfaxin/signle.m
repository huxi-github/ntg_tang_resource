function [ output_args ] = Untitled1( input_args )
%UNTITLED1 Summary of this function goes here
%  Detailed explanation goes here

clc;
clear;
figure(2);

subplot(2,2,1);
name1='ntrig_cpu.txt';
name2='nginx_cpu.txt';

y1=load(name1);
y2=load(name2);

plot(y1,'b-.p','linewidth',1.5);
hold on;
plot(y2,'r--*','linewidth',1.5);

hold on;
subplot(2,2,2);
name3='traffic.txt';
y3=load(name3);
plot(y3,'m--o','linewidth',1.5);

hold on;
subplot(2,2,3);
name4='mem.txt';
y4=load(name4);
plot(y4,'m--o','linewidth',1.5);

hold on;
subplot(2,2,4);
name5='connect.txt';
y5=load(name5);
plot(y5,'m--o','linewidth',1.5);