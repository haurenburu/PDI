pkg load image;

close all;
clear all;

entrada1 = imread('./prv2.jpg');
entrada2 = imread('./ruido1.jpg');

m1 = zeros(size(entrada1, 1));

# ===========================================
# questao 1 com for
# ===========================================

for i=1:size(entrada1, 1)
  for j=1:size(entrada1, 2)
    # amarelo
    if (
        (entrada1(i,j,1) > 200)
        &&
        (entrada1(i,j,2) > 200)
        &&
        (entrada1(i,j,3) < 100)
       )
       m1(i,j) = 1;
    end
    # azul
    if (
        (entrada1(i,j,1) > 40) && (entrada1(i,j,1) < 100)
        &&
        (entrada1(i,j,2) > 40) && (entrada1(i,j,2) < 100)
        &&
        (entrada1(i,j,3) > 150)
       )
      m1(i,j) = 1;
    end
  end  
end

figure('Name', "questao 1");
imshow(m1);

# ===========================================
# questao 2
# ===========================================

EE = [ 1 1 1 1 1;1 1 1 1 1;1 1 1 1 1;1 1 1 1 1;1 1 1 1 1 ];
m2 = m1;

# dilatou
for i=3:size(m1, 1)-2
  for j=3:size(m1, 2)-2
    if (m1(i,j))
      viz = m1(i-2:i+2, j-2:j+2);
      if(sum(sum(EE == viz)) == 25)
        m2(i,2) = 1;
      else
        m2(i-2:i+2, j-2:j+2) = EE;
      end
    end
  end
end
# dilatou dnv
m3 = m2;
for i=3:size(m2, 1)-2
  for j=3:size(m2, 2)-2
    if (m2(i,j))
      viz = m2(i-2:i+2, j-2:j+2);
      if(sum(sum(EE == viz)) == 25)
        m3(i,2) = 1;
      else
        m3(i-2:i+2, j-2:j+2) = EE;
      end
    end
  end
end

#erodiu
##m3 = m1;
##
##for i=2:size(m1, 1)-1
##  for j=2:size(m1, 2)-1
##    if (m1(i,j))
##      viz = m1(i-2:i+2, j-2:j+2);
##      if(sum(sum(EE == viz)) != 25)
##        m3(i,j) = 0;
##      end
##    end
##  end
##end

bordas = m3-m2;

figure('Name', "questao2");
imshow(bordas);

# ===========================================
#questao 3
# ===========================================
imSuavizada = entrada2;

for i=2:size(entrada2, 1)-1
  for j=2:size(entrada2, 2)-1
    viz = entrada2(i-1:i+1, j-1:j+1);
    imSuavizada(i,j) = median(median(viz));
  end
end

figure('Name', "questao3");
imshow(imSuavizada);

# ===========================================
#questao 4
# ===========================================
imBlur = imSuavizada;

for i=3:size(imSuavizada, 1)-2
  for j=3:size(imSuavizada, 2)-2
    viz = imSuavizada(i-2:i+2, j-2:j+2);
    imBlur(i,j) = sum(sum(viz))/25;
  end
end

diffImg = imSuavizada - imBlur;
imFinal = imSuavizada + 3.5*diffImg;


figure("Name", "quase a questao4");
imshow(imFinal);
#{#}