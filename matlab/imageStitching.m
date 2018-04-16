function [panoImg] = imageStitching(img1, img2, H2to1)
%
% input
% Warps img2 into img1 reference frame using the provided warpH() function
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear equation
%
% output
% Blends img1 and warped img2 and outputs the panorama image

%%%

% to make a bigger figure
padding = zeros(size(img1,1),120);
padding = repmat(padding,1,1,3);
img1 = [img1 padding];

    img1 = im2double(img1);

    warp_im = warpH(img2,double(H2to1),[size(img1,1),size(img1,2)]);
    warp_im = im2double(warp_im);
    
      BW=double(rgb2gray(warp_im));
      BW=BW./max(BW(:));
      idx=double(BW==1);
      para=ones(size(idx))-idx;

      r=double(warp_im(:,:,1));
      r=r.*para;
      g=double(warp_im(:,:,2));
      g=g.*para;
      b=double(warp_im(:,:,3));
      b=b.*para;

      warp_im(:,:,1)=r;
      warp_im(:,:,2)=g;
      warp_im(:,:,3)=b;
      
      BW1=double(rgb2gray(img1));
      BW1=BW1./max(BW1(:));
      idx=double(BW1==1);
      para=ones(size(idx))-idx;

      r=double(img1(:,:,1));
      r=r.*para;
      g=double(img1(:,:,2));
      g=g.*para;
      b=double(img1(:,:,3));
      b=b.*para;

      img1(:,:,1)=r;
      img1(:,:,2)=g;
      img1(:,:,3)=b;
   

    panoImg=max(img1,warp_im);
    
    figure;
    imshow(panoImg);

end