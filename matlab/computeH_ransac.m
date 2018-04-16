function [ bestH2to1, inliers] = computeH_ransac( locs1, locs2)
%COMPUTEH_RANSAC A method to compute the best fitting homography given a
%list of matching points.

% added an input sigma which is the scope of inliers. For different
% images, this value may vary due to different scale of image
%Q2.2.3

%%%
N=size(locs1,2);
inliers=zeros(N,1);

% set scope here
stable=0;
sigma=10;

locs1=locs1';
locs2=locs2';
ori=[locs1 ones(N,1)];
trans=[locs2 ones(N,1)];

for i=1:10^100
    idx=randperm(N,5);
    pair1=locs1(idx,:);
    pair2=locs2(idx,:);
    H = computeH_norm(pair1',pair2');
    %H = computeH(pair1',pair2');
    
    % transform the ponts using H and check how many pairs are inside a scope
    cal_ori= H*trans';
    my_ori=cal_ori./cal_ori(3,:);
    
    diff=ori'-my_ori;
    dist=sqrt(sum(diff.^2));
    
    count=dist<sigma;

    if (sum(count) > sum(inliers))
        inliers = count;
        stable=0;
    else 
        stable=stable+1;
    end
    
    if(stable>1000)
        break;
    end
    
end

matches=find(inliers==1);
pair_1=locs1(matches,:);
pair_2=locs2(matches,:);
bestH2to1=double(computeH_norm(pair_1',pair_2'));


end

