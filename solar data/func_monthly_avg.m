function [avg_data] = func_monthly_avg( in_data )
% this function preprocess 3mins data of all month into 288 points.
% this function is validated for monthly input data
% the 288 points is average number of erveryday in one month
% the data of one month is converted into 288 point.
in_data(in_data<0)=0;
in_data=in_data(2:end,:);
[row,col]=size(in_data);
days=row/288;  %get the days of each months
avg_data=zeros(288,18);
for i=1:288
    for j=1:col
        if 0==mod(j,2)|j==1
            continue;
        end
        sum=in_data(i,j);
        for d=1:days-1
            sum=sum+in_data(d*288+i,j);
        end
        avg_data(i,j)=sum/days;
    end
end

