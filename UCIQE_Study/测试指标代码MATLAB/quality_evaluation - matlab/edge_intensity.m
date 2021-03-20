function outval = edge_intensity(img) 
% OUTVAL = EDGE_INTENSITY(IMG) 
 
if nargin == 1 
    img = double(img); 
    % Create horizontal sobel matrix 
    w = fspecial('sobel'); 
     
    % Get the size of img 
    [r c k] = size(img); 
     
    gx = imfilter(img,w,'replicate'); 
    gy = imfilter(img,w','replicate'); 
     
    for m = 1 : r 
        for n = 1 : c 
            for q = 1 : k 
                g(m,n,q) = sqrt(gx(m,n,q)*gx(m,n,q) + gy(m,n,q)*gy(m,n,q)); 
            end 
        end 
    end 
    outval = mean(mean(mean(g))); 
else 
    error('Wrong number of input!'); 
end 