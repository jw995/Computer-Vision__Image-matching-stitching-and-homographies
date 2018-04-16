function [H2to1] = computeH(p1, p2)
% inputs:
% p1 and p2 should be 2 x N matrices of corresponding (x, y)' coordinates 
% between two images
%
% outputs:
% H2to1 - a 3 x 3 matrix encoding the homography that best matches 
% the linear equation

%%%

x1=p1(1,:)'; y1=p1(2,:)';
x2=p2(1,:)'; y2=p2(2,:)';
dim=length(x1);

A=[-x2 -y2 -ones(dim,1) zeros(dim,3) x2.*x1 y2.*x1 x1;...
     zeros(dim,3) -x2 -y2 -ones(dim,1) x2.*y1 y2.*y1 y1];
 
 [U,S,V] = svd(A);
 
% last column of V
h = V(:,size(V,2));
H=reshape(h,[3,3]);
 
H2to1=H';

end