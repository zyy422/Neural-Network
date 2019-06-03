function y = func_reconstr(x)
%FUNC_RECONSTR is used for reconstruction of matrix of 3 lines and 
%return matrix.
%
%   Creator: Zhou
%   Creation date:    2019-2-27
%   Lasted modified：    2019-2-27
%
% the input of this function apply to training set and test set of NN.

training_size = size(x,2);
%% delete abnormal data at row 2 
tmp_2 = x(2,:);
index_2 = find(tmp_2<=0);   % insolation less than 0
x(:,index_2') = []; % delete wrong column 


%% delete abnormal data at row 3
tmp_3 = x(3,:);
index_3 = find(tmp_3<=-50); % temperature less than -50
x(:,index_3') = []; %   delete wrong column

%% linear interpolation

row_x_2 = x(1,:);
row_y_2 = x(2,:);
row_y_3 = x(3,:);
index_ = [index_2,index_3];% get all empty index number in row 2 and row 3
misRow2 = interp1(row_x_2,row_y_2,index_);
misRow3 = interp1(row_x_2,row_y_3,index_);
miss = [index_;misRow2;misRow3];    % all missing data
percentage = size(miss,2)/training_size;
fprintf("There exist %d (about %f percent) abnormal data in training set.\n",size(miss,2),percentage*100);
%% bubble sort algorithm for interpolation matrix

row_1 = miss(1,:);
for m = 1:size(miss,2)
    for n = m+1:size(miss,2)
        if row_1(m) > row_1(n)
            miss(:,[m,n])=miss(:,[n,m]);    % exchange two column
        end
    end
end

i = 1;
for col = miss(1,:)
    x = [x(:,1:col-1),miss(:,i),x(:,col:end)];
    i = i+1;
end
y = x;


