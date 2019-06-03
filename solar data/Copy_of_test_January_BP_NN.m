clc;
clear;
close all;
%% import data and preprocess data for 6:05~18:00

ASRF1801=importdata('ASRF1801.txt');
ASRF1901=importdata('ASRF1901.txt');
train_x=[
    ASRF1801(2:end,1),ASRF1801(2:end,3),ASRF1801(2:end,15),ASRF1801(2:end,17)
    ]; %% 天数，辐射，风速，温度
train_y=ASRF1801(2:end,13); % 15 kw 太阳能输出
output = train_y(1:288,:);
sum = 0;
j=0;
for i = 1:288
    if output(i,1) ~= 0
        j=j+1;
    end
    sum = sum + output(i,1);
end

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
% clear ASRF1801;
% clear ASRF1901;
train_x=train_x(1:(end-288),:);  % 训练输入要减去最后一天数据
train_y=train_y(289:end,:);   % 训练输出减去第一天数据
test_x=test_x(1:288,:);    % 前15天数据
test_y=test_y(289:577,:);
%% 归一化预处理

[train_x,st1]=mapminmax(train_x'); %normalization
[train_y,st2]=mapminmax(train_y');
[test_x,st3]=mapminmax(test_x');
%% 建立BPNN的模型

net = feedforwardnet([16,32]);
net=train(net,train_x,train_y);
% net.trainparam.epochs = 5000;
net.trainParam.goal = 0.001;
y = sim(net,test_x);
y(y<-1)=-1;
predict = mapminmax('reverse',y,st2);
plot(test_y,'r');
hold on;
plot(predict,'b*');