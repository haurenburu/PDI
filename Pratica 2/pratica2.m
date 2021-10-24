clear;
close;
# 1 Ler a imagem rgb.jpg na variável im (Imagem1), mostrando em uma janela com o título “Imagem original: RGB;
im = imread("rgb.jpg");

figure("name","Imagem Original: RGB");
imshow(im);

# 2 Aplicar a segmentação por cor, gerando as imagens 2, 3 e 4;
# image 2 (YELLOW)

im2 = im;
im2(:,:,:) = 255;

for i=1:size(im, 1)
  for j=1:size(im, 1)
    if((im(i,j,1)>126)&&(im(i,j,2)>126)&&(im(i,j,3)<126))
      im2(i,j,:) = im(i,j,:);
    end
  end
end
figure("name", "Imagem 2: Y");
imshow(im2);

# image 3 (GREEN)

im3 = im;
im3(:,:,:) = 255;

for i=1:size(im, 1)
  for j=1:size(im, 1)
    if((im(i,j,1)<90)&&(im(i,j,2)>90)&&(im(i,j,3)<90))
      im3(i,j,:) = im(i,j,:);
    end
  end
end

figure("name", "Imagem 3: G");
imshow(im3);

# image 4 (RED)
im4 = im;
im4(:,:,:) = 255;

for i=1:size(im, 1)
  for j=1:size(im, 1)
    if((im(i,j,1)>126)&&(im(i,j,2)<126)&&(im(i,j,3)<126))
      im4(i,j,:) = im(i,j,:);
    end
  end
end

figure("name", "Imagem 4: R");
imshow(im4);

# 3 Elabore uma nova imagem com as cores originais modificadas (utilize cores que ainda não tenham sido utilizadas) e grave no disco
im5 = im;

for i=1:size(im, 1)
  for j=1:size(im, 1)
   if((im(i,j,1)>126)&&(im(i,j,2)<126)&&(im(i,j,3)<126))
      im5(i,j,1) = 0;
      im5(i,j,2) = 0;
      im5(i,j,3) = 255;
   end
   
   if((im(i,j,1)<90)&&(im(i,j,2)>90)&&(im(i,j,3)<90))
      im5(i,j,1) = 255;
      im5(i,j,2) = 0;
      im5(i,j,3) = 255;
   end
  
   if((im(i,j,1)>126)&&(im(i,j,2)>126)&&(im(i,j,3)<126))
      im5(i,j,1) = 0;
      im5(i,j,2) = 255;
      im5(i,j,3) = 255;
   end
  end
end

#figure("name", "cores alteradas");
#imshow(im5);

imwrite(im5, "CoresAlteradas.jpg");