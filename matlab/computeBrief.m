function [locs, desc] = computeBrief(im, locs, compareX, compareY)
% Compute the BRIEF descriptor for detected keypoints.
% im is 1 channel image, 
% locs are locations
% compareX and compareY are idx in patchWidth^2
% Return:
% locs: m x 2 vector which contains the coordinates of the keypoints
% desc: m x n bits vector which contains the BRIEF descriptor for each
%   keypoint.
%%%

datanum=size(locs,1);
nbits=size(compareX,1);
idx=0;

% compare the points
for i=1:datanum
    y=round(locs(i,1));  %wid
    x=round(locs(i,2));  %hei
    % get the 9*9 square
    hei=size(im,1);
    wid=size(im,2);
    
    if(y>4&&y<wid-4&&x>4&&x<hei-4)
        square=im(x-4:x+4,y-4:y+4);
        idx=idx+1;
        loc_x(idx,1)=x;
        loc_y(idx,1)=y;
        
        % implement the algorithm
        for j=1:nbits
            idx1=compareX(j,1);
            idx2=compareY(j,1);
            if(square(idx1)<square(idx2))
                desc(idx,j)=1;
            else 
                desc(idx,j)=0;
            end
        end 
    end
        
end

desc=int32(desc);
locs=[loc_y loc_x];

end