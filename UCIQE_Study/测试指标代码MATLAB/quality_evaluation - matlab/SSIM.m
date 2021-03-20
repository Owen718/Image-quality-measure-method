function [mssim, ssim_map] = SSIM(img1, img2)

    window = fspecial('gaussian', 11, 1.5);	%window ¼Ó´°
    K(1) = 0.01;					
    K(2) = 0.03;					
    L = 255;  
    C1 = (K(1)*L)^2;
    C2 = (K(2)*L)^2;
    window = window/sum(sum(window));
    img1 = double(img1);
    img2 = double(img2);

    mu1   = filter2(window, img1, 'valid');
    mu2   = filter2(window, img2, 'valid');
    mu1_sq = mu1.*mu1;
    mu2_sq = mu2.*mu2;
    mu1_mu2 = mu1.*mu2;
    sigma1_sq = filter2(window, img1.*img1, 'valid') - mu1_sq;
    sigma2_sq = filter2(window, img2.*img2, 'valid') - mu2_sq;
    sigma12 = filter2(window, img1.*img2, 'valid') - mu1_mu2;

    if (C1 > 0 & C2 > 0)
       ssim_map = ((2*mu1_mu2 + C1).*(2*sigma12 + C2))./((mu1_sq + mu2_sq + C1).*(sigma1_sq + sigma2_sq + C2));
    else
       numerator1 = 2*mu1_mu2 + C1;
       numerator2 = 2*sigma12 + C2;
       denominator1 = mu1_sq + mu2_sq + C1;
       denominator2 = sigma1_sq + sigma2_sq + C2;
       ssim_map = ones(size(mu1));
       index = (denominator1.*denominator2 > 0);
       ssim_map(index) = (numerator1(index).*numerator2(index))./(denominator1(index).*denominator2(index));
       index = (denominator1 ~= 0) & (denominator2 == 0);
       ssim_map(index) = numerator1(index)./denominator1(index);
    end

    mssim = mean2(ssim_map);
%     display(mssim);
end
