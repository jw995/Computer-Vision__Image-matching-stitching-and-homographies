function [panoImg] = imageStitching_noClip(img1, img2, H2to1)
%
% input
% Warps img2 into img1 reference frame using the provided warpH() function
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear equation
%
% output
% Blends img1 and warped img2 and outputs the panorama image
%
% To prevent clipping at the edges, we instead need to warp both image 1 and image 2 into a common third reference frame 
% in which we can display both images without any clipping.

%%%

[h w]=size(img2);
w=w/3;

[h1 w1]=size(img1);
w1=w1/3;

% img2 coordinates of 4 corners
corners = [1 w 1 w; 
              1 1 h h;
              1 1 1 1];
trans_corner = H2to1 * corners;
corner = floor(trans_corner./trans_corner(3,:));

max_h = max(max(corner(2,:)),h1);
min_h = min(min(corner(2,:)),1);

max_w = max(max(corner(1,:)),w1);
min_w = min(min(corner(1,:)),1);

out_w=1500;
s = (max_w - min_w)/(max_h - min_h);
out_h = ceil(out_w/s);
out_size =[out_h out_w];

s1 = out_w/(max_w - min_w);

scale_M = [s1 0 0; 0 s1 0; 0 0 1];
trans_M = [1 0 0; 0 1 -min_h; 0 0 1];
M = scale_M * trans_M;

warp_im1 = warpH(img1, M, out_size);
warp_im2 = warpH(img2, M*H2to1, out_size);

% -----------------------------------
      % remove white margin
      BW=double(rgb2gray(warp_im2));
      BW=BW./max(BW(:));
      idx=double(BW==1);
      para=ones(size(idx))-idx;

      r=double(warp_im2(:,:,1));
      r=r.*para;
      g=double(warp_im2(:,:,2));
      g=g.*para;
      b=double(warp_im2(:,:,3));
      b=b.*para;

      warp_im2(:,:,1)=r;
      warp_im2(:,:,2)=g;
      warp_im2(:,:,3)=b;
      
      BW1=double(rgb2gray(warp_im1));
      BW1=BW1./max(BW1(:));
      idx=double(BW1==1);
      para=ones(size(idx))-idx;

      r=double(warp_im1(:,:,1));
      r=r.*para;
      g=double(warp_im1(:,:,2));
      g=g.*para;
      b=double(warp_im1(:,:,3));
      b=b.*para;

      warp_im1(:,:,1)=r;
      warp_im1(:,:,2)=g;
      warp_im1(:,:,3)=b;
   

    panoImg=max(warp_im1,warp_im2);
    
    imshow(panoImg);

end