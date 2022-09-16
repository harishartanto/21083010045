#!/bin/bash

header() {
    msg="# $* #"
    edge=$(echo "$msg" | sed 's/./=/g')
    echo "$edge"
    echo "$msg"
    echo "$edge"
}

celcius() {
    header "   Konversi Suhu Celcius   "
    echo -e "\nMasukkan suhu (°C): "
    read suhu
    c_f=$(printf $suhu | awk '{print 9/5 * $suhu + 32}')
    c_r=$(printf $suhu | awk '{print 4/5 * $suhu}')
    let c_k=suhu+273
    celcius_c() {
        echo -e "\nPilih opsi konversi"
        echo -e "[1] Fahrenheit (°F)\n[2] Reaumur (°R)\n[3] Kelvin (K)\n[4] Tampilkan semua\n\nPilih (1/2/3/4): " 
        read pilih_c
        if [ $pilih_c == 1 ]
        then
            echo -e "\nHasil:"
            echo "$suhu °C = $c_f °F"
        elif [ $pilih_c == 2 ]
        then
            echo -e "\nHasil:"
            echo "$suhu °C = $c_r °R"
        elif [ $pilih_c == 3 ]
        then
            echo -e "\nHasil:"
            echo "$suhu °C = $c_k K"
        elif [ $pilih_c == 4 ]
        then
            echo -e "\nHasil:"
            echo "$suhu °C = $c_f °F"
            echo "$suhu °C = $c_r °R"
            echo "$suhu °C = $c_k K"
        else
            clear
            echo "Pilihan tidak valid!"
            sleep 1
            clear
            celcius_c
        fi
    }
    celcius_c
}

fahrenheit() {
    header "   Konversi Suhu Fahrenheit   "
    echo -e "\nMasukkan suhu (°F): "
    read suhu
    f_c=$(printf $suhu | awk '{print 5/9 * ($suhu - 32)}')
    f_r=$(printf $suhu | awk '{print 4/9 * ($suhu - 32)}')
    f_k=$(printf $suhu | awk '{print 5/9 * ($suhu - 32) + 273}')
    fahrenheit_c() {
        echo -e "\nPilih opsi konversi"
        echo -e "[1] Celcius (°C)\n[2] Reaumur (°R)\n[3] Kelvin (K)\n[4] Tampilkan semua\n\nPilih (1/2/3/4): " 
        read pilih_c
        if [ $pilih_c == 1 ]
        then
            echo -e "\nHasil:"
            echo "$suhu °F = $f_c °C"
        elif [ $pilih_c == 2 ]
        then
            echo -e "\nHasil:"
            echo "$suhu °F = $f_r °R"
        elif [ $pilih_c == 3 ]
        then
            echo -e "\nHasil:"
            echo "$suhu °F = $f_k K"
        elif [ $pilih_c == 4 ]
        then
            echo -e "\nHasil:"
            echo "$suhu °F = $f_c °C"
            echo "$suhu °F = $f_r °R"
            echo "$suhu °F = $f_k K"
        else
            clear
            echo "Pilihan tidak valid!"
            sleep 1
            clear
            fahrenheit_c
        fi
    }
    fahrenheit_c
}

reaumur() {
    header "   Konversi Suhu Reaumur   "
    echo -e "\nMasukkan suhu (°R): "
    read suhu
    r_c=$(printf $suhu | awk '{print 5/4 * $suhu}')
    r_f=$(printf $suhu | awk '{print 9/4 * $suhu + 32}')
    r_k=$(printf $suhu | awk '{print 5/4 * $suhu + 273}')
    reaumur_c() {
        echo -e "\nPilih opsi konversi"
        echo -e "[1] Celcius (°C)\n[2] Fahrenheit (°F)\n[3] Kelvin (K)\n[4] Tampilkan semua\n\nPilih (1/2/3/4): " 
        read pilih_c
        if [ $pilih_c == 1 ]
        then
            echo -e "\nHasil:"
            echo "$suhu °R = $r_c °C"
        elif [ $pilih_c == 2 ]
        then
            echo -e "\nHasil:"
            echo "$suhu °R = $r_f °F"
        elif [ $pilih_c == 3 ]
        then
            echo -e "\nHasil:"
            echo "$suhu °R = $f_k K"
        elif [ $pilih_c == 4 ]
        then
            echo -e "\nHasil:"
            echo "$suhu °R = $r_c °C"
            echo "$suhu °R = $r_f °F"
            echo "$suhu °R = $r_k K"
        else
            clear
            echo "Pilihan tidak valid!"
            sleep 1
            clear
            reaumur_c
        fi
    }
    reaumur_c
}

