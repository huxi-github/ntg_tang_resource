function [ output_args ] = Untitled1( input_args )
%UNTITLED1 Summary of this function goes here
%  Detailed explanation goes here
clc;
clear;
figure(3);
%%{

%name1='traffic_not_scene.txt';
name2='traffic_out_web.txt';
%Y1=load(name1);%�ļ���
Y2=load(name2);%�ļ���

%plot(p1,'b-','linewidth',1.5);
%hold on;
plot(Y2,'r-','linewidth',1.5);
