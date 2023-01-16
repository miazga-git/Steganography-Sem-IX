%wczytanie bitmapy w 24-bitowej głębi koloru
image = imread('eminem_lab2.jpg');

%zmiana rozmiaru wczytanego zdjęcia
image = imresize(image, [1200 1200]);

%pobranie wiadomości od użytkownika
message = input('Podaj wiadomosc do ukrycia: ', 's');

%zamiana na kody ascii
ascii_value = uint8(message);

%konwersja wartości dziesiętnych na binarne
binary_message = transpose(dec2bin(ascii_value, 8));
binary_message = binary_message(:);

%zapisanie dlugosci binarnej wiadomosci
len_binary_message = length(binary_message);

%konwersja tablicy char na numeryczna
binary_num_message = str2num(binary_message);

embed_counter = 1;
temp_spiral_counter = 0;
spiral_counter = 1;
pos_y = 601;
pos_x = 600;
tmp = 1;
%przejście po obrazie   
while embed_counter <= len_binary_message
        if temp_spiral_counter > 1
            spiral_counter = spiral_counter+tmp;
            spiral_counter = spiral_counter*(-1);
            tmp = tmp*(-1);
            temp_spiral_counter = 0;
        end
        LSB = mod(double(image(pos_x, pos_y)), 2);
        temp = double(xor(LSB, binary_num_message(embed_counter)));
        disp('===========================')
        disp(pos_y)
        disp(pos_x)
        image(pos_x, pos_y) = image(pos_x, pos_y)+temp;
        if mod(embed_counter,2) == 1
            pos_y = pos_y + spiral_counter;
        end
        if mod(embed_counter,2) == 0
            pos_x = pos_x + spiral_counter;
        end
        embed_counter = embed_counter+1;
        temp_spiral_counter = temp_spiral_counter +1;
end

%zapisanie obrazu powstalego w wyniku przeksztalcen
imwrite(image, 'eminem_lab2_stegano.png');