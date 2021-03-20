import psnr
import ssim
import os
import sys
import cv2
import scipy.misc
import numpy
import uqim_utils
import numpy as np
import matlab.engine
import cv2
import imgqual_utils
from PIL import Image

#author：yetian
#time：2020/12/7

# ref_file = r'sample1.jpg'
# dist_file = r'sample1_tmp.jpg'

#ref_path = r'D:\underwaterImageDateset\reference-890' #参考图像目录
#ref_path =r'D:\github\Image-quality-measure-method\groundtruth_test'
#ref_path = r'D:\underwaterImageDateset\underwater_imagenet_UGAN\underwater_imagenet\trainB'
#dist_path =r'D:\python_code\Single-Underwater-Image-Enhancement-and-Color-Restoration-master\Underwater Image Color Restoration\UDCP\OutputImages' #测试图像目录
#dist_path = r'D:\python_code\Single-Underwater-Image-Enhancement-and-Color-Restoration-master\Underwater-Image-Enhancement-based-on-Fusion-Python-main\OutputImages'
#dist_path = r'D:\github\cv-paper-reproduction\UDCP-RAW890results'
#dist_path = r'D:\underwaterImageDateset\newtest90_FullA'
#dist_path =r'D:\github\Underwater-ColorRestoration-study\RGB_CC2_results'
#dist_path = r'D:\github\MSR-D-enhance-underwater-image\test90_FullA'
#dist_path = r'D:\underwaterImageDateset\underwater-test-dataset-U45-\upload\CycleGAN'
#dist_path = r'D:\underwaterImageDateset\underwater-test-dataset-U45-\upload\WSCT'
#dist_path = r'D:\underwaterImageDateset\underwater-test-dataset-U45-\upload\OURS'
#dist_path = r'D:\underwaterImageDateset\underwater-test-dataset-U45-\upload\OURS3-CCu'
dist_path = r'D:\underwaterImageDateset\underwater-test-dataset-U45-\upload\OURS_NEW'
#dist_path = r'D:\github\MSR-D-enhance-underwater-image\OUR-dataset-result'
#dist_path = r'D:\github\MSR-D-enhance-underwater-image\OUR-dataset-Fusion'
#dist_path = r'D:\github\MSR-D-enhance-underwater-image\OUR-RAW890dataset_results'
#dist_path = r'D:\underwaterImageDateset\underwater-test-dataset-U45-\upload\FUSION'
#dist_path = r'D:\underwaterImageDateset\underwater_imagenet_UGAN\underwater_imagenet\OURS'
#dist_path = r'D:\github\cv-paper-reproduction\water-net\sample'
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


dist_filelist = os.listdir(dist_path) #测试图像文件列表

save_file ='RAW890_OURSdataset_fusion_2021_2_17.txt'
save_file = 'U45_OURS_2021_3_3.txt'
#save_file = 'U_45_'+dist_path.split('\\')[-1]+'2021_2_16.txt'
#save_file = 'U45_CycleGAN_2021_2_11.txt'  
#save_file = r'water-net_2021_1_2_11.txt'

uciqe_list = []

eng = matlab.engine.start_matlab()
for dist_file in dist_filelist: #遍历
    dist_file_dir = os.path.join(dist_path,dist_file) #文件绝对路径
    
    if os.path.isdir(dist_file_dir): #如果是文件夹，跳过
        continue 



    uciqe_data = eng.test_UCIQE2py(dist_file_dir)
    
    filename = dist_file
    print("img:" + str(filename)+" UCIQE:"+str(uciqe_data))
    data = str(filename)+" UCIQE:"+str(uciqe_data)
    

    uciqe_list.append(uciqe_data)


    average = " UCIQE average:"+str(sum(uciqe_list)/len(uciqe_list)) 
    print(average)
    if uciqe_data>0.65:
        with open(save_file,"a") as file:
            file.write(data + " "+average +'\n')