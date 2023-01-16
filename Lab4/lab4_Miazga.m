%wczytujanie obrazu o 24-bitowej głębi koloru

%w poniższym obrazie będzie ukrywany drugi obraz (o 256 odcieniach szarości)
image_1 = imread('eminem-rihanna.jpg');%eminem-rihanna.jpg
[height_1, width_1, layers_1] = size(image_1);

%wczytanie obrazu o 256 odcieniach szarości
%poniższy obraz będzie ukrywany w pierwszym obrazie
image_2 = imread('cat_eye.jpg');
[height_2, width_2, layers_2] = size(image_2);

%wyodrębnienie kolejnych warstw najmniej znaczących bitów pikseli obrazu
%warstwy zostaną zapisane (zwizualizowane) jako obrazy
%operacje zostaną wykonane dla 3 najmniej znaczących bitów dla każdego koloru.

%allBlack to tabela rozmiaru obrazu wypełniona samymi zerami
allBlack = zeros(height_1, width_1, 'uint8');

%temp_matrix to 3 warstwy odpowiadające wielkościom warstw obrazu,wypełnione zerami
temp_1_matrix = zeros(height_1, width_1, layers_1);
temp_2_matrix = zeros(height_1, width_1, layers_1);
temp_3_matrix = zeros(height_1, width_1, layers_1);

for i = 1 : 1 : height_1
    for j = 1 : 1 : width_1
        for k = 1 : 1 : layers_1
            pix_number = image_1(i,j,k);
            bin = de2bi(pix_number,8);

            LSB_1 = bin(1); %pierwszy najmniej znaczący bit
            LSB_2 = bin(2); %drugi najmniej znaczący bit
            LSB_3 = bin(3); %trzeci najmniej znaczący bit

            if LSB_1 == 1
               temp_1_matrix(i,j,k) = 255;
            end
            if LSB_2 == 1
               temp_2_matrix(i,j,k) = 255;
            end
            if LSB_3 == 1
               temp_3_matrix(i,j,k) = 255;
            end
        end
    end
end

% first LSB
layer_r_1 = cat(3,temp_1_matrix(:,:,1),allBlack,allBlack);
layer_g_1 = cat(3,allBlack,temp_1_matrix(:,:,2),allBlack);
layer_b_1 = cat(3,allBlack,allBlack,temp_1_matrix(:,:,3));

% secound LSB
layer_r_2 = cat(3,temp_2_matrix(:,:,1),allBlack,allBlack);
layer_g_2 = cat(3,allBlack,temp_2_matrix(:,:,2),allBlack);
layer_b_2 = cat(3,allBlack,allBlack,temp_2_matrix(:,:,3));

% third LSB
layer_r_3 = cat(3,temp_3_matrix(:,:,1),allBlack,allBlack);
layer_g_3 = cat(3,allBlack,temp_3_matrix(:,:,2),allBlack);
layer_b_3 = cat(3,allBlack,allBlack,temp_3_matrix(:,:,3));

%zapisanie wyodrębnionych warstw
imwrite(layer_r_1,"layer_r_1.png");
imwrite(layer_g_1,"layer_g_1.png");
imwrite(layer_b_1,"layer_b_1.png");

imwrite(layer_r_2,"layer_r_2.png");
imwrite(layer_g_2,"layer_g_2.png");
imwrite(layer_b_2,"layer_b_2.png");

imwrite(layer_r_3,"layer_r_3.png");
imwrite(layer_g_3,"layer_g_3.png");
imwrite(layer_b_3,"layer_b_3.png");

%wiem, że obraz drugi jest mniejszy niż pierwszy, natomiast gdybym pisał
%kod na potrzeby powtarzania operacji na innych obrazach trzeba by sprawdzać
%warunek, czy obraz, który ukrywamy zmieści się w obrazie, w którym chcemy
%ukrywać

%ukrycie obrazu drugiego w obrazie pierwszym za pomocą algorytmu LSB


