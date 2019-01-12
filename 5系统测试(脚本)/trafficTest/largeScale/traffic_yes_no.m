function [ output_args ] = Untitled1( input_args )
%UNTITLED1 Summary of this function goes here
%  Detailed explanation goes here
clc;
clear;
figure(3);
%%{

name1='traffic_not_scene.txt';
name2='traffic_out_old.txt';
Y1=load(name1);%文件名
Y2=load(name2);%文件名

ylen=length(Y1);
p1=Y1(1:ylen);
plen = length(p1);
for k=1:plen
    p1(k)=p1(k)+rand()*0.1803e+007+0.2703e+007;      
end

plot(p1,'b-','linewidth',1.5);
hold on;
plot(Y2,'r-','linewidth',1.5);
