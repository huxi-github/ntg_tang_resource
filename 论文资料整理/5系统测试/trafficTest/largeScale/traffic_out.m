function [ output_args ] = Untitled1( input_args )
%UNTITLED1 Summary of this function goes here
%  Detailed explanation goes here
figure(2);
Y=load('traffic_out_old.txt');%�ļ���
p=Y(1:560)
plot(Y,'r.-','linewidth',1.5);
hold on