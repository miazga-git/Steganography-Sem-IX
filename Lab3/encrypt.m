% wczytanie pliku dźwiękowego w formacie wav
[start_audio, f] = audioread('vintagetel.wav');

% normalizacja audio
audio = uint8(255*(start_audio + 0.5)); 

len_audio = length(audio)

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

if len_binary_message <= len_audio
    %przejście po pliku audio  
    while counter <= len_binary_message
        if binary_num_key(counter_sha) == 1
            LSB = mod(double(audio(counter)), 2);
            temp = double(xor(LSB, binary_num_message(counter)));
            audio(counter) = audio(counter)+temp;
            counter = counter+1;
        end
        counter_sha = counter_sha+1;
        %w przypadku, gdy wiadomość dłuższa niż 160 bitów:
        if counter_sha > binary_key_length 
            counter_sha = 1;
        end

    end
    
    new_audio = (double(audio)/255 - 0.5);

    %zapisanie pliku audio powstalego w wyniku przeksztalcen
    audiowrite("hidden_message.wav", new_audio, f)
    disp('Ukryto wiadomosc')
else
    disp('Slowo nie zmiesci sie w pliku audio!')
end