% warstw oba obrazy mają tyle samo i dla tych obrazów są one tej samej wielkości,
% problem mozna uprościć do zapisania drugiego obrazu w pierwszym dla jednej warstwy, pozostałe zrobi się analogicznie
row = 1;
col = 1;
counter = 0;
for warstwa = 1 : 1 : 3
    for i = 1 : 1 : height_2
       for j = 1 : 1 : width_2
                number = image_2(i,j,1);
                bin_number = de2bi(number,8);
                    for l = 1 : 1 : 8
                        LSB = mod(double(image_1(row,col,warstwa)), 2);
                        temp = double(xor(LSB, bin_number(l)));
                        image_1(row,col,warstwa) = image_1(row,col,warstwa) + temp;
                        col = col + 1;
                        if(col > width_1)
                            col = 1;
                            row = row + 1;
                        end
                        counter = counter + 1;
                    end
                
        end
    end
end

%ekstrakcja bitów ukrytych - na potrzeby sprawdzenia
%row = 1;
%col = 1;
%for i = 1 : 1 : 1560
%    extr_bits(i,1) = mod(double(image_1(row,col,1)), 2);
%    col = col + 1;
%    if(col > width_1)
%        col = 1;
%        row = row + 1;
%%    end
%end
%disp('extracted bits')
%disp(extr_bits)

temp_1_matrix_v2 = zeros(height_1, width_1, layers_1);
temp_2_matrix_v2 = zeros(height_1, width_1, layers_1);
temp_3_matrix_v2 = zeros(height_1, width_1, layers_1);

for i = 1 : 1 : height_1
    for j = 1 : 1 : width_1
        for k = 1 : 1 : layers_1
            pix_number = image_1(i,j,k);
            bin = de2bi(pix_number,8);

            LSB_1 = bin(1); %pierwszy najmniej znaczący bit
            LSB_2 = bin(2); %drugi najmniej znaczący bit
            LSB_3 = bin(3); %trzeci najmniej znaczący bit

            if LSB_1 == 1
                temp_1_matrix_v2(i,j,k) = 255;
            end
            if LSB_2 == 1
                temp_2_matrix_v2(i,j,k) = 255;
            end
            if LSB_3 == 1
                temp_3_matrix_v2(i,j,k) = 255;
            end
        end
    end
end

% first LSB
layer_r_1_v2 = cat(3,temp_1_matrix_v2(:,:,1),allBlack,allBlack);
layer_g_1_v2 = cat(3,allBlack,temp_1_matrix_v2(:,:,2),allBlack);
layer_b_1_v2 = cat(3,allBlack,allBlack,temp_1_matrix_v2(:,:,3));

% secound LSB
layer_r_2_v2 = cat(3,temp_2_matrix_v2(:,:,1),allBlack,allBlack);
layer_g_2_v2 = cat(3,allBlack,temp_2_matrix_v2(:,:,2),allBlack);
layer_b_2_v2 = cat(3,allBlack,allBlack,temp_2_matrix_v2(:,:,3));

% third LSB
layer_r_3_v2 = cat(3,temp_3_matrix_v2(:,:,1),allBlack,allBlack);
layer_g_3_v2 = cat(3,allBlack,temp_3_matrix_v2(:,:,2),allBlack);
layer_b_3_v2 = cat(3,allBlack,allBlack,temp_3_matrix_v2(:,:,3));

%zapisanie wyodrębnionych warstw
imwrite(layer_r_1_v2,"layer_r_1_v2.png");
imwrite(layer_g_1_v2,"layer_g_1_v2.png");
imwrite(layer_b_1_v2,"layer_b_1_v2.png");

imwrite(layer_r_2_v2,"layer_r_2_v2.png");
imwrite(layer_g_2_v2,"layer_g_2_v2.png");
imwrite(layer_b_2_v2,"layer_b_2_v2.png");

imwrite(layer_r_3_v2,"layer_r_3v.png");
imwrite(layer_g_3_v2,"layer_g_3_v2.png");
imwrite(layer_b_3_v2,"layer_b_3_v2.png");