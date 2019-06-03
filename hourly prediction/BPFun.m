function [ err ] = BPFun( hidden_num )
%BPFUN Summary of this function goes here
%   Detailed explanation goes here
global test_x;
global test_y;
global train_x;
global train_y;
global st2;
net = feedforwardnet(floor(hidden_num));
net = train(net,train_x,train_y);
predict = sim(net,test_x);
predict = mapminmax('reverse',predict,st2);

rootMeanSquare=rmse(test_y,predict);
fprintf("%f\n",rootMeanSquare);
err=rootMeanSquare;

end

