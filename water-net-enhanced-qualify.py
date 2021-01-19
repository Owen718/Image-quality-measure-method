import psnr
import ssim
import os
import sys
import cv2
import scipy.misc
import numpy
import uqim_utils

#author：yetian
#time：2020/12/7

# ref_file = r'sample1.jpg'
# dist_file = r'sample1_tmp.jpg'

ref_path = r'D:\underwaterImageDateset\test-90\groundtruth_test' #参考图像目录

#dist_path =r'D:\python_code\Single-Underwater-Image-Enhancement-and-Color-Restoration-master\Underwater Image Color Restoration\UDCP\OutputImages' #测试图像目录
#dist_path = r'D:\python_code\Single-Underwater-Image-Enhancement-and-Color-Restoration-master\Underwater-Image-Enhancement-based-on-Fusion-Python-main\OutputImages'
#dist_path = r'D:\water-net-result\sample'
dist_path = r'D:\github\MSR-D-enhance-underwater-image\test90_FullA'

def cv_show(img,name):
    cv2.imshow(img,name)
    cv2.waitKey(0)
    cv2.destroyAllWindows()

ref_filelist = os.listdir(ref_path) #参考图像文件列表
dist_filelist = os.listdir(dist_path) #测试图像文件列表

save_file = 'OURS1_test90_2020_1_20_2.txt'
psnr_list=[]
ssim_list=[]
uiqm_list=[]

for dist_file in dist_filelist: #遍历
    dist_file_dir = os.path.join(dist_path,dist_file) #参考文件绝对路径
    
    if os.path.isdir(dist_file_dir): #如果是文件夹，跳过
        continue 

    dist_img = scipy.misc.imread(dist_file_dir, flatten=True).astype(numpy.float32)
    
    #filename = os.path.splitext(dist_file)[0] + os.path.splitext(dist_file)[1]  #ref filename
    filename = os.path.splitext(dist_file)[0] + '.jpg'  #ref filename
    
    ref_img = scipy.misc.imread(ref_path + '\\' + filename ,flatten=True).astype(numpy.float32) #读取参考图像对应的测试图像

    psnr_data = psnr.psnr(ref_img,dist_img) #psnr指标
    ssim_data = ssim.ssim_exact(ref_img/255,dist_img/255) #ssim指标
    
    dist_img = cv2.imread(dist_path + '\\' + os.path.splitext(dist_file)[0]+'.jpg') #UIQM指标
    uiqm_data = uqim_utils.getUIQM(dist_img) #UIQM

    print("img:" + str(filename)+" psnr:" + str(psnr_data) + " ssim:"+str(ssim_data)+ " UIQM:" + str(uiqm_data))
    data = str(filename)+" psnr:" + str(psnr_data) + " ssim:"+str(ssim_data)+ " UIQM:" + str(uiqm_data)
    
    psnr_list.append(psnr_data)
    ssim_list.append(ssim_data)
    uiqm_list.append(uiqm_data)

    average = "psnr_average:" + str(sum(psnr_list) / len(psnr_list)) + " ssim_average:" + str(sum(ssim_list)/len(ssim_list))+ " UIQM:"+ str(sum(uiqm_list)/len(uiqm_list))
    print(average)

    with open(save_file,"a") as file:
        file.write(data + " "+average +'\n')