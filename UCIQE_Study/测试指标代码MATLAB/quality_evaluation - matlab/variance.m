function S = variance(img) 
    i=rgb2gray(img);
    i = double(i);
    [m, n] = size(i);
    s = 0;
    for x = 1:m
        for y = 1:n
            s = s + i(x, y);
        end
    end
    
    S = mean2(s);   
end
