
function [metric] = CCFcontrast(A)
T = 0.002;
A = double(A);
[m,n] = size(A);
rb = 64;
rc = 64;
count = 1;


for i=1:floor(m/rb)
    
    for j=1:floor(n/rc)
        
        row = rb*(i-1)+1:rb*i;
        col = rc*(j-1)+1:rc*j;
        A_temp = A(row,col);
        % check if block to be processed
        
        decision = get_edgeblocks_mod(A_temp,T);
        
        if (decision==1)
           contrast_JNB(count) = blkproc(A_temp,[rb rc],@get_contrast_block);%改为RMS计算方法
           count = count + 1;
        end
         
    end
end

blockrow = floor(m/rb);
blockcol = floor(n/rc);
L = blockrow*blockcol;
metric = (sum(contrast_JNB))/L;



%
function im_out = get_edgeblocks_mod(im_in,T)

im_in = double(im_in);

[im_in_edge,th] = edge(im_in,'canny');

[m,n] = size(im_in_edge);
L = m*n;
im_edge_pixels = sum(sum(im_in_edge));
im_out = im_edge_pixels > (L*T) ;

%
function contrast_wy = get_contrast_block(A)

[m,n] =size(A);
contrast_wy =sqrt(sum(sum((A-mean2(A)).^2)/(n*m)));


