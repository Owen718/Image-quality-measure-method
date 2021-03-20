function G=figure_definition(X)
%X=imread('SIDWT with Haar.bmp');
% X=X(1:128,1:128);
% X=image2;
X=double(X);
%%%%%%%%
[s,t]=size(X);
n=s*t;
m=1;
for i=1:(s-1)
    for j=1:(t-1)
        x=X(i,j)-X(i,j+1);
        y=X(i,j)-X(i+1,j);
        z(m,1)=sqrt((x.^2+y.^2)/2);
        m=m+1;
    end
end
G=sum(z)/n;                                    %计算融合后图像清晰度 G；