pkg load image

clear all
close all

soja = imread('./soja.jpg');
figure(1);
imshow(soja);

sojaBW = rgb2gray(soja);
figure(2);
imshow(sojaBW);

figure(3);
imhist(sojaBW);

mask = uint8(zeros(size(soja, 1), size(soja, 2)));
mask(:,:) = 255;

mask(sojaBW > 100) = 0;

figure(4);
imshow(mask);

maskedSoja = uint8(zeros(size(mask, 1), size(mask, 2), 3));

sojaAux1 = uint8(zeros(size(mask, 1), size(mask, 2)));
sojaAux2 = uint8(zeros(size(mask, 1), size(mask, 2)));
sojaAux3 = uint8(zeros(size(mask, 1), size(mask, 2)));

sojaAux1(:,:) = sojaAux2(:,:) = sojaAux3(:,:) = 255;

sojaR = soja(:,:,1);
sojaG = soja(:,:,2);
sojaB = soja(:,:,3);

sojaAux1(mask == 0) = sojaR(mask == 0);
sojaAux2(mask == 0) = sojaG(mask == 0);
sojaAux3(mask == 0) = sojaB(mask == 0);

maskedSoja(:,:,1) = sojaAux1(:,:);
maskedSoja(:,:,2) = sojaAux2(:,:);
maskedSoja(:,:,3) = sojaAux3(:,:);

figure(5);
imshow(maskedSoja);