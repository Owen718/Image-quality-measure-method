function result_epi=myEpi(img_before,img_after)
% 计算一副图像的边缘保护指数EPI(Edge Protect Index),EPI越接近1，说明算法的边缘保持能力越强。
% img_before表示原始图像(这里考虑标准图像，其他的话也可以考虑一下去噪前的图像，C实现的时候，考虑到平台需求，用的是去噪前的图像)
% img_after表示去噪后的图像
img_before=double(img_before);
img_after=double(img_after);
[height,width]=size(img_before);
sum1=0;
sum2=0;
%去噪前
for i=1:height   %水平
    for j=1:width-1
        sum1=sum1+abs(img_before(i,j)-img_before(i,j+1));
    end
end
for i=1:height-1  %垂直
    for j=1:width
        sum1=sum1+abs(img_before(i,j)-img_before(i+1,j));
    end
end
%去噪后
for i=1:height  %水平
    for j=1:width-1
        sum2=sum2+abs(img_after(i,j)-img_after(i,j+1));
    end
end
for i=1:height-1  %垂直
    for j=1:width
        sum2=sum2+abs(img_after(i,j)-img_after(i+1,j));
    end
end
sum1=double(sum1);
sum2=double(sum2);
result_epi=sum2/sum1;
