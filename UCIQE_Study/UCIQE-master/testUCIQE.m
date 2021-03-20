imagepath_icra2017 = '/home/uav/Desktop/Underwater_Image_Enhancing/flicker/icra_2017/'
imagepath_original = '/home/uav/Desktop/Underwater_Image_Enhancing/flicker/HQ_rename_resized/'
imagepath_icra2018 = '/home/uav/Desktop/Underwater_Image_Enhancing/flicker/icra_2018/'
imagepath_outputs = '/home/uav/Desktop/Underwater_Image_Enhancing/flicker/outputs/'
imagepath_ugan = '/home/uav/Desktop/Underwater_Image_Enhancing/flicker/ugan/'

icra2017=[];
icra2018=[];
original=[];
outputs=[];
ugan=[];

for i = 0:85
    filename = sprintf('%06d', i);
    img = imread([imagepath_icra2017, filename, '.jpg']);
    uciqe = UCIQE(img);
    icra2017=[icra2017,uciqe];
    img = imread([imagepath_icra2018, filename, '.jpg']);
    uciqe = UCIQE(img);
    icra2018=[icra2018,uciqe];
    img = imread([imagepath_original, filename, '.jpg']);
    uciqe = UCIQE(img);
    original=[original,uciqe];
    img = imread([imagepath_outputs, filename, '.jpg']);
    uciqe = UCIQE(img);
    outputs=[outputs,uciqe];
    img = imread([imagepath_ugan, filename, '.jpg']);
    uciqe = UCIQE(img);
    ugan=[ugan,uciqe];
end

icra2017mean = mean(icra2017);
icra2018mean = mean(icra2018);
originalmean = mean(original);
uganmean = mean(ugan);
outputsmean = mean(outputs);
figure(1)
plot(original);
hold on
plot(icra2017);
hold on
plot(icra2018);
hold on
plot(ugan)
hold on
plot(outputs,'LineWidth',2);
title('UCIQE')
legend('inputs','icra2017','icra2018','ugan','outputs')
figure(2)
c = categorical({'inputs','icra2017','icra2018','ugan','outputs'})
bar(c, [originalmean,icra2017mean,icra2018mean,uganmean,outputsmean],'BarWidth',0.1);
title('UCIQE-mean')
figure(3)
plot(original);
hold on
plot(outputs);
title('UCIQE')
legend('inputs','outputs')