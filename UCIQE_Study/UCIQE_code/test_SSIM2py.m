function ssim_result=test_UCIQE2py(file_path1,file_path2)
    img1=imread(file_path1);
    img2=imread(file_path2);
    ssim_result = SSIM(img1,img2)
end

