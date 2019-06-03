%% this script get 8 types of PV data
clc;
clear;
ASRF1801=importdata('ASRF1801.txt');
ASRF1801(ASRF1801<0)=0;
avg=func_monthly_avg(ASRF1801);
subplot(2,4,1);
plot(1:288,avg(:,3));
legend('global horizontal irradiance(w/m^2)');
subplot(2,4,2);
plot(1:288,avg(:,5));
legend('Direct normal irradiance(w/m^2)');
subplot(2,4,3);
plot(1:288,avg(:,7));
legend('Diffuse irradiance(w/m^2)');
subplot(2,4,4);
plot(1:288,avg(:,9));
legend('Tilted global irradiance(w/m^2)');
subplot(2,4,5);
plot(1:288,avg(:,11));
legend('5kw array tilted 15 degree S(watts)');
subplot(2,4,6);
plot(1:288,avg(:,13));
legend('15kw array tilted 15 degree S(watts)');
subplot(2,4,7);
plot(1:288,avg(:,15));
legend('AVG wind speed(m/hr)');
subplot(2,4,8);
plot(1:288,avg(:,17));
legend('Avg temperature');