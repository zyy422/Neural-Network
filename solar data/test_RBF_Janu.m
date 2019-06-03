%% I. 清空环境变量
clear;
clc;
%% II. 训练集/测试集产生
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
real_data=avg_1901(:,11);
real_result=real_data(73:216)';
%% III. RBF神经网络创建及仿真测试
% 1. 创建网络
net = newrbe(train_input,train_result,30);
 
%%
% 2. 仿真测试
test_result = sim(net,test_input);

%% IV. 性能评价
%%
% 1. 相对误差error
error = abs(test_result - real_result)./real_result;
plot(1:144,test_result);
hold on;
plot(1:144,real_result);
legend('train_after_result','real_results');
%%
% 2. 决定系数R^2
%R2 = (N * sum(T_sim .* T_test) - sum(T_sim) * sum(T_test))^2 / ((N * sum((T_sim).^2) - (sum(T_sim))^2) * (N * sum((T_test).^2) - (sum(T_test))^2)); 
%%
% 3. 结果对比
%result = [real_result' test_result' error'];
%% V. 绘图
