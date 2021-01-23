import utils
import sys
import os

ref_path = r'D:\underwaterImageDateset\test-90\groundtruth_test' #参考图像目录
dist_path = r'D:\github\MSR-D-enhance-underwater-image\test90_FullA' #测试结果目录
algorithm_path = r'D:\github\MSR-D-enhance-underwater-image'
sys.path.append(algorithm_path)
import my_main


def main():
    ref_filelist = os.listdir(ref_path) #参考图像文件列表
    dist_filelist = os.listdir(dist_path) #测试图像文件列表
    my_main.run()






if __name__ == '__main__':
    main()
