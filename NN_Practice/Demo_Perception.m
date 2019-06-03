%% create perception 
p=[-1 1; -1 1]; %input array range
t=1;    % number of output nodes
net=newp(p,t); % create perception
train_input=[0,0,1,1;0,1,0,1];
train_expect=[0,1,1,1];
net=train(net,train_input,train_expect);
test_input=[0.9;0.9];
test_result=sim(net,test_input);
