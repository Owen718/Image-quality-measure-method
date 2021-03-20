import numpy as np
import cv2

def UCIQE(img):
    hsv = cv2.cvtColor(img,cv2.COLOR_RGB2HSV)

    H,S,V = cv2.split(hsv)
    delta = np.std(H) #色度的标准方差
    mu = np.mean(S) #饱和度平均值
    n,m = img.shape[0:2]
    number = int(n*m/100)
    Maxsum = 0
    Minsum = 0
    V1 = V
    V2 = V
    for i in range(number): #最大像素值，前1/100
        Maxvaule = np.max(np.max(V1))
        [x,y] = np.where(V1 == Maxvaule)
        Maxsum = Maxsum + V1[x[0],y[0]]
        V1[x[0],y[0]] = 0 #最大值赋0
    
    top = Maxsum / number

    for i in range(number): #最小像素值，前1/100
        Minvaule = np.min(np.min(V2))
        [x,y] = np.where(V2 == Minvaule)
        Minsum = Minsum + V2[x[0],y[0]]
        V2[x[0],y[0]] = 1 #最小值赋1
    
    buttom = Minsum / number #平均
    conl = top - buttom 

    uciqe = 0.4680 * delta + 0.2745 * conl + 0.2576 * mu

    return uciqe