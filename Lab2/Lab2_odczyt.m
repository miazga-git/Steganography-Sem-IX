%wczytanie zdjecia z ukryta wiadomoscia
image2 = imread('eminem_lab2_stegano.png');

%liczba znakow ukrytej wiadomosci
chars = input('Podaj dlugosc wiadomosci: ');

%dlugosc wiadomosci w bitach
message_length = chars * 8;

embed_counter = 1;
temp_spiral_counter = 0;
spiral_counter = 1;
pos_y = 601;
pos_x = 600;
tmp = 1;
%przejście po obrazie   
while embed_counter <= message_length
        if temp_spiral_counter > 1
            spiral_counter = spiral_counter+tmp;
            spiral_counter = spiral_counter*(-1);
            tmp = tmp*(-1);
            temp_spiral_counter = 0;
        end
        extracted_bits(embed_counter, 1) = mod(double(image(pos_x, pos_y)), 2);
        if mod(embed_counter,2) == 1
            pos_y = pos_y + spiral_counter;
        end
        if mod(embed_counter,2) == 0
            pos_x = pos_x + spiral_counter;
        end
        embed_counter = embed_counter+1;
        temp_spiral_counter = temp_spiral_counter +1;
end

%potęgi liczby 2 do odzyskania znaków ascii z binarki
binValues = [ 128 64 32 16 8 4 2 1 ];
 
disp(extracted_bits)

%odkodowanie wiadomości
binMatrix = reshape(extracted_bits, 8,(message_length/8));
textString = char(binValues*binMatrix);
disp(textString);
