function [mpcqi, pcqi_map]= PCQI1(img1, img2, window, L)
%========================================================================
%PCQI Index, Version 1.0, Sep. 2015
%
%This is an implementation of the algorithm for calculating the patch-based contrast 
%quality index (PCQI) between two images. Please refer to the following paper:
%
%S. Wang, K. Ma, H. Yeganeh, Z. Wang and W. Lin, A Patch-Structure Representation 
%Method for Quality Assessment of Contrast Changed Images, IEEE Signal Processing
%Letter, 2015. 
%
%Kindly report any suggestions or corrections to sqwang1986@gmail.com
%
%----------------------------------------------------------------------
%
%Input : (1) img1: the first image being compared
%        (2) img2: the second image being compared
%        (4) window: local window for statistics (see the above
%            reference). default widnow is Gaussian given by
%            window = fspecial('gaussian', 11, 1.5);
%        (5) L: dynamic range of the images. default: L = 256
%
%Output: (1) mpcqi   : the mean PCQI index value between 2 images.
%        (2) pcqi_map: the PCQI map of the test image. 
%Default Usage:
%   Given 2 test images img1 and img2, whose dynamic range is 0-255
%   [mpcqi pcqi_map] = PCQI(img1, img2);
%
%Advanced Usage:
%   User defined parameters. For example 
%   window = ones(8);
%   L = 100;
%   [mpcqi pcqi_map] = PCQI(img1, img2, window, L);
%========================================================================
img1 = double(img1);
img2 = double(img2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (nargin < 2 || nargin > 4)
   mpcqi = -Inf;
   pcqi_map = -Inf;
   return;
end

if (size(img1) ~= size(img2))
   mpcqi = -Inf;
   pcqi_map = -Inf;
   return;
end

[M N] = size(img1);

if (nargin == 2)
   if ((M < 11) || (N < 11))
	   mpcqi    = -Inf;
	   pcqi_map = -Inf;
      return
   end
   window = fspecial('gaussian', 11, 1.5);	%
   L = 256;                                 %
end

if (nargin == 3)
   [H W] = size(window);
   if ((H*W) < 4 || (H > M) || (W > N))
	   mpcqi = -Inf;
	   pcqi_map = -Inf;
      return
   end
   L = 255;
end

if (nargin == 4)
   [H W] = size(window);
   if ((H*W) < 4 || (H > M) || (W > N))
	   mpcqi = -Inf;
	   pcqi_map = -Inf;
      return
   end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
window = window/sum(sum(window));
   
mu1    = filter2(window, img1, 'valid');
mu2    = filter2(window, img2, 'valid');
mu1_sq = mu1.*mu1;
mu2_sq = mu2.*mu2;
mu1_mu2 = mu1.*mu2;
sigma1_sq = filter2(window, img1.*img1, 'valid') - mu1_sq;
sigma2_sq = filter2(window, img2.*img2, 'valid') - mu2_sq;
sigma12   = filter2(window, img1.*img2, 'valid') - mu1_mu2;

      
sigma1_sq = max(0, sigma1_sq);
sigma2_sq = max(0, sigma2_sq);
 
C=3;

pcqi_map  =   (4/pi) *atan((sigma12 + C )./(sigma1_sq + C ));
pcqi_map  =   pcqi_map .*((sigma12 + C)    ./(sqrt(sigma1_sq).*sqrt(sigma2_sq) + C));
pcqi_map  =   pcqi_map .*exp(-abs(mu1-mu2)/L);

mpcqi     = mean2(pcqi_map);

return
