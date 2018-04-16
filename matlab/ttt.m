clc;
clear;
close all hidden;

I0=imread('../data/incline_L.png');
I1=imread('../data/incline_R.png');

% I0=imread('../data/pnc1.png');
% I1=imread('../data/pnc0.png');

% scale=0.5;
% I0=imresize(I0,scale);
% I1=imresize(i1,scale);

im3 = generatePanorama(I0, I1);


