
%% 
clc;
clear;
close all;

%% generate training set and test set
load spectra_data.mat
% generate randomly training set and test set
temp = randperm(size(NIR,1));
% training set (50 samples)
P_train = NIR(temp(1:50),:)';
T_train = octane(temp(1:50),:)';
% test set (10 samples)
P_test = NIR(temp(51:end),:)';
T_test = octane(temp(51:end),:)';
N = size(P_test,2);

%% Create and train BP neural network and simulate network

% Create BP neural network
net = feedforwardnet(9);
% configure training paramaters
net.trainParam.epochs = 1000;
net.trainParam.goal = 1e-3;
net.trainParam.lr = 0.01;
% training network
net = train(net,P_train,T_train);
% simulate network and test
T_sim_bp = sim(net,P_test);

% %% RBF�����紴�����������
% 
% % ��������
% net = newrbe(P_train,T_train,0.3);
% % �������
% T_sim_rbf = sim(net,P_test);

%% performance evaluation

% relative error
error_bp = abs(T_sim_bp - T_test)./T_test;
% determination coefficient R^2
R2_bp = (N * sum(T_sim_bp .* T_test) - sum(T_sim_bp) * sum(T_test))^2 / ((N * sum((T_sim_bp).^2) - (sum(T_sim_bp))^2) * (N * sum((T_test).^2) - (sum(T_test))^2)); 
% result comparation
result_bp = [T_test', T_sim_bp', error_bp' ]

%% ��ͼ
figure
plot(1:N,T_test,'b:*',1:N,T_sim_bp,'r-o')
legend('real value','BP predicted valueֵ')
xlabel('prediction sample')
ylabel('辛烷值ֵ')
string = {'BP神经网络预测结果对比';['R^2=' num2str(R2_bp) '(BP)']};
title(string)

