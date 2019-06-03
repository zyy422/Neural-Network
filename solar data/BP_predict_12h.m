clc;
clear;
close all;
%% import data and preprocess data for 6:05~18:00

ASRF1801=importdata('ASRF1801.txt');
ASRF1901=importdata('ASRF1901.txt');
ASDT18=importdata('./total or avg data(16-19)/ASDT18.txt');
ASDT19=importdata('./total or avg data(16-19)/ASDT19.txt');
ASRF1801=ASRF1801(2:end,:);
ASRF1901=ASRF1901(2:end,:);
ASDT18=ASDT18(2:end,:);
ASDT19=ASDT19(2:end,:);
sum_1=0;
sum_2=0;
mean_value=zeros(size(ASRF1801,1)/288,2);
j=0;
for i=1:size(ASRF1801,1)
    sum_1=sum_1+ASRF1801(i,3);
    sum_2=sum_2+ASRF1801(i,17);
    if rem(i,288)==0
        j=j+1;
        mean_value(j,1) = sum_1/288;
        mean_value(j,2) = sum_2/288;
        sum_1=0;
        sum_2=0;
    end
end
train_x = mean_value; % 平均光照和温度
days = zeros(size(train_x,1),1);
for i=1:size(train_x,1)
    days(i,1) = i; 
end
train_x = [days,train_x];
train_x = train_x(1:30,:);
buff=ASRF1801(12:12:end,13); % 24小时的输出功率
train_y=reshape(buff,24,31)';
train_y=train_y(2:31,:);


%% 归一化预处理

[train_x,st1]=mapminmax(train_x'); %normalization
[train_y,st2]=mapminmax(train_y');
%   [test_x,st3]=mapminmax(test_x');

%% build feed forward neural network

net = feedforwardnet([11,24]);
net = train(net,train_x,train_y);
net.trainParam.goal = 0.0001;
