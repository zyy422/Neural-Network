% This project is used for real time prediction.
% The model accepts as input parameters the irradiance and temperature.
% The output is represtented by the PV power output.
clc;
clear;
close all;

ASRF1801 = importdata('../solar data/ASRF1801.txt');    % interval of 5 mins
ASRF1802 = importdata('../solar data/ASRF1802.txt');
ASRF1803 = importdata('../solar data/ASRF1803.txt');
ASRF1804 = importdata('../solar data/ASRF1804.txt');
ASRF1805 = importdata('../solar data/ASRF1805.txt');
ASRF1806 = importdata('../solar data/ASRF1806.txt');
ASRF1807 = importdata('../solar data/ASRF1807.txt');
ASRF1808 = importdata('../solar data/ASRF1808.txt');
ASRF1809 = importdata('../solar data/ASRF1809.txt');
ASRF1810 = importdata('../solar data/ASRF1810.txt');
ASRF1811 = importdata('../solar data/ASRF1811.txt');
ASRF1812 = importdata('../solar data/ASRF1812.txt');
ASRF1901 = importdata('../solar data/ASRF1901.txt');
% ASRF18=[
%     ASRF1801(2:end,[3,13,17]);ASRF1802(2:end,[3,13,17]); % 2 irradiance, 13power,17 temperature
%     ASRF1803(2:end,[3,13,17]);ASRF1804(2:end,[3,13,17]);
%     ASRF1805(2:end,[3,13,17]);ASRF1806(2:end,[3,13,17]);
%     ASRF1807(2:end,[3,13,17]);ASRF1808(2:end,[3,13,17]);
%     ASRF1809(2:end,[3,13,17]);ASRF1810(2:end,[3,13,17]);
%     ASRF1811(2:end,[3,13,17]);ASRF1812(2:end,[3,13,17])];
data_spring = [ASRF1803(2:end,[3,13,17]);ASRF1804(2:end,[3,13,17]);
    ASRF1805(2:end,[3,13,17])];   % spring
data_summer = [ASRF1806(2:end,[3,13,17]);ASRF1807(2:end,[3,13,17]);
    ASRF1808(2:end,[3,13,17])];
data_autumn = [ASRF1809(2:end,[3,13,17]);ASRF1810(2:end,[3,13,17]);
    ASRF1811(2:end,[3,13,17])];
data_winter = [ASRF1812(2:end,[3,13,17]);ASRF1801(2:end,[3,13,17]);
    ASRF1802(2:end,[3,13,17])];
data_spring = data_spring(12:12:end,:);
data_summer = data_summer(12:12:end,:);
data_autumn = data_autumn(12:12:end,:);
data_winter = data_winter(12:12:end,:);
ASRF1901 = ASRF1901(12:12:end,:);
ASRF1901 = ASRF1901(1:360,[3,13,17]);
test_x = ASRF1901(:,[1,3])';
test_y = ASRF1901(:,2)';

% ASRF18=ASRF18(12:12:end,:);
% irr = reshape(ASRF18(:,1),24,365);  %input
% temp = reshape(ASRF18(:,3),24,365); %input
% power = reshape(ASRF18(:,2),24,365);  %output
% train_x = [irr,temp];
% train_y = power;
irr = data_winter(:,1);
temp = data_winter(:,3);
power = data_winter(:,2);
train_x = [irr,temp]';
train_y = power';
%% delete abnormal data
ab_irr = find(train_x(1,:)<0);
train_x(:,ab_irr)=[];
train_y(:,ab_irr)=[];
ab_irr = find(train_x(1,:)<=30);
train_x(1,ab_irr)=0;
ab_irr_test=find(test_x(1,:)<=30);
test_x(1,ab_irr_test)=0;

%% normalization
[train_x,st1] = mapminmax(train_x);
[train_y,st2] = mapminmax(train_y);
test_x = mapminmax('apply',test_x,st1);
%% build network
net = feedforwardnet(3);
net = train(net,train_x,train_y);
norm_predict = sim(net,test_x);
predict = mapminmax('reverse',norm_predict,st2);
for i = 1:size(test_y,2)
    if test_y(i)<30
        predict(i)=0;
    end
end
compare=[ASRF1901,predict'];
plot(1:360,predict,'ro--');
hold on;
plot(1:360,test_y,'bo--');
legend('predicted','real data');
meanSquareError = rmse(test_y,predict)
save my_bp net;
save my_st1 st1;
save my_st2 st2;
