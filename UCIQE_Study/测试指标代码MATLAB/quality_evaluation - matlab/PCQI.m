function mpcqi= PCQI(img1, img2)



%     [mpcqi1(1),~]=PCQI1(img1(:, :, 1),img2(:, :, 1), window, L);
%     [mpcqi2(1),~]=PCQI1(img1(:, :, 2),img2(:, :, 2), window, L);
%     [mpcqi3(1),~]=PCQI1(img1(:, :, 3),img2(:, :, 3), window, L);
% 
%     mpcqi = mpcqi1(1) + mpcqi2(1) + mpcqi3(1);
%     mpcqi = mpcqi / 3;

im1=double(rgb2gray(img1));
im2=double(rgb2gray(img2));


[mpcqi,~]=PCQI1(im1,im2);
return

     
