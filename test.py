import numpy as np
import matlab.engine
import cv2


eng = matlab.engine.start_matlab()
path = r'D:\github\Image-quality-measure-method\UCIQE_Study\UCIQE_code\test.jpg'
uciqe = eng.test_UCIQE2py(path)

print(uciqe)