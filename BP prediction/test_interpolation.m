clc;
clear;
close all;

%% piecewise linear interpolation algorithm

% x = 1:3:30;
% y = 2*x.^2+1;
% xx = 2:3;
% yy = interp1(x, y, xx);
% plot(x, y, 's', xx, yy, 'o');

%% one-dimension FFT interpolation algorithm

% x = 0:1.2:10;
% y = sin(x);
% n = 2*length(x);
% yy = interpft(y, n);
% xx = 0:0.6:10.4;
% hold on;
% plot(x,y,'ro');
% plot(xx,yy,'b.-')
% title('One-dimension FFT interpolation');
% legend('original data','interpolation data');

%% two-dimension interpolation algorithm

[x,y] = meshgrid(-3:0.25:3);
z = peaks(x,y);
[xx,yy] = meshgrid(-3:0.125:3);
zz = interp2(x,y,z,xx,yy);
mesh(x,y,z);
hold on;
mesh(xx,yy,zz+25);
hold off;
axis([-3,3,-3,3,-10,50]);
title('two-dimension interpolation');

