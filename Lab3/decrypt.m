% odczyt pliku audio z ukrytym obrazem 
[start_audio, f] = audioread('hidden_message.wav');

% normalizacja audio
audio= uint8(255*(start_audio + 0.5)); 

%ilość znaków zaszyfrowanej wiadomości
chars = input('Podaj dlugosc wiadomosci: ');

%liczba bitów wiadomości
message_length = chars * 8;

%pobranie klucza od użytkownika
key = input('Podaj klucz(liczba): ', 's');

%funkcja skrótu SHA1
sha1hasher = System.Security.Cryptography.SHA1Managed;
hash = sha1hasher.ComputeHash(uint8(key));
sha1= uint8(hash); 

%konwersja wartości dzisiętnych na binarne, tym razem dla klucza
binary_key = transpose(dec2bin(sha1, 8));
binary_key = binary_key(:);

%zapisanie dlugosci binarnej klucza
binary_key_length = length(binary_key);

%konwersja tablicy char na numeryczna dla klucza
binary_num_key = str2num(binary_key);

counter = 1;
counter_sha = 1;

%przejście po pliku audio  
while counter <= message_length
    if binary_num_key(counter_sha) == 1
        extracted_bits(counter,1) = mod(double(audio(counter)), 2);
        counter = counter+1;
    end
    counter_sha = counter_sha+1;
    %w przypadku, gdy wiadomość dłuższa niż 160 bitów:
    if counter_sha > binary_key_length 
        counter_sha = 1;
    end
end

%potęgi liczby 2 do odzyskania znaków ascii z binarki
binValues = [ 128 64 32 16 8 4 2 1 ];

%odkodowanie wiadomości
binMatrix = reshape(extracted_bits, 8,(message_length/8));
textString = char(binValues*binMatrix);
disp(textString);


