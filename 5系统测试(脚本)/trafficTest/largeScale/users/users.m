function [ output_args ] = Untitled1( input_args )
%UNTITLED1 Summary of this function goes here
%  Detailed explanation goes here
clc;
clear;
figure(2);
%%{
start=1;
x=0:1:25;
%Y=load('2016.2.3spline_1440.txt');%文件名
%Y=load('2016.2.240.txt');%文件名
Y=load('boke.txt');%文件名
%len = length(Y);
%t=zeros(len,1);
%upsize=80;
%for m=1 : len
%    t(m)=upsize+Y(m);
%end
%t

%Y2=load('logs\io_tx.log');%文件名
%Y=Y1(1:350,:);
plot(Y,'r.-','linewidth',1.5);
%axis([1 24 80 87])
%axis([1 24 0 7])
%set(gca,'XTick',x)
hold on;

