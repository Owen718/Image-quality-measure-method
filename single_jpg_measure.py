import cv2
import uqim_utils

#img_path = r'D:\github\cv-paper-reproduction\PSNR_test\An Underwater Image Enhancement Benchmark Dataset and Beyond\result\4 Original Image.jpg'
#img_path = r'D:\github\cv-paper-reproduction\PSNR_test\InputImages\real1.jpg'
img_path = r'D:\github\video-quality\102_img_.png'
original = cv2.imread(img_path)
UQIM_value = uqim_utils.getUIQM(original)
print(round(UQIM_value,3))


