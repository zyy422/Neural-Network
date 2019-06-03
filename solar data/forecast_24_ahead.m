clc;
clear;
close all;
%% import data and preprocess data

ASRF1801=importdata('ASRF1801.txt');
ASRF1901=importdata('ASRF1901.txt');
train_x=[
    ASRF1801(2:end,1),ASRF1801(2:end,3),ASRF1801(2:end,15),ASRF1801(2:end,17)
    ]; %% 天数，辐射，风速，温度
train_y=ASRF1801(2:end,13); % 15 kw 太阳能输出
test_x=[
    ASRF1801(2:end,1),ASRF1901(2:end,3),ASRF1901(2:end,15),ASRF1901(2:end,17)
    ];
test_y=ASRF1901(2:end,13);
%% 将小于0的数置为0

sub_train_x = train_x(:,2:3);
sub_train_x(sub_train_x<0)=0;
train_x = [train_x(:,1),sub_train_x,train_x(:,4)];
sub_test_x = test_x(:,2:3);
sub_test_x(sub_test_x<0)=0;
test_x = [test_x(:,1),sub_test_x,test_x(:,4)];
train_y(train_y<0)=0;
test_y(test_y<0)=0;
