function [ output_args ] = Untitled1( input_args )
%UNTITLED1 Summary of this function goes here
%  Detailed explanation goes here
clc;
clear;
figure(3);
hold on;
subplot(1,2,1);
name4='mem.txt';
y4=load(name4);
plot(y4,'m--o','linewidth',1.5);

hold on;
subplot(1,2,2);
name5='connect.txt';
y5=load(name5);
plot(y5,'m--o','linewidth',1.5);