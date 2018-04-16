clc;
clear;
close all hidden;

load 'HarryPotter_H';
cv_desk=imread('../data/cv_desk.png');
cv_cover=imread('../data/cv_cover.jpg');
hp_cover=imread('../data/hp_cover.jpg');

hp_cover=imresize(hp_cover,[size(cv_cover,1) size(cv_cover,2)]);

[composite_img] = compositeH( bestH2to1, cv_desk, hp_cover);
imshow(composite_img);

