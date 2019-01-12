function [ output_args ] = Untitled1( input_args )
%UNTITLED1 Summary of this function goes here
%  Detailed explanation goes here
clear;
clc;
%figure(1);

name1='1\logs\io1.log';
y=load(name1);%ÎÄ¼þÃû
len = length(y);
avr=0;
for n=1:len
   avr=(avr*(n-1)+y(n))/n;
end

avr