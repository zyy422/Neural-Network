clc;clear;close all;
[x,t]=simplefit_dataset; %matlabs' data
net=feedforwardnet;
view(net);
y=net (x);
perf=perform(net,y,t);