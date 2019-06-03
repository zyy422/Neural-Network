%% clear environment variable
clc;
clear

%% import data
load concrete_data.mat
%  randomly create training set and test set
n = randperm(size(attributes,2));
% ѵ
p_train = attributes(:,n(1:80))';
t_train = strength(:,n(1:80))';
% ���Լ�����23����
p_test = attributes(:,n(81:end))';
t_test = strength(:,n(81:end))';

%% ��ݹ�һ��

% ѵ����
[pn_train,inputps] = mapminmax(p_train');
pn_train = pn_train';
pn_test = mapminmax('apply',p_test',inputps);
pn_test = pn_test';
% ���Լ�
[tn_train,outputps] = mapminmax(t_train');
tn_train = tn_train';
tn_test = mapminmax('apply',t_test',outputps);
tn_test = tn_test';

%% SVMģ�ʹ���/ѵ��

% Ѱ�����c����/g����
[c,g] = meshgrid(-10:0.5:10,-10:0.5:10);
[m,n] = size(c);
cg = zeros(m,n);
eps = 10^(-4);
v = 5;
bestc = 0;
bestg = 0;
error = Inf;
for i = 1:m
    for j = 1:n
        cmd = ['-v ',num2str(v),' -t 2',' -c ',num2str(2^c(i,j)),' -g ',num2str(2^g(i,j) ),' -s 3 -p 0.1'];
        cg(i,j) = svmtrain(tn_train,pn_train,cmd);
        if cg(i,j) < error
            error = cg(i,j);
            bestc = 2^c(i,j);
            bestg = 2^g(i,j);
        end
        if abs(cg(i,j) - error) <= eps && bestc > 2^c(i,j)
            error = cg(i,j);
            bestc = 2^c(i,j);
            bestg = 2^g(i,j);
        end
    end
end
% ����/ѵ��SVM  
cmd = [' -t 2',' -c ',num2str(bestc),' -g ',num2str(bestg),' -s 3 -p 0.01'];
model = svmtrain(tn_train,pn_train,cmd);

%% SVM����Ԥ��
[Predict_1,error_1] = svmpredict(tn_train,pn_train,model);
[Predict_2,error_2] = svmpredict(tn_test,pn_test,model);
% ����һ��
predict_1 = mapminmax('reverse',Predict_1,outputps);
predict_2 = mapminmax('reverse',Predict_2,outputps);
% ���Ա�
result_1 = [t_train predict_1];
result_2 = [t_test predict_2];

%% ��ͼ
figure(1)
plot(1:length(t_train),t_train,'r-*',1:length(t_train),predict_1,'b:o')
grid on
legend('��ʵֵ','Ԥ��ֵ')
xlabel('����')
ylabel('��ѹǿ��')
string_1 = {'ѵ����Ԥ����Ա�';
           ['mse = ' num2str(error_1(2)) ' R^2 = ' num2str(error_1(3))]};
title(string_1)
figure(2)
plot(1:length(t_test),t_test,'r-*',1:length(t_test),predict_2,'b:o')
grid on
legend('��ʵֵ','Ԥ��ֵ')
xlabel('����')
ylabel('��ѹǿ��')
string_2 = {'���Լ�Ԥ����Ա�';
           ['mse = ' num2str(error_2(2)) ' R^2 = ' num2str(error_2(3))]};
title(string_2)

%% BP ������

% ���ת��
pn_train = pn_train';
tn_train = tn_train';
pn_test = pn_test';
tn_test = tn_test';
% ����BP������
net = newff(pn_train,tn_train,10);
% ����ѵ������
net.trainParam.epcohs = 1000;
net.trainParam.goal = 1e-3;
net.trainParam.show = 10;
net.trainParam.lr = 0.1;
% ѵ������
net = train(net,pn_train,tn_train);
% �������
tn_sim = sim(net,pn_test);
% �����
E = mse(tn_sim - tn_test);
% ����ϵ��
N = size(t_test,1);
R2=(N*sum(tn_sim.*tn_test)-sum(tn_sim)*sum(tn_test))^2/((N*sum((tn_sim).^2)-(sum(tn_sim))^2)*(N*sum((tn_test).^2)-(sum(tn_test))^2)); 
% ����һ��
t_sim = mapminmax('reverse',tn_sim,outputps);
% ��ͼ
figure(3)
plot(1:length(t_test),t_test,'r-*',1:length(t_test),t_sim,'b:o')
grid on
legend('��ʵֵ','Ԥ��ֵ')
xlabel('����')
ylabel('��ѹǿ��')
string_3 = {'���Լ�Ԥ����Ա�(BP������)';
           ['mse = ' num2str(E) ' R^2 = ' num2str(R2)]};
title(string_3)

%%
% <html>
% <table width="656" align="left" >	<tr><td align="center"><p align="left"><font size="2">�����̳��</font></p><p align="left"><font size="2">Matlab������̳��<a href="http://www.matlabsky.com">www.matlabsky.com</a></font></p><p align="left"><font size="2">M</font><font size="2">atlab����ٿƣ�<a href="http://www.mfun.la">www.mfun.la</a></font></p></td>	</tr></table>
% </html>