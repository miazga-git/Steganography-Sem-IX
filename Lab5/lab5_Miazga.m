%wczytujanie obrazu
image_1 = imread('wikipedia_tree.png');
[height_1, width_1, layers_1] = size(image_1);

image_2 = imread('wikipedia_tree_enc.png');
[height_2, width_2, layers_2] = size(image_2);

%wyodrębnienie warstwy LSB obrazu
%warstwy zostaną zapisane (zwizualizowane) jako obrazy

%allBlack to tabela rozmiaru obrazu wypełniona samymi zerami
allBlack = zeros(height_1, width_1, 'uint8');

%temp_matrix to 3 warstwy odpowiadające wielkościom warstw obrazu,wypełnione zerami
temp_1_matrix = zeros(height_1, width_1, layers_1);
temp_2_matrix = zeros(height_2, width_2, layers_2);
counter1 = 0;
counter2 = 0;
for i = 1 : 1 : height_1
    for j = 1 : 1 : width_1
        for k = 1 : 1 : layers_1
            pix_number = image_1(i,j,k);
            bin = de2bi(pix_number,8);

            LSB_1 = bin(1); %pierwszy najmniej znaczący bit

            if LSB_1 == 1
               temp_1_matrix(i,j,k) = 255;
               counter1 = counter1  +1 ;
            end
        end
    end
end

for i = 1 : 1 : height_2
    for j = 1 : 1 : width_2
        for k = 1 : 1 : layers_2
            pix_number = image_2(i,j,k);
            bin = de2bi(pix_number,8);

            LSB_1 = bin(1); %pierwszy najmniej znaczący bit

            if LSB_1 == 1
               temp_2_matrix(i,j,k) = 255;
               counter2 = counter2 +1;
            end
        end
    end
end

% first LSB
layer_r_1 = cat(3,temp_1_matrix(:,:,1),allBlack,allBlack);
layer_g_1 = cat(3,allBlack,temp_1_matrix(:,:,2),allBlack);
layer_b_1 = cat(3,allBlack,allBlack,temp_1_matrix(:,:,3));

layer_r_2 = cat(3,temp_2_matrix(:,:,1),allBlack,allBlack);
layer_g_2 = cat(3,allBlack,temp_2_matrix(:,:,2),allBlack);
layer_b_2 = cat(3,allBlack,allBlack,temp_2_matrix(:,:,3));

%zapisanie wyodrębnionych warstw
imwrite(layer_r_1,"layer_r_1.png");
imwrite(layer_g_1,"layer_g_1.png");
imwrite(layer_b_1,"layer_b_1.png");

imwrite(layer_r_2,"layer_r_2.png");
imwrite(layer_g_2,"layer_g_2.png");
imwrite(layer_b_2,"layer_b_2.png");

tiledlayout(6,1);
nexttile
hist1 = histogram(image_1(:,:,1), 255, 'FaceColor', 'red');
title('Histogram dla warstwy czerwonej, dla obrazu bez ukrytej wiadomości ')
xlabel ('czerwony - obraz oryginalny')

nexttile
hist2 = histogram(image_2(:,:,1), 255, 'FaceColor', 'red');
title('Histogram dla warstwy czerwonej, dla obrazu z ukrytą wiadomością ')
xlabel ('czerwony - obraz z ukrytą wiadomością')

nexttile
hist3 = histogram(image_1(:,:,2), 255, 'FaceColor', 'green');
title('Histogram dla warstwy zielonej, dla obrazu bez ukrytej wiadomości ')
xlabel ('zielony - obraz oryginalny')

nexttile
hist4 = histogram(image_2(:,:,2), 255, 'FaceColor', 'green');
title('Histogram dla warstwy zielonej, dla obrazu z ukrytą wiadomością ')
xlabel ('zielony - obraz z ukrytą wiadomością')

nexttile
hist5 = histogram(image_1(:,:,3), 255, 'FaceColor', 'blue');
title('Histogram dla warstwy niebieskiej, dla obrazu bez ukrytej wiadomości ')
xlabel ('niebieski - obraz oryginalny')

nexttile
hist6 = histogram(image_2(:,:,3), 255, 'FaceColor', 'blue');
title('Histogram dla warstwy niebieskiej, dla obrazu z ukrytą wiadomością ')
xlabel ('niebieski - obraz z ukrytą wiadomością')

disp('---')
disp(counter1)
disp(counter2)


