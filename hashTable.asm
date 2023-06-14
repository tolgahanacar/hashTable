section .data
    hashtable db 10 dup (0) ; 10 elemanlı hash tablosu
    keys db "John", "Jane", "Bob" ; anahtarlar
    values db 25, 30, 35 ; değerler

section .text
    global _start

_start:
    mov ecx, 3 ; 3 anahtar-değer çifti olduğunu belirtmek için ecx'e 3 atanır
    mov esi, 0 ; esi, anahtarların indeksini tutmak için kullanılacak

hash_loop:
    mov edx, keys[esi*4] ; esi * 4 ile doğru anahtarın bellek adresini buluruz
    mov al, 0 ; hash değeri sıfırlanır

hash_next_char:
    mov bl, byte [edx] ; anahtarın bir sonraki karakterini alırız
    add al, bl ; karakterin ASCII değerini hash değerine ekleriz
    inc edx ; bir sonraki karaktere geçeriz

    cmp byte [edx], 0 ; karakterin sonuna gelip gelmediğimizi kontrol ederiz
    jne hash_next_char ; sona gelmediysek döngüye devam ederiz

    mov dl, 10 ; hash tablosunun boyutunu edx'e kopyalarız
    div dl ; hash değerini hash tablosu boyutuna göre mod alırız

    mov dl, al ; hash değerini dl registerına kopyalarız
    shl dl, 2 ; dl'i 4 ile çarparız (anahtarlar ve değerler 4 byte olduğu için)
    add dl, hashtable ; dl ile hash tablosunun bellek adresini buluruz

    mov bl, values[esi] ; değeri bl registerına kopyalarız
    mov [dl], bl ; hash tablosuna değeri kaydederiz

    inc esi ; bir sonraki anahtara geçeriz
    loop hash_loop ; ecx azaltılarak döngüye devam ederiz

    ; Burada hash tablosunu kullanarak değerlere erişim veya silme işlemleri yapabilirsiniz

exit:
    mov eax, 1 ; programın sonlandırılması için sistem çağrısı numarası
    xor ebx, ebx ; hata kodu olarak 0 kullanılır
    int 0x80 ; sistem çağrısı yapılır
