import psnr
import ssim
import os
import sys
import cv2
import scipy.misc
import uqim_utils
import numpy as np
#import matlab.engine
import cv2
import imgqual_utils
from PIL import Image

#author：yetian
#time：2020/12/7

# ref_file = r'sample1.jpg'
# dist_file = r'sample1_tmp.jpg'

#ref_path = r'D:\underwaterImageDateset\reference-890' #参考图像目录
ref_path =r'D:\github\Image-quality-measure-method\groundtruth_test'
#ref_path = r'D:\underwaterImageDateset\underwater_imagenet_UGAN\underwater_imagenet\trainB'
#dist_path =r'D:\python_code\Single-Underwater-Image-Enhancement-and-Color-Restoration-master\Underwater Image Color Restoration\UDCP\OutputImages' #测试图像目录
#dist_path = r'D:\python_code\Single-Underwater-Image-Enhancement-and-Color-Restoration-master\Underwater-Image-Enhancement-based-on-Fusion-Python-main\OutputImages'
#dist_path = r'D:\github\cv-paper-reproduction\UDCP-RAW890results'
#dist_path = r'D:\underwaterImageDateset\newtest90_FullA'
#dist_path =r'D:\github\Underwater-ColorRestoration-study\RGB_CC2_results'
dist_path = r'D:\github\MSR-D-enhance-underwater-image\test90_FullA' 
dist_path = r'D:\github\PyTorch-Image-Dehazing\results'
#dist_path = r'D:\underwaterImageDateset\water-net-test90\sample'
#dist_path = r'D:\github\MSR-D-enhance-underwater-image\OUR-RAW890dataset_results'
#dist_path = r'D:\underwaterImageDateset\underwater_imagenet_UGAN\underwater_imagenet\OURS'
#dist_path = r'D:\github\cv-paper-reproduction\water-net\sample1-90'
#dist_path = r'D:\underwaterImageDateset\test-90Fusion'
#dist_path =r'D:\github\Over-all-New-underwater-enhancement\Cc_test90'
#dist_path = r'D:\github\cv-paper-reproduction\fusion-optimization\Underwater-Image-Enhancement-based-on-Fusion-Python-main\test90_results' 
#dist_path =r'D:\python_code\Single-Underwater-Image-Enhancement-and-Color-Restoration-master\Underwater Image Color Restoration\UDCP\OutputImages'
#dist_path  = r'D:\python_code\Single-Underwater-Image-Enhancement-and-Color-Restoration-master\Underwater Image Color Restoration\DCP\OutputImages'
#dist_path =r'D:\python_code\Single-Underwater-Image-Enhancement-and-Color-Restoration-master\Underwater Image Enhancement\CLAHE\OutputImages'
#dist_path = r'D:\python_code\Single-Underwater-Image-Enhancement-and-Color-Restoration-master\Underwater Image Enhancement\HE\OutputImages'
def cv_show(img,name):
    cv2.imshow(img,name)
    cv2.waitKey(0)
    cv2.destroyAllWindows()

ref_filelist = os.listdir(ref_path) #参考图像文件列表
dist_filelist = os.listdir(dist_path) #测试图像文件列表

save_file = 'OURS_test90_2021_3_6.txt'  
#save_file = r'water-net_2021_1_2_11.txt'
psnr_list=[]
ssim_list=[]
uiqm_list=[]
uciqe_list = []
mse_list = []
#eng = matlab.engine.start_matlab()
for dist_file in dist_filelist: #遍历
    dist_file_dir = os.path.join(dist_path,dist_file) #文件绝对路径
    
    if os.path.isdir(dist_file_dir): #如果是文件夹，跳过
        continue 

    dist_img = Image.open(dist_file_dir)
    #dist_img = cv2.imread(dist_file_dir)
    dist_img = np.float32(dist_img)
    filename = os.path.splitext(dist_file)[0] + '.jpg'  #ref filename
    ref_img = Image.open(ref_path + '\\' + filename)
    #ref_img = cv2.imread(ref_path+'\\'+filename)
    ref_img = np.float32(ref_img)
 
    psnr_data = imgqual_utils.getPSNR(np.uint8(dist_img),np.uint8(ref_img))
    ssim_data = imgqual_utils.getSSIM(dist_img,ref_img)
    #psnr_data = psnr.psnr(ref_img,dist_img) #psnr指标
    #ssim_data = ssim.ssim_exact(ref_img/255,dist_img/255) #ssim指标
    #uciqe_data = eng.test_UCIQE2py(dist_file_dir)
    uciqe_data = 0
    #mse_data = psnr.MSE(ref_img,dist_img) #MSE指标
    print("img:" + str(filename)+" psnr:" + str(psnr_data) + " ssim:"+str(ssim_data)+" UCIQE:"+str(uciqe_data))
    data = str(filename)+" psnr:" + str(psnr_data) + " ssim:"+str(ssim_data) + " UCIQE:"+str(uciqe_data)
    
    psnr_list.append(psnr_data)
    ssim_list.append(ssim_data)
    #uiqm_list.append(uiqm_data)
    uciqe_list.append(uciqe_data)
    #mse_list.append(mse_data/1000)

    average = "psnr_average:" + str(sum(psnr_list) / len(psnr_list)) + " ssim_average:" + str(sum(ssim_list)/len(ssim_list))+" UCIQE:"+str(sum(uciqe_list)/len(uciqe_list)) # " MSE:"+str(sum(mse_list)/len(mse_list))
    print(average)

    with open(save_file,"a") as file:
        file.write(data + " "+average +'\n')