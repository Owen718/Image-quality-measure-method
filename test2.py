import os
import numpy as np
import cv2


file_path = r'D:\github\Image-quality-measure-method\groundtruth_test'
file_list = os.listdir(file_path)  # file_path下的全部文件名列表


def cv_show(name,img):
    cv2.imshow(name,img)
    cv2.waitKey(0)
    cv2.destroyAllWindows()


for file_name in file_list:
    img_file_path = os.path.join(file_path,file_name)
    img = cv2.imread(img_file_path)

