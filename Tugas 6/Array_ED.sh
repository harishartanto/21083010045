#!/bin/bash

#Mendeklarasikan array dengan nama "angka"
declare -a angka

#Membuat while loop untuk mengisi array "angka"
i=0;
while [ $i -le 4 ];
do
   let isi=$i*2;
   angka[$i]=$isi;
   let i=$i+1;
done

#Menampilkan/memanggil semua elemen dalam array "angka" dengan menggunakan "*" atau "@"
echo ${angka[*]}
echo ${angka[@]}
