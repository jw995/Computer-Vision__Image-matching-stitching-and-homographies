clc;
clear;
close all hidden;

I1=imread('../data/3.JPG');
load 'im3.mat';
I0=im3;

scale=0.3;
I1=imresize(I1,scale);
I1 = permute(I1,[2 1 3]);

im4 = generatePanorama(I1, I0);