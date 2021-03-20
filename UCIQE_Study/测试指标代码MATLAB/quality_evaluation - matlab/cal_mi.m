close all
clc
clear

a = rgb2gray(imread('t1raw.jpg'));
b = rgb2gray(imread('t1.jpg'));
mi = mutinf(a, b);