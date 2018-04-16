clc;
clear;
close all hidden;

cv_cover=imread('../data/cv_cover.jpg');
cv_desk=imread('../data/cv_desk.png');
hp_cover=imread('../data/hp_cover.jpg');

im0= double(rgb2gray(cv_desk));
im1= double(cv_cover);

im0=im0/max(im0(:));
im1=im1/max(im1(:));

% [locs0, desc0] = briefLite(im0);
% [locs1, desc1] = briefLite(im1);
% [matches] = briefMatch(desc1, desc0, 0.98);
load matches_cover.mat;

f1=figure();
plotMatches(im1, im0, matches, locs1, locs0);

for i=1:size(matches,1)
    match1=matches(i,1);
    match2=matches(i,2); 
    p1(:,i)=locs1(match1,:)';
    p2(:,i)=locs0(match2,:)';
end

[bestH2to1, inliers] = computeH_ransac(p2, p1);

warp_im = warpH(hp_cover, double(bestH2to1), size(im0), 0);

figure;
imshow(warp_im);

% save HarryPotter_H bestH2to1;

