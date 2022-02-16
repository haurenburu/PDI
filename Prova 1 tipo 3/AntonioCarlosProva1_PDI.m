pkg load image
close all
clear all
clc

fundo = imread('./foto3.jpg');
spot9 = imread('./img3.jpg');
mask = imread('./mascara3.jpg');
pdi = imread('./ass.jpg');
final = imread('./Saida.jpg');

fundoCrossed = fundo;
degrade = pdiWhite = pdi;

pdiWhite(pdi < 150) = 255;
pdiWhite(pdi > 150) = 0;

# create gradient
for i=1:size(pdi,2)
  degrade(:,i) = i * 4;
end

pdiWhite(pdiWhite >= 250) = degrade(pdiWhite >= 250);

# make a negative cross
for i=1:size(fundo, 1)
  for j=1:size(fundo, 2)
    if (i>190 && i< 210 || j > 190 && j < 210)
      fundoCrossed(i, j, :) = 255 - fundo(i, j, :);
    end
  end
end

# rotate background
fundoRotate = fundo;
for i=1:size(fundo, 1)
  for j=1:size(fundo, 2)
    fundoRotate(i, j, :) = fundoCrossed(j, i, :);
  end
end
# flip background vertically
rows = size(fundoRotate, 1);
for i = 1:rows
  flipedFundo(rows - i + 1, :, :) = fundoRotate(i, :, :);
end

# rotate image of spot9
spot9Rotate = spot9;
for i=1:size(spot9, 1)
  for j=1:size(spot9, 2)
    spot9Rotate(i, j, :) = spot9(j, i, :);
  end
end

finalImage(:,:,1) = mask;
finalImage(:,:,2) = mask;
finalImage(:,:,3) = mask;

# use mask to mount the image
for i=1:size(fundo, 1)
  for j=1:size(fundo, 2)    
   if (mask(i,j) > 188 && mask(i, j) < 192)
     finalImage(i,j,:) = 0;
   end
   
   if ((mask(i,j) > 50 && mask(i,j) < 90) || (mask(i,j) >= 0 && mask(i,j) <= 5))
     finalImage(i,j,:) = flipedFundo(i,j,:);
   end
   
   if (mask(i,j) > 125 && mask(i,j) < 140)
     finalImage(i,j,:) = spot9Rotate(i,j,:);
   end
  end
end

# put the pdi on final image O.o
for i=1:size(fundo, 1)
  for j=1:size(fundo, 2)  
  if ((i < 32) && (j < 59))
    finalImage(i+215,j+140, :) = pdiWhite(i,j);
   end
  end
end

##figure(1);
##imshow(fundo);

##figure(2);
##imshow(flipedFundo);

##figure(3);
##imshow(spot9);

##figure(4);
##imshow(spot9Rotate);

figure('Name', "resultado final");
imshow(finalImage);

imwrite(finalImage, "./finalantonio.jpg")

figure('Name', "objetivo");
imshow(final);
