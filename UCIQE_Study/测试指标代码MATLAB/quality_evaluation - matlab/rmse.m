function rmse = rmse(imgfusion,imgstandard) 
[m n]=size(imgfusion);
temp=sqrt(sum(sum((imgfusion-imgstandard).^2)));
rmse=temp/(m*n);

