clc;
clear;
close all hidden;

I0=imread('../data/chickenbroth_01.jpg');
I1=imread('../data/model_chickenbroth.jpg');

im0= double(rgb2gray(I0));
im1= double(rgb2gray(I1));

im0=im0/max(im0(:));
im1=im1/max(im1(:));

[locs0, desc0] = briefLite(im0);
[locs1, desc1] = briefLite(im1);

[matches] = briefMatch(desc1, desc0, 2);

f1=figure();
plotMatches(im1, im0, matches, locs1, locs0);

saveas(f1,'matching','jpg');