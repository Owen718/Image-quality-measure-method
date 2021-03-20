% 23/02/2011
% IFSTTAR copyright
%
% The approach is described in details in 
%
% "Blind Contrast Restoration Assessment by Gradient Ratioing at Visible Edges",
% by N. Hautiere, J.-P. Tarel, D. Aubert and E. Dumont,
% in proceedings of International Congress for Stereology (ICS'07), 
% Saint Etienne, France, August 30-September 7, 2007.
% http://perso.lcpc.fr/tarel.jean-philippe/publis/ics07.html
%

%%%% Images reading: the input 2 images must be grayscale

function result = EvaluationDescriptorCalculation(I1,R1)

I1=double(I1);
% if the input image is a color image, use following line
I1=double(rgb2gray(uint8(I1)));
[nl,nc]=size(I1);

R1=double(R1);
% if the input image is a color image, use following line
R1=double(rgb2gray(uint8(R1)));


%%%% Sobel Gradient
Sy = double([1 2 1;0 0 0;-1 -2 -1]);
GIy = imfilter(I1,Sy,'symmetric');
GRy1 = imfilter(R1,Sy,'symmetric');

Sx = double([1 0 -1; 2 0 -2; 1 0 -1]);
GIx = imfilter(I1,Sx,'symmetric');
GRx1 = imfilter(R1,Sx,'symmetric');

GI=sqrt((GIx.^2)+(GIy.^2));
GR1=sqrt((GRx1.^2)+(GRy1.^2));

minGI=min(GI(:));
maxGI=max(GI(:));



%%%% Contrast Computation at 5%

[C1 Crr1]=functionContrastAt5PerCent(R1);
[Ci Crri]=functionContrastAt5PerCent(I1);


minCrri=min(Crri(:));
maxCrri=max(Crri(:));



%%%% Visible Gradients Ratio
Cratio1=zeros(nl,nc);
Cratio1(Crr1>0)=GR1(Crr1>0)./GI(Crr1>0);

rmin=1;
rmax=10;


%%%% Descriptor computation

% Rate of new visible edges
whitePixels1=sum(C1(:));
whitePixelsi=sum(Ci(:));
e1=(whitePixels1-whitePixelsi)/whitePixelsi;

% Number of saturated pixels after restoration
ns1=sum(R1(:)==256 |R1(:)==0);
ns1=ns1/(nl*nc);

% Restoration quality (geometric mean ratios of visibility level)
XX=log(Cratio1);
r1=exp((1/(whitePixels1))*nansum(XX(isfinite(XX))));


result = [e1,ns1,r1];


end
