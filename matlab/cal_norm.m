function [p1_norm]=cal_norm(p1)

    mean_p1=mean(p1,2);

    dist1=sqrt((p1(1,:)-mean_p1(1,1)).^2+((p1(2,:)-mean_p1(2,1)).^2));
    scale1=max(dist1(:))/sqrt(2);
    p1_norm=p1./scale1+repmat(mean_p1,1,size(p1,2));
end