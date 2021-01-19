import cv2
import uqim_utils
#img_path = r'D:\github\MSR-D-enhance-underwater-image\InputImages\2 Original Image.jpg'
img_path =r'D:\github\MSR-D-enhance-underwater-image\OutputImages\MSRCR\2 Original Image.jpg'
original = cv2.imread(img_path)
UQIM_value = uqim_utils.getUIQM(original)
print(round(UQIM_value,6))


