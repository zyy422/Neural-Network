clc;
clear;
close all;
%% load model
load my_bp
load my_st1;
load my_st2;
%% import data
data = importdata("./pred rev_1.csv");
ASRF18 = importdata("./ASRF18 revision.csv");
real_pv = ASRF18(3:end,7)';
real_irr = data(2:end,6);
real_temp = data(2:end,5);
pred_irr = data(2:end,8);
pred_temp = data(2:end,7);
train_x = [pred_irr,pred_temp]';
%% normalization
train_x = mapminmax('apply',train_x,st1);
pred_pv = sim(net,train_x);
pred_pv = mapminmax('reverse',pred_pv,st2);
pred_pv(pred_pv<0)=0;
%% process predicted data
pred_pv(1,1:5)=0;
pred_pv(1,18:23)=0;
for i=1:352
    pred_pv(1,24*i:24*i+6)=0;
    pred_pv(1,24*i+19:24*i+23)=0;
end
meanSquareError = rmse(real_pv,pred_pv)
plot(real_pv(1,1:24*8));
hold on;
plot(pred_pv(1,1:24*8));
legend('real power','predicted power');
