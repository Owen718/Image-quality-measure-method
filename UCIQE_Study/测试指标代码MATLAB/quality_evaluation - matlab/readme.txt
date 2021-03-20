这些有从网上找的，有是自己写的，可能也有错误，大叫交流吧
data.M1,data.M2分别为融合前的两个图像，data.F为融合后的图像

    avg=num2str(avg_gradient(data.F));%平均梯度
    ein=num2str(edge_intensity(data.F));%边缘强度
    sha=num2str(shannon(data.F));%信息熵
    [img_mean,img_var]=variance(data.F);%灰度均值，标准差(均方差MSE)
    gray_mean=num2str(img_mean);
    vari=num2str(img_var);
    rms=num2str(rmse(data.F,data.M1));%均方根误差
    psnrvalue=num2str(psnr(data.M1,data.F));%峰值信噪比
    sf=num2str(space_frequency(data.F));%空间频率
    fd=num2str(figure_definition(data.F));%图像清晰度
    mi1=mutinf(data.M1,data.F);%互信息
    mi2=mutinf(data.M2,data.F);
    mi=num2str(mi1+mi2);
    [mssim, ssim_map] = ssim(data.M1,data.F);%结构相似性
    ssi=num2str(mssim);
    cross_entro=num2str(cross_entropy(data.M1,data.M2));%交叉熵，应该使用标准图像&融合后图像
    rw=num2str(relatively_warp(data.M1,data.F));%相对标准差，应该使用标准图像&融合后图像
    EvaluationDescriptorCalculation(original,final);%% 23/02/2011
        % IFSTTAR copyright
        %
        % The approach is described in details in 
        %
        % "Blind Contrast Restoration Assessment by Gradient Ratioing at Visible Edges",
        % by N. Hautiere, J.-P. Tarel, D. Aubert and E. Dumont,
        % in proceedings of International Congress for Stereology (ICS'07), 
        % Saint Etienne, France, August 30-September 7, 2007.
        % http://perso.lcpc.fr/tarel.jean-philippe/publis/ics07.html
