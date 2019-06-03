%% import data
clc;
clear;
ASRF1801=importdata('ASRF1801.txt');
ASRF1802=importdata('ASRF1802.txt');
ASRF1803=importdata('ASRF1803.txt');
ASRF1804=importdata('ASRF1804.txt');
ASRF1805=importdata('ASRF1805.txt');
ASRF1806=importdata('ASRF1806.txt');
ASRF1807=importdata('ASRF1807.txt');
ASRF1808=importdata('ASRF1808.txt');
ASRF1809=importdata('ASRF1809.txt');
ASRF1810=importdata('ASRF1810.txt');
ASRF1811=importdata('ASRF1811.txt');
ASRF1812=importdata('ASRF1812.txt');
data=[ASRF1801;ASRF1802(2:end,:);
    ASRF1803(2:end,:);ASRF1804(2:end,:);
    ASRF1805(2:end,:);ASRF1806(2:end,:);
    ASRF1807(2:end,:);ASRF1808(2:end,:);
    ASRF1809(2:end,:);ASRF1810(2:end,:);
    ASRF1811(2:end,:);ASRF1812(2:end,:)];
data(data<0)=0;
x=data(2:end,2);
GHI=data(2:end,3);  % Global horizontal irradiance
PO=data(2:end,11);
%%  get daily average data
avg_GHI=func_get_avg(GHI);
avg_PO=func_get_avg(PO);
plot(1:365,avg_PO);
legend('Average avg_PO in 2018');
