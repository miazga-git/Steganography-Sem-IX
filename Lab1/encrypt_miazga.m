%wczytanie bitmapy w 24-bitowej głębi koloru
image = imread('eminem.jpg');
%zmiana rozmiaru wczytanego zdjęcia
image = imresize(image, [1200 1200]);
%numer albumu przekazywany jako wiadomosc
message = '71689'; 
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
%ostatnia cyfra numeru albumu to 9
%dane ukrywane beda w co drugim pikselu
% przejście po obrazie (rozpoczynając od piksela z wiersza i kolumny o indeksie odpowiadającym ostatniej cyfrze numeru albumu)  
for i = 9 : 2 : 1200
    for j = 9 : 2 : 1200

        if(embed_counter <= len_binary_message)

            LSB = mod(double(image(i, j, 1)), 2); %image(:,:,1) oznacza warstwe czerwona
            temp = double(xor(LSB, binary_num_message(embed_counter)));
            image(i, j, 1) = image(i, j, 1)+temp;
            embed_counter = embed_counter+1;
        end
    end
end
%zapisanie obrazu powstalego w wyniku przeksztalcen
imwrite(image, 'eminem_stegano.png');