%%% This project is used for predicting PV output of 24h ahead
%%% 
%%% input parameters：daily mean irradiance and temperature, day of months
%%% training goal: 24h PV outputdata in 2017
%%% test  sample：Janunary,2018

clc;
clear;
close all;
%% data import and preprocessing
ASDT17 = importdata('../total or avg data(16-19)/ASDT17.txt'); %daily mean value in 2017
ASDT18 = importdata('../total or avg data(16-19)/ASDT18.txt'); %daily mean value in 2018

% training data set
ASRF1701 = importdata('../ASRF1701.txt');    %24h PV output in 2017
ASRF1702 = importdata('../ASRF1702.txt');
ASRF1703 = importdata('../ASRF1703.txt');
ASRF1704 = importdata('../ASRF1704.txt');
ASRF1705 =  xlsread('../ASRF1705.xlsx','Sheet1','m1:m8929');
ASRF1706 = importdata('../ASRF1706.txt');
ASRF1707 = importdata('../ASRF1707.txt');
ASRF1708 = importdata('../ASRF1708.txt');
ASRF1709 = importdata('../ASRF1709.txt');
ASRF1710 = importdata('../ASRF1710.txt');
ASRF1711 = importdata('../ASRF1711.txt');
ASRF1712 = importdata('../ASRF1712.txt');
ASRF1710 = rmmissing(ASRF1710);
ASDT17 = ASDT17(2:end,:);

% test data set
ASRF1801 = importdata('../ASRF1801.txt');
ASDT18 = ASDT18(2:end,:);

train_x = [ASDT17(:,1),ASDT17(:,3),ASDT17(:,17)];
train_x(:,2) = train_x(:,2)/24;
tmp = train_x(:,2);
tmp(tmp<0)=0;
train_x = [train_x(:,1),tmp,train_x(:,3)]';
train_x = train_x(:,1:end-1);
ASRF17=[
    ASRF1701(2:end,13);ASRF1702(2:end,13);
    ASRF1703(2:end,13);ASRF1704(2:end,13);
    ASRF1705(2:end, :);ASRF1706(2:end,13);
    ASRF1707(2:end,13);ASRF1708(2:end,13);
    ASRF1709(2:end,13);ASRF1710(2:end,13);
    ASRF1711(2:end,13);ASRF1712(2:end,13)];
tmp = ASRF17(12:12:end, :);
train_y = reshape(tmp,24,365);
train_y = train_y(:,2:end);
train_y(train_y<0) = 0;

test_x = [ASDT18(:,1),ASDT18(:,3),ASDT18(:,17)];
test_x(:,2) = test_x(:,2)/24;
tmp_2=test_x(:,2);
tmp_2(tmp_2<0)=0;
test_x = [test_x(:,1),tmp_2,test_x(:,3)];
test_x = test_x(1:30,:)';

test_y = ASRF1801(2:end, 13);
tmp_y = test_y(12:12:end,:);
test_y = reshape(tmp_y,24,31);
test_y = test_y(:,2:end);

%% reconstruction of abnormal column data

train_x = func_reconstr(train_x); % temperature<-50, insolation<0
test_x = func_reconstr(test_x);

%% normilazation data
[train_x,st1]=mapminmax(train_x); %normalization
[train_y,st2]=mapminmax(train_y);
test_x = mapminmax('apply',test_x,st1);
test_y_nor = mapminmax('apply',test_y,st2);
% 
%% build feed forward neural network

net = feedforwardnet([11,17]);
net = train(net, train_x, train_y);
predicted = sim(net, test_x);
predicted = mapminmax('reverse', predicted, st2);

%% plot result

figure(1);
x = 1:24;
plot(x, predicted(:,10),'r');
hold on;
plot(x, test_y(:,10));
legend("predicted value"," real value");
mse = mse(predicted-test_y);





