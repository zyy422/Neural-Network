function [ err ] = BPFun_2( x )
% BPFunc_2 is used as fitness function for genetic algorithm
% input parameters:
%   1:number of hiddden layer node
%   2:weights: in_dim->hidden
%   3:bias:hidden
%   3:weights: hidden->out_dim
%   4:bias:out_dim

global test_x;
global test_y;
global train_x;
global train_y;
global st2;
in_dim=2;
out_dim=1;
hiddenNode=x(1);
w1_num=in_dim*hiddenNode;
w2_num=hiddenNode*out_dim;
w1=x(2:w1_num+1);
b1=x(w1_num+2,w1_num+hiddenNode+1);
w2=x(w1_num+hiddenNode+2:w1_num+hiddenNode+w2_num+1);
b2=x(w1_num+hiddenNode+w2_num+2,w1_num+hiddenNode+w2_num+1+out_dim);
net.iw{1,1}=reshape(w1,hiddenNode,in_dim);
net.iw(2,1)=reshape(w2,out_dim,hiddenNode);
net.b{1}=reshape(b1,hiddenNode,1);
net.b(2)=reshape(b2,out_dim,1);
net = feedforwardnet(floor(hidden_num));
net = train(net,train_x,train_y);
predict = sim(net,test_x);
predict = mapminmax('reverse',predict,st2);

rootMeanSquare=rmse(test_y,predict);
fprintf("%f\n",rootMeanSquare);
err=rootMeanSquare;

end

