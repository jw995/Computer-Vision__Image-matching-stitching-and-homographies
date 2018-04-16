clc;
clear;
close all hidden;

I0=imread('../data/model_chickenbroth.jpg');
im0= double(rgb2gray(I0));
im0=im0/max(im0(:));

for j=1:36
    im1 = imrotate(im0,-10*(j-1),'nearest','crop');

    [locs0, desc0] = briefLite(im0);
    [locs1, desc1] = briefLite(im1);

    [matches] = briefMatch(desc1, desc0, 2);
    plotMatches(im1, im0, matches, locs1, locs0);

    for i=1:size(matches,1)
        match1=matches(i,1);
        match2=matches(i,2); 
        p1(:,i)=locs1(match1,:)';
        p2(:,i)=locs0(match2,:)';
    end

    [bestH2to1, inliers] = computeH_ransac(p2, p1);
    correct(j,1)=sum(inliers);
    
end

angle=0:10:350;
bar(angle,correct);
xlabel('Rotate angle');
ylabel('Number of Matches');