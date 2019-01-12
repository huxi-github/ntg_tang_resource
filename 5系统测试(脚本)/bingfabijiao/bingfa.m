function [ output_args ] = Untitled1( input_args )
%UNTITLED1 Summary of this function goes here
%  Detailed explanation goes here
clc;
clear;
figure(2);

subplot(1,2,1);
name1='event_time.txt';
name2='thread_time.txt';

y1=load(name1);
y2=load(name2);

plot(y1,'b-.p','linewidth',1.5);
hold on;
plot(y2,'r--*','linewidth',1.5);

hold on;
subplot(1,2,2);
name3='event_cpu.txt';
name4='thread_cpu.txt';
y3=load(name3);
y4=load(name4);

plot(y3,'m--o','linewidth',1.5);
hold on;
plot(y4,'r--*','linewidth',1.5);