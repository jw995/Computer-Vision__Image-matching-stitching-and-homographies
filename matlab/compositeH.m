function [ composite_img ] = compositeH( H2to1, template, img)

  im0= double(rgb2gray(template));
  im0=im0/max(im0(:));

  warp_im = warpH(img, double(H2to1), size(im0),0);
  BW=double(rgb2gray(warp_im));
  BW=BW./max(BW(:));
  idx=double(BW<0.1);
  
  r=double(template(:,:,1));
  r=r.*idx;
  g=double(template(:,:,2));
  g=g.*idx;
  b=double(template(:,:,3));
  b=b.*idx;
  
  template(:,:,1)=r;
  template(:,:,2)=g;
  template(:,:,3)=b;
   
  composite_img=max(template,warp_im);
  
end