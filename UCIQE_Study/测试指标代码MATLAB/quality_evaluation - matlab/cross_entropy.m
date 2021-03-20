%求两图像的交叉熵

function f=cross_entropy(h1,h2)
%CERF return CERF(交叉熵)               求两图像的交叉熵
%input must be a imagehandle            输入图像句柄
%image fusion evaluate parameter        图像融合评价参数
%    example
%      标准图像   h1
%      融合后图像 h2
%      f=Hce(h1，h2);
%交叉熵越小，就表示图像间的差异越小
% h1=('jizheng.img');
% h2=('chengji.img');
s=size(size(h1));
if s(2)==3;%判断是灰度图还是RGB
f1=rgb2gray(h1);
f2=rgb2gray(h2);
else
    f1=h1;
    f2=h2;
end 
G1=double(f1);
G2=double(f2);
[m1,n1]=size(G1);
[m2,n2]=size(G2);
m2=m1;
n2=n1;
X1=zeros(1,256);
X2=zeros(1,256);
result=0;
%统计两图各灰度级像素
for i=1:m1
    for j=1:n1
        X1(G1(i,j)+1)=X1(G1(i,j)+1)+1;
        X2(G2(i,j)+1)=X2(G2(i,j)+1)+1;
    end
end
%计算两图各灰度级象素出现的概率
for k=1:256
    P1(k)=X1(k)/(m1*n1);
    P2(k)=X2(k)/(m1*n1);
    if((P1(k)~=0)&(P2(k)~=0))
        result=P1(k)*log2(P1(k)/P2(k))+result;
    end
end
f=result;

