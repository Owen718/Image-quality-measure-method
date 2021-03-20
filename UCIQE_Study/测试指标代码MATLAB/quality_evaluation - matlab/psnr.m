function [PSNR, MSE] = psnr(X, Y)
    % 计算峰值信噪比PSNR、均方根误差MSE
    % 如果输入Y为空，则视为X与其本身来计算PSNR、MSE

    if nargin<2
        D = X;
    else
        if any(size(X)~=size(Y))
            error('The input size is not equal to each other!');
        end
        D = X-Y;
    end
    MSE = sum(D(:).*D(:))/numel(X);
    PSNR = 10*log10(255^2/MSE);
%     display(MSE);
%     display(PSNR);
end