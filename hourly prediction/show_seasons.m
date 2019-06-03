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

data_spring = [ASRF1803(2:end,[3,13,17]);ASRF1804(2:end,[3,13,17]);
    ASRF1805(2:end,[3,13,17])];   % spring
data_summer = [ASRF1806(2:end,[3,13,17]);ASRF1807(2:end,[3,13,17]);
    ASRF1808(2:end,[3,13,17])];
data_autumn = [ASRF1809(2:end,[3,13,17]);ASRF1810(2:end,[3,13,17]);
    ASRF1811(2:end,[3,13,17])];
data_winter = [ASRF1812(2:end,[3,13,17]);ASRF1801(2:end,[3,13,17]);
    ASRF1802(2:end,[3,13,17])];

data_spring = data_spring(12:12:end,:)';
data_summer = data_summer(12:12:end,:)';
data_autumn = data_autumn(12:12:end,:)';
data_winter = data_winter(12:12:end,:)';
%% delete abnormal data
ab_spr = find(data_spring(2,:)<0);
ab_sum = find(data_summer(2,:)<0);
ab_aut = find(data_autumn(2,:)<0);
ab_win = find(data_winter(2,:)<0);
data_spring(:,ab_spr)=[];
data_summer(:,ab_sum)=[];
data_autumn(:,ab_aut)=[];
data_winter(:,ab_win)=[];
%% PV output
figure('Name','PV output');
subplot(2,2,1)
plot(data_spring(2,:));
title("Spring");
subplot(2,2,2)
plot(data_summer(2,:));
title("Summer");
subplot(2,2,3)
plot(data_autumn(2,:));
title("Autumn");
subplot(2,2,4)
plot(data_winter(2,:));
title("Winter");
%% Local irradiance
figure('Name','Irradiance');
subplot(2,2,1)
plot(data_spring(1,:));
title("Spring");
subplot(2,2,2)
plot(data_summer(1,:));
title("Summer");
subplot(2,2,3)
plot(data_autumn(1,:));
title("Autumn");
subplot(2,2,4)
plot(data_winter(1,:));
title("Winter");
%% Local temperature
figure('Name','temperature');
subplot(2,2,1)
plot(data_spring(3,:));
title("Spring");
subplot(2,2,2)
plot(data_summer(3,:));
title("Summer");
subplot(2,2,3)
plot(data_autumn(3,:));
title("Autumn");
subplot(2,2,4)
plot(data_winter(3,:));
title("Winter");