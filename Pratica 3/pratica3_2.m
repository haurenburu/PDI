pkg load image

clear all
close all

objs = imread('./objetos1.jpg');

figure(1);
imshow(objs);

objsBW = uint8(zeros(size(objs, 1), size(objs, 2)));

objsBW(objs > 126) = 1;

figure(2);
imshow(objsBW, [0 1]);

##r = 1;
sameLabel = 0;

rotulo = 40;
objsLabel = objsBW;

for(i=2:size(objsBW, 1))
  for(j=2:size(objsBW, 2))
    if(objsBW(i, j) == 1) # pixel its foreground so check left and up neighbor
      if((objsBW(i-1,j) == 0) && (objsBW(i,j-1) == 0))
        rotulo+=5;
        objsLabel(i,j) = rotulo;
      else
        if((objsBW(i-1, j) == 1) && (objsBW(i, j-1) == 0)) # up neighbor = foreground and left = background
          objsLabel(i,j) = rotulo(i, j-1);
        else 
          if((objsBW(i-1, j) == 0) && (objsBW(i, j-1) == 1)) # left neighbor = foreground and up = background
            objsLabel(i, j) = objsLabel(i, j-1);
          else
            if((objsBW(i-1, j) == 1) && (objsLabel(i-1, j) == objsLabel(i, j-1))) # both neighbor = foreground and have the same label
              objsLabel(i, j) = objsLabel(i-1, j);
            else
              if(((objsBW(i-1, j) == 1) && (objsBW(i, j-1) == 1)) && (objsLabel(i-1, j) != objsLabel(i, j-1)))
                # neighbor of 4 found 2 objects but they are the same
                objsLabel(i, j) = objsLabel(i-1, j);
                equal1 = objsLabel(i-1, j); # left neighbor with wrong label
                equal2 = objsLabel(i, j-1); # up neighbor with wrong label
              end
            end
          end
      end
    end    
  end
end  
