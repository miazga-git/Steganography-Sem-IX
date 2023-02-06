image = imread('stegano.png');
[h , w , l] = size(image);

len_binary_message = 24;
start = 1;
rowCounter = 1;

for i = 1 : 1 : w
    if i == w
        rowCounter = rowCounter + 1;
    end

    % odczytanie z obrazu nowych słów kodowych
    bitFromImage = dec2bin(image(i,rowCounter,1),7);
    sevenBits = bitFromImage;
    c = sevenBits;
    c = c.';

    H = [1 0 1 0 1 0 1; 0 1 1 0 0 1 1; 0 0 0 1 1 1 1]; % macierz kontroli parzystosci

    s = H*c; % syndrom

    % zamiana na ciąg zer i jedynek w zależności od parzystości 1 
    zeroOneList = [];
    for i=1 : 1 : length(s)
        if mod(s(i),2) == 0 
           zeroOneList(i) = mod(s(i),2);
        end
        if mod(s(i),2) == 1 
            zeroOneList(i) = mod(s(i),2);
        end
    end
    s = zeroOneList;

    extracted_bits(start, 1) = s(1);
    extracted_bits(start+1, 1) = s(2);
    extracted_bits(start+2, 1) = s(3);

    if start+3 > len_binary_message
        break;
    end
    start = start + 3;

end


%potęgi liczby 2 do odzyskania znaków ascii z binarki
binValues = [ 128 64 32 16 8 4 2 1 ];
 
%odkodowanie wiadomości
binMatrix = reshape(extracted_bits, 8,(len_binary_message/8));
textString = char(binValues*binMatrix);
disp(textString)
