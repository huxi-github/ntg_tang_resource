function [ output_args ] = Untitled1( input_args )
%UNTITLED1 Summary of this function goes here
%  Detailed explanation goes here

clc;
clear;
figure(2);

a1=[8000 15000 18000];
a2=[8000 15000 26000];
plot(a1,'m--o','linewidth',1.5);
hold on;
plot(a2,'r--o','linewidth',1.5);