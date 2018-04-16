function [H2to1] = computeH_norm(p1, p2)
% inputs:
% p1 and p2 should be 2 x N matrices of corresponding (x, y)' coordinates between two images
%
% outputs:
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear equation

%%%
N=size(p1,2); 
mean_p1=mean(p1,2);
mean_p2=mean(p2,2);

dist1=sqrt(sum((p1-mean_p1).^2));
scale1=sqrt(2)./max(dist1(:));
shift1=mean_p1.*(-scale1);

p11=[p1;ones(1,N)];
T1=[scale1 0 shift1(1,1); 
     0 scale1 shift1(2,1);
     0 0 1];
p1_norm=T1*p11;
p1_norm(3,:)=[];

dist2=sqrt(sum((p2-mean_p2).^2));
scale2=sqrt(2)./max(dist2(:));
shift2=mean_p2.*(-scale2);

p21=[p2;ones(1,N)];
T2=[scale2 0 shift2(1,1); 
     0 scale2 shift2(2,1);
     0 0 1];
p2_norm=T2*p21;
p2_norm(3,:)=[];

[H2to1] = computeH(p1_norm, p2_norm);

[H2to1]=inv(T1)*H2to1*T2;

end