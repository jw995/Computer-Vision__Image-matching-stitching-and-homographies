function im3 = generatePanorama(im1, im2)

%%%
    I0=im1;     I1=im2;
    im1= double(rgb2gray(im1));
    im2= double(rgb2gray(im2));

    im1=im1/max(im1(:));
    im2=im2/max(im2(:));

    [locs0, desc0] = briefLite(im1);
    [locs1, desc1] = briefLite(im2);
    [matches] = briefMatch(desc1, desc0, 0.98);
    % load matches_cover.mat;

    figure();
    plotMatches(im2, im1, matches, locs1, locs0);

    for i=1:size(matches,1)
        match1=matches(i,1);
        match2=matches(i,2); 
        p1(:,i)=locs1(match1,:)';
        p2(:,i)=locs0(match2,:)';
    end

    [bestH2to1, inliers] = computeH_ransac(p2, p1);
    % save incline_H bestH2to1;
    % load 'pnc_H.mat';
    % load 'incline_H.mat';
    
%[panoImg] = imageStitching(I0, I1, bestH2to1);
f1=figure;
im3 = imageStitching_noClip(I0, I1, bestH2to1);

% saveas(f1,'pnc','png');

end