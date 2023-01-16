%wczytanie zdjecia z ukryta wiadomoscia
image2 = imread('eminem_stegano.png');
%liczba znakow ukrytej wiadomosci
chars = 5;
%dlugosc wiadomosci w bitach
message_length = chars * 8;
counter = 1;
%przejscie po obrazie
for i = 9 : 2 : 1200
    for j = 9 : 2 : 1200
         
        if (counter <= message_length )
            extracted_bits(counter, 1) = mod(double(image2(i, j, 1)), 2);
            counter = counter + 1;
        end
    end
end
% potęgi liczby 2 do odzyskania znaków ascii z binarki
binValues = [ 128 64 32 16 8 4 2 1 ];
%odkodowanie wiadomości
binMatrix = reshape(extracted_bits, 8,(message_length/8));
textString = char(binValues*binMatrix);
disp(textString);