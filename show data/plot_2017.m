% this script is used for plot all data 
clc;
clear;
%% Data IN 2018
ASRF1701=importdata('../solar data/ASRF1701.txt');
month = ones(size(ASRF1701,1),1);
ASRF1701=[month,ASRF1701];
ASRF1702=importdata('../solar data/ASRF1702.txt');
month = ones(size(ASRF1702,1),1)+1;
ASRF1702=[month,ASRF1702];
ASRF1703=importdata('../solar data/ASRF1703.txt');
month = ones(size(ASRF1703,1),1)+2;
ASRF1703=[month,ASRF1703];
ASRF1704=importdata('../solar data/ASRF1704.txt');
month = ones(size(ASRF1704,1),1)+3;
ASRF1704=[month,ASRF1704];
ASRF1705=xlsread('../solar data/ASRF1705.xlsx','Sheet1','a1:r8929');
month = ones(size(ASRF1705,1),1)+4;
ASRF1705=[month,ASRF1705];
ASRF1706=importdata('../solar data/ASRF1706.txt');
month = ones(size(ASRF1706,1),1)+5;
ASRF1706=[month,ASRF1706];
ASRF1707=importdata('../solar data/ASRF1707.txt');
month = ones(size(ASRF1707,1),1)+6;
ASRF1707=[month,ASRF1707];
ASRF1708=importdata('../solar data/ASRF1708.txt');
month = ones(size(ASRF1708,1),1)+7;
ASRF1708=[month,ASRF1708];
ASRF1709=importdata('../solar data/ASRF1709.txt');
month = ones(size(ASRF1709,1),1)+8;
ASRF1709=[month,ASRF1709];
ASRF1710=importdata('../solar data/ASRF1710.txt');
ASRF1710 = rmmissing(ASRF1710);
month = ones(size(ASRF1710,1),1)+9;
ASRF1710=[month,ASRF1710];
ASRF1711=importdata('../solar data/ASRF1711.txt');
month = ones(size(ASRF1711,1),1)+10;
ASRF1711=[month,ASRF1711];
ASRF1712=importdata('../solar data/ASRF1712.txt');
month = ones(size(ASRF1712,1),1)+11;
ASRF1712=[month,ASRF1712];

ASRF17=[
    ASRF1701(2:end,:);ASRF1702(2:end,:); % 2 irradiance, 13power,17 temperature
    ASRF1703(2:end,:);ASRF1704(2:end,:);
    ASRF1705(2:end,:);ASRF1706(2:end,:);
    ASRF1707(2:end,:);ASRF1708(2:end,:);
    ASRF1709(2:end,:);ASRF1710(2:end,:);
    ASRF1711(2:end,:);ASRF1712(2:end,:)];
xlswrite('ASRF17.csv', ASRF17);