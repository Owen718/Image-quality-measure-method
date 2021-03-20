clear;
rgb_in = imread('images.jpg');

rgb = double(rgb_in);
R = rgb(:,:,1);
G = rgb(:,:,2);
B = rgb(:,:,3);
mx=max(rgb,[],3);% max of the 3 colors
mn=min(rgb,[],3);% min of the 3 colors

alpha = 0.01 * (mn ./ mx);
gamma = 3;
Q = exp(alpha .* gamma);
% xyz = rgb2xyz(rgb);
% lab = xyz2lab(xyz);
% calculate Chroma
[l,a,b] = rgb2lab_n(rgb);
Chroma = sqrt(a.^2 + b.^2);
StdVarianceChroma = std(reshape(Chroma(:,:),[],1));

% calculate saturation
hsv = rgb2hsv(rgb);
Saturation = hsv(:,:,2);
MeanSaturation = mean(reshape(Saturation(:,:),[],1));

% calculate luminance
% Luminance = hsv(:,:,3);

ContrastLuminance = max(reshape(l(:,:),[],1)) - min(reshape(l(:,:),[],1));

UCIQE = 0.4680 * StdVarianceChroma + 0.2745 * ContrastLuminance + 0.2576 * MeanSaturation;
