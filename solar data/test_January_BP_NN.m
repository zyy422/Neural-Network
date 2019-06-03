clc;
clear;
close all;
%% import data and preprocess data for 6:05~18:00

ASRF1801=importdata('ASRF1801.txt');
ASRF1901=importdata('ASRF1901.txt');
avg_1=func_monthly_avg(ASRF1801);
avg_1901=func_monthly_avg(ASRF1901);
input=[avg_1(:,3),avg_1(:,15),avg_1(:,17)]';
result=avg_1(:,11)';
test_input=[avg_1901(:,3),avg_1901(:,15),avg_1901(:,17)]';
train_input=func_data_6_18_clock(input);
train_result=func_data_6_18_clock(result);
test_input=func_data_6_18_clock(test_input);

%% build NN
[p1,st1]=mapminmax(train_input); %normalization
[t1,st2]=mapminmax(train_result);
%创建网络
% net=newff(minmax(train_input),[3,50,1],{'tansig','tansig','purelin'},'trainlm');
net = feedforwardnet(50);
%net=feedforwardnet(50);
%设置训练次数
net.trainParam.epochs = 5000;
%设置收敛误差
net.trainParam.goal=0.0001;
%net.trainParam.lr=0.0005; 2019-1-10 zhou
%训练网络
[net,tr]=train(net,p1,t1);
%输入测试数据
%将输入数据归一化
[test_input,st3]=mapminmax(test_input);
%放入到网络输出数据
b=sim(net,test_input);
%将得到的数据反归一化得到预测数据
result=mapminmax('reverse',b,st2);

%% draw the data
plot(1:144,result);
hold on;
real_data=avg_1901(:,11);
real=real_data(73:216);
real=real';
plot(1:144,real); % draw data from 6:05~18:00
legend('prediction data','test data');
