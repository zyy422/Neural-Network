%% this scripts was builed for ploting monthly data
clc;
clear;
%% Data IN 2018
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
ASRF1901=importdata('ASRF1901.txt'); % Data in 2019 for verification
avg_1=func_monthly_avg(ASRF1801);
avg_2=func_monthly_avg(ASRF1802);
avg_3=func_monthly_avg(ASRF1803);
avg_4=func_monthly_avg(ASRF1804);
avg_5=func_monthly_avg(ASRF1805);
avg_6=func_monthly_avg(ASRF1806);
avg_7=func_monthly_avg(ASRF1807);
avg_8=func_monthly_avg(ASRF1808);
avg_9=func_monthly_avg(ASRF1809);
avg_10=func_monthly_avg(ASRF1810);
avg_11=func_monthly_avg(ASRF1811);
avg_12=func_monthly_avg(ASRF1812);
avg_1901=func_monthly_avg(ASRF1901); % Data in 2019 for verification
%% test section
x=1:12;
y=1:288;
[x,y]=meshgrid(x,y);
% plot 3kw array pv output
OP_5KW=[avg_1(:,11),avg_2(:,11),avg_3(:,11),avg_4(:,11),avg_5(:,11),avg_6(:,11),avg_7(:,11),avg_8(:,11),avg_9(:,11),avg_10(:,11),avg_11(:,11),avg_12(:,11)];
plot3(x,y,OP_5KW);
figure;
%plot global horizontal irradiance
GHI=[avg_1(:,3),avg_2(:,3),avg_3(:,3),avg_4(:,3),avg_5(:,3),avg_6(:,3),avg_7(:,3),avg_8(:,3),avg_9(:,3),avg_10(:,3),avg_11(:,3),avg_12(:,3)];
plot3(x,y,GHI);
title("Average monthly irradiance in 2018");
%% training stample(one year)
% GHI=[avg_1(:,3);avg_2(:,3);avg_3(:,3);avg_4(:,3);avg_5(:,3);avg_6(:,3);avg_7(:,3);avg_8(:,3);avg_9(:,3);avg_10(:,3);avg_11(:,3);avg_12(:,3)];
% AVG_WIND=[avg_1(:,15);avg_2(:,15);avg_3(:,15);avg_4(:,15);avg_5(:,15);avg_6(:,15);avg_7(:,15);avg_8(:,15);avg_9(:,15);avg_10(:,15);avg_11(:,15);avg_12(:,15)];
% AVG_TEMP=[avg_1(:,17);avg_2(:,17);avg_3(:,17);avg_4(:,17);avg_5(:,17);avg_6(:,17);avg_7(:,17);avg_8(:,17);avg_9(:,17);avg_10(:,17);avg_11(:,17);avg_12(:,17)];
% OP_5KW=[avg_1(:,11);avg_2(:,11);avg_3(:,11);avg_4(:,11);avg_5(:,11);avg_6(:,11);avg_7(:,11);avg_8(:,11);avg_9(:,11);avg_10(:,11);avg_11(:,11);avg_12(:,11)];
% INPUT=[GHI';AVG_WIND';AVG_TEMP']; % transpose
% INPUT=func_data_6_18_clock(INPUT); % select data from 6:00~18:00
% OP_5KW=OP_5KW';
% OP_5KW=func_data_6_18_clock(OP_5KW);