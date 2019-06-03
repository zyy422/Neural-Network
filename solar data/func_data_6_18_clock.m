function [buf] = func_data_6_18_clock(input)
% this function cut out 6~18 0'clock data

[m,n]=size(input);
buf=zeros(m,n/2);
for i=0:(n/288)-1
    buf(:,(144*i+1):144*(i+1))=input(:,(73+288*i):(216+288*i));
end