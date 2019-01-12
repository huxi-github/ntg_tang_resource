function [ output_args ] = Untitled1( input_args )
%UNTITLED1 Summary of this function goes here
%  Detailed explanation goes here
% 1.0e+007 *
figure(2);
Y=load('traffic_24.txt');%ÎÄ¼şÃû
p1=Y(1:13800);
plot(p1,'r.-','linewidth',1.5);
hold on