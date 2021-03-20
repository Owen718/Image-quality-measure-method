function [quality] = CCF(im)

%-------------CCF_colorfulness -----------------
    imColor = double(im);

    R = imColor(:,:,1);
    G = imColor(:,:,2);
    B = imColor(:,:,3);
    
    RR = log(R+0.00001) - mean2(log(R+0.00001));
    GG = log(G+0.00001) - mean2(log(G+0.00001));
    BB = log(B+0.00001) - mean2(log(B+0.00001));
    
    alpha = RR-GG;
    beta = 0.5*(RR+GG)-BB;
    
    mu_alpha=mean(mean(alpha));
    mu_beta=mean(mean(beta));
    var_alpha=var(var(alpha));
    var_beta=var(var(beta));

    CCF_colorfulness=1000*((sqrt(var_alpha+var_beta)+0.3*sqrt(mu_alpha*mu_alpha+mu_beta*mu_beta))/85.59);    
         
%-------------CCF_contrast----------------------

    im1=rgb2gray(im);
    CCF_contrast = CCFcontrast(im1);
    
%-------------CCF_FADE--------------------------

    CCF_FADE = FADE(im);

%------------ normalization ------------------

    CCF_colorfulness=mapminmax(CCF_colorfulness,1,10);
    CCF_contrast=mapminmax(CCF_contrast,1,10);
    CCF_FADE=10-mapminmax(CCF_FADE,1,10);
  
% ------------calculate image quality with coefficients---------------------

    c=[0.17593 0.61759 0.33988 ];
    quality = c(1)*(CCF_colorfulness) + c(2)*(CCF_contrast) + c(3)*(CCF_FADE)   
      
end

  


