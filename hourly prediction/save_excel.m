clc;
clear;
close all;

ASRF1801 = importdata('../solar data/ASRF1801.txt');    % interval of 5 mins
ASRF1802 = importdata('../solar data/ASRF1802.txt');
ASRF1803 = importdata('../solar data/ASRF1803.txt');
ASRF1804 = importdata('../solar data/ASRF1804.txt');
ASRF1805 = importdata('../solar data/ASRF1805.txt');
ASRF1806 = importdata('../solar data/ASRF1806.txt');
ASRF1807 = importdata('../solar data/ASRF1807.txt');
ASRF1808 = importdata('../solar data/ASRF1808.txt');
ASRF1809 = importdata('../solar data/ASRF1809.txt');
ASRF1810 = importdata('../solar data/ASRF1810.txt');
ASRF1811 = importdata('../solar data/ASRF1811.txt');
ASRF1812 = importdata('../solar data/ASRF1812.txt');
ASRF1901 = importdata('../solar data/ASRF1901.txt');
ASRF18=[
    ASRF1801(2:end,:);ASRF1802(2:end,:);
    ASRF1803(2:end,:);ASRF1804(2:end,:);
    ASRF1805(2:end,:);ASRF1806(2:end,:);
    ASRF1807(2:end,:);ASRF1808(2:end,:);
    ASRF1809(2:end,:);ASRF1810(2:end,:);
    ASRF1811(2:end,:);ASRF1812(2:end,:)];
xlswrite('ASRF18.xls', ASRF18);