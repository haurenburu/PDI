# setup
clear;
close;
# 1 criar uma imagem vazia
im1 = zeros(256);
im1 = uint8(im1);
# 2 percorrer a imagem gerando um degrade de 256 tons de cinza
for i=1:size(im1, 1)
  im1(:,i) = i-1;;
end
# 3 abrir uma nova janela e mostrar a imagem em degrade
figure(1);
imshow(im1);
# 4 ler a imagem lena.jpg na variavel im;
im = imread("./lena.jpg");
figure(2);
imshow(im);

# 5 Transformar a imagem im para tons de cinza criando uma nova imagem im2
im2 = zeros(size(im, 1));
im2 = uint8(im2);

for i=1:size(im, 1)
  for j = 1:size(im, 1)
    # utilizar a fórmula Gray = 0.3*R +0.59*G +0.11*B
    im2(i,j, 1) = 0.3 * im(i,j,1) + 0.59 * im(i,j, 2) + 0.11 * im(i, j, 3);
  end
end

figure(3);
imshow(im2);

# 6 Criar e mostrar a imagem saida1 inferindo em im2 um degradê de tal forma que a imagem varie do escuro para o claro
for i=1:size(im2,1)
  for j = 1:size(im2,1)
    im3(i,j) = im2(i,j)-(size(im2,1)/2-j);
  end
end

figure(4);
imshow(im3);

# 7 Aumentar o valor de cada pixel de im2 em 40% gerando a imagem saida2 (Imagem5) e diminuir o valor de cada pixel de im2 em 40% gerando a imagem saida3
c1 = time();

for i=1:size(im2, 1)
  for j=1:size(im2, 1)
   im4(i,j) = im2(i,j) * 1.4;
  end
end

figure(5);
imshow(im4);

for i=1:size(im2, 1)
  for j=1:size(im2, 1)
   im5(i,j) = im2(i,j) * 0.4;
  end
end

figure(6);
imshow(im5);
c2 = time();

# 8 Executar novamente o passo anterior substituindo os laços utilizados por atribuições diretas
c3 = time();
im6 = im2 * 1.4;
figure(7);
imshow(im6);

im7 = im2 * 0.4;
figure(8);
imshow(im7);
c4 = time();

# 9 Contar os tempos de execução dos passos 7 e 8 e comparar os resultados.
disp("utilizando for")
disp(c2-c1)
disp("utilizando atribuicao")
disp(c4-c3)

# 10 Escrever as imagens saida1, saida2 e saida3 no disco
imwrite(im3, "saida1.jpg");
imwrite(im6, "saida2.jpg");
imwrite(im7, "saida3.jpg");
