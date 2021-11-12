pkg load image

clear all
close all

im = imread('./mulherNeg.jpg');
roi = imread('./ROI_circular.jpg');
imBackG = imread('./flores.jpg');

maskedRoi = zeros(size(roi, 1), size(roi, 2));
maskedRoi(roi > 126) = 1;

#{
for i=1:size(im, 1)
  for j=1:size(im, 2)
    imOpArit(i, j, 1) = im(i, j, 1) .* maskedRoi(i, j);
    imOpArit(i, j, 2) = im(i, j, 2) .* maskedRoi(i, j);
    imOpArit(i, j, 3) = im(i, j, 3) .* maskedRoi(i, j);
  end
end
#}

imOpArit = im .* maskedRoi;
imOperConj = max(imOpArit, imBackG);
imOperP2P = 255 - imOperConj;

##cols = size(imOperP2P, 2);
##for i=1:size(imOperP2P, 2)
##  imTGeo(:, cols,:) = imOperP2P(:,i,:);
##  cols--;
##end

cols = size(imOperP2P, 2);
for i=1:cols
  imTGeo(:,cols - i + 1, :) = imOperP2P(:, i, :);
end

output = im;

for i=1:size(im, 1)
  for j=1:size(im, 2)
    if(maskedRoi(i, j) == 1)
      output(i,size(im, 2)-j+1,:) = 255-im(i,j,:);
    else
      output(i, size(im, 2) - j + 1, :) = imBackG(i, j, :);
    end
  end
end



figure("Name", "Original Image");
imshow(im);

figure("Name", "Mask");
imshow(maskedRoi);

figure("Name", "Background");
imshow(imBackG);

figure("Name", "Masked Image");
imshow(imOpArit);

figure("Name", "Overlay with 2 images");
imshow(imOperConj);

figure("Name", "Negative Overlay p2p");
imshow(imOperP2P);

figure("Name", "Horizontal Mirror");
imshow(imTGeo);

figure("Name", "End Result");
imshow(output);