kelvin() {
    header "   Konversi Suhu Kelvin   "
    echo -e "\nMasukkan suhu (K): "
    read suhu
    let k_c=$(printf $suhu | awk '{print $suhu - 273}')
    k_f=$(printf $suhu | awk '{print 9/5 * ($suhu - 273) + 32}')
    k_r=$(printf $suhu | awk '{print 4/5 * ($suhu - 273)}')
    kelvin_c() {
        echo -e "\nPilih opsi konversi"
        echo -e "[1] Celcius (°C)\n[2] Fahrenheit (°F)\n[3] Reaumur (°R)\n[4] Tampilkan semua\n\nPilih (1/2/3/4): " 
        read pilih_c
        if [ $pilih_c == 1 ]
        then
            echo -e "\nHasil:"
            echo "$suhu K = $k_c °C"
        elif [ $pilih_c == 2 ]
        then
            echo -e "\nHasil:"
            echo "$suhu K = $k_f °F"
        elif [ $pilih_c == 3 ]
        then
            echo -e "\nHasil:"
            echo "$suhu K = $k_r °R"
        elif [ $pilih_c == 4 ]
        then
            echo -e "\nHasil:"
            echo "$suhu K = $k_c °C"
            echo "$suhu K = $k_f °F"
            echo "$suhu K = $k_r °R"
        else
            clear
            echo "Pilihan tidak valid!"
            sleep 1
            clear
            kelvin_c
        fi
    }
    kelvin_c
}

satuan_awal () {
    header "   Konversi Suhu   "
    echo -e "\nPilih satuan suhu awal"
    echo -e "[1] Celcius (°C)\n[2] Fahrenheit (°F)\n[3] Reaumur (°R)\n[4] Kelvin (K)\n\nPilih (1/2/3/4): "
    read pilih
    if [ $pilih == 1 ]
    then
        clear
        celcius
    elif [ $pilih == 2 ]
    then
        clear
        fahrenheit
    elif [ $pilih == 3 ]
    then
        clear
        reaumur
    elif [ $pilih == 4 ]
    then
        clear
        kelvin
    else
        clear
        echo "Pilihan tidak valid!"
        sleep 1
        clear
        satuan_awal
    fi
}

dadu() {
    header "   Acak Dadu   "
    m_dadu=(1 2 3 4 5 6)
    let pilih=$RANDOM%6
    echo -e "\nMata Dadu: ${m_dadu[$pilih]}"
    echo -e "\n+-------+"
    if [ $pilih == 0 ]
    then   
        echo "|       |"
        echo "|   *   |"
        echo "|       |"
    elif [ $pilih == 1 ]
    then   
        echo "| *     |"
        echo "|       |"
        echo "|     * |"
    elif [ $pilih == 2 ]
    then   
        echo "|     * |"
        echo "|   *   |"
        echo "| *     |"
    elif [ $pilih == 3 ]
    then   
        echo "| *   * |"
        echo "|       |"
        echo "| *   * |"
    elif [ $pilih == 4 ]
    then   
        echo "| *   * |"
        echo "|   *   |"
        echo "| *   * |"
    else
        echo "| * * * |"
        echo "|       |"
        echo "| * * * |"
    fi
    echo "+-------+"

    echo -e "\nUlangi? (Y/N)"
    read ulang
    if [ ${ulang^^} == Y ]
    then 
        clear
        dadu
    elif [ ${ulang^^} == N ]
    then
        clear
        start
    else
        clear
        echo "Pilihan tidak valid!"
        sleep 1
        clear
        dadu
    fi
}

start() {
    echo -e "Pilih program:\n[1] Konversi Suhu\n[2] Acak Dadu\n\nPilih (1/2): "
    read pilih
    if [ $pilih == 1 ]
    then
        clear
        satuan_awal
    elif [ $pilih == 2 ]
    then
        clear
        dadu
    else
        clear
        echo "Pilihan tidak valid!"
        sleep 1
        clear
        start
    fi
}

start
