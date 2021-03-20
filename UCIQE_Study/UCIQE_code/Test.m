clc;
close all;
clear all;
file_path1 ='D:\github\Image-quality-measure-method\groundtruth_test\5_img_.jpg' %groundtruth
file_path2 = 'D:\github\cv-paper-reproduction\water-net\sample1-90\5_img_.jpg'

uciqe0 = test_UCIQE2py(file_path1)
%ssim = test_SSIM2py(file_path1,file_path2)
img1 = imread(file_path1)
img2 = imread(file_path2)
[psnr,mse] = psnr(img1,img2)

disp(uciqe0)
