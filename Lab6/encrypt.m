image = imread('cat.jpg');
[h , w , l] = size(image);


% zapisanie wiadomości jako ciąg binarny oraz zapamiętanie długości w bitach
wiadomosc = '716';
ascii_value = uint8(wiadomosc);
binary_message = transpose(dec2bin(ascii_value, 8));
binary_message = binary_message(:);
len_binary_message = length(binary_message);
binary_num_message = str2num(binary_message);
%disp(binary_num_message)


start = 1;
rowCounter = 1;
for j = 1 : 1 : w
    % jeśli wiadomości nie uda się zapisać w jednej linijce obrazu to przeskok do kolejnej
    if j == w
        rowCounter = rowCounter + 1;
    end
    
    % c - słowo kodowe
    bitFromImage = dec2bin(image(j,rowCounter,1),7);
    sevenBits = bitFromImage;
    c = sevenBits;
    c = c.';

    % H - macierz kontroli parzystosci
    H = [1 0 1 0 1 0 1; 0 1 1 0 0 1 1; 0 0 0 1 1 1 1]; 

    s = H*c; % syndrom

    % zamiana ciągu na ciąg 0 i 1, w zależności od parzystości, parzystosc - 0, nieparzystosc - 1
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

    % jeśli zapisaliśmy całą wiadomość to koniec wykonywania pętli
    if start+2 > len_binary_message
        break;
    end

    % sekret - te bity ukrywamy w słowie kodowym
    sekret = binary_num_message(start:start+2);
    start = start+3;

    roznice = [0 0 0]; % nie ma roznicy
    for i=1 : 1 : length(sekret)
        if sekret(i) ~= s(i)
           roznice(i) = 1;
        end
    end

    % zmiana bitow na przeciwne tam gdzie to konieczne
    bitDoZmiany = [0 0 0 0 0 0 0];
    seven = [1 1 1];
    six = [0 1 1];
    five = [1 0 1];
    four = [0 0 1];
    three = [1 1 0];
    two = [0 1 0];
    one = [1 0 0];

    if roznice == three
       bitDoZmiany = [0 0 1 0 0 0 0];
    end
    if roznice == two
        bitDoZmiany = [0 1 0 0 0 0 0];
    end
    if roznice == one
        bitDoZmiany = [1 0 0 0 0 0 0];
    end
    if roznice == four
       bitDoZmiany = [0 0 0 1 0 0 0];
    end
    if roznice == five
       bitDoZmiany = [0 0 0 0 1 0 0];
    end
    if roznice == six
       bitDoZmiany = [0 0 0 0 0 1 0];
    end
    if roznice == seven
       bitDoZmiany = [0 0 0 0 0 0 1];
    end

    slowo_kodowe = [c(1) c(2) c(3) c(4) c(5) c(6) c(7)];

    % zamiana bitow na przeciwne dla odpowiednich x
    for i = 1 : 1 : length(slowo_kodowe)
        if bitDoZmiany(i) == 1
            if slowo_kodowe(i) == '1'
               slowo_kodowe(i) = '0';
            elseif slowo_kodowe(i) == '0'
               slowo_kodowe(i) = '1';
            end
        end
    end

    % slowo kodowe po zmianie
    c = slowo_kodowe;

    number = bin2dec(string(c));
    % zapis nowego słowa kodowego w obrazie
    image(j,rowCounter,1) = number;

end

% zapis obrazu
imwrite(image,'stegano.png')

