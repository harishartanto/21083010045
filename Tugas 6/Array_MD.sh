#!/bin/bash

#Mendeklarasikan array 2D dengan
#spasi (" ") sebagai pembatas antar baris dan titik dua (:) sebagai pembatas antar kolom
array2d="1.1:1.2:1.3:1.4 2.1:2.2:2.3:2.4 3.1:3.2:3.3:3.4"

#Membuat function untuk membentuk array 2D
function dimensiBaris {
    for baris in $*
    do
        dimensiKolom `echo $baris | tr : " "`
    done
}

function dimensiKolom {
    for kolom in $*
    do
        echo -n $kolom "  "
    done
    echo
}

#Memanggil function untuk menampilkan array 2D
dimensiBaris $array2d
