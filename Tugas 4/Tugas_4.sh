#!/bin/bash

header() {
    msg="# $* #"
    edge=$(echo "$msg" | sed 's/./=/g')
    echo "$edge"
    echo "$msg"
    echo "$edge"
}

header "Bilangan Positif Kelipatan Ganjil"
echo ""
read -p 'Input: ' bil
let gg=$bil%2
echo ""
if [ $bil -gt 0 ]
then
    if [ $gg == 0 ]
    then
        echo $bil merupakan bilangan genap.
        bil1=$((bil+1))
        bil2=$((bil-1))
        echo -e "Rekomendasi bilangan yang tepat: $bil1 atau $bil2\n"
        echo -e "Input: $bil1\n"
        while [ $bil1 -gt 0 ]
        do
            echo $bil1
            bil1=$((bil1-2))
        done
        echo -e "\natau\n"
        echo -e "Input: $bil2\n"
        until [ ! $bil2 -gt 0 ]
        do
            echo $bil2
            bil2=$((bil2-2))
        done
    else
        while [ $bil -gt 0 ]
        do
            echo $bil
            bil=$((bil-2))
        done
    fi
else
    echo "Masukkan bilangan positif!"
fi
