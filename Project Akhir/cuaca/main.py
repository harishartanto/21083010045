import os
import time
import requests
from prettytable import PrettyTable
from bs4 import BeautifulSoup as bs
from datetime import datetime, timedelta
from constants import *

loc = 'Indonesia'
province_url = data_cleaning(get_province())

def home():
    header(loc)
    print('\n(1) Pilih Lokasi\n(2) Deskripsi\n(3) Opsi\n(4) Keluar')

    p1 = input('\nPilih (1/2/3/4): ')
    os.system('clear')
    if p1 == '1':
        os.system('clear')
        select_province(province_url) 
    elif p1 == '2':
        os.system('clear')
        description()
    elif p1 == '3':
        os.system('clear')
        options()
    elif p1 == '4':
        os.system('clear')
        print('Keluar dari program')
        time.sleep(0.5)
        os.system('clear')
        exit()
    else:
        invalid_selection()
        home()

def description():
    print('+-------------------------------- Dekripsi ----------------------------------+\n')
    print('''Keterangan Simbol Cuaca:
    - Suhu udara dengan satuan  celcius (°C)
    - [💧] Kelembaban udara dengan satuan persen (%)
    - [💨] Kecepatan angin dengan satuan kilometer per jam (km/jam)
    - [↖] Arah angin (dibaca: dari)
    - [?] Data belum tersedia
    ''')
    print('Sumber data: BMKG (Badan Meteorologi, Klimatologi, dan Geofisika) Indonesia\n'+
          'URL        : https://data.bmkg.go.id/prakiraan-cuaca/\n\nJumlah provinsi yang tersedia pada sumber data adalah sebanyak 34 pronvisi.')
    print('\n+'+'-'*76+'+\n')
    print('(K) Kembali')

    p2 = input('\nPilih (K): ')
    os.system('clear')
    if p2 == 'k' or p2 == 'K':
        home()
    else:
        invalid_selection()
        description()

def options():
    print('+--------------------------- Opsi Lokasi --------------------------+\n')
    global loc
    global province_url

    n = 1
    for k in loc_filter.keys():
            print(f'({n}) {k}')
            n += 1
    print('\n+'+'-'*66+'+\n')
    print('(K) Kembali')
    jawab = input(f'\nPilih (1/2/.../{n-1}/K): ')
    os.system('clear')

    if jawab == 'K' or jawab == 'k':
        home()
    elif jawab.isnumeric():
        if int(jawab) in range(1, n):
            loc = list(loc_filter.keys())[int(jawab)-1]
            province_url = loc_selection(loc_filter, loc)
            home()
        else:
            invalid_selection()
            options()
    else:
        invalid_selection()
        options()

def loc_selection(loc_filter, key):
    province_url = data_cleaning(get_province())
    province_url = data_filtering(province_url, loc_filter[key])
    return province_url

def select_province(province_dict):
    print('+------------------------- Pilih Provinsi -------------------------+\n')
    n = 1
    for k in province_dict.keys():
            print(f'({n}) {k}')
            n += 1
    print('\n+'+'-'*66+'+\n')
    print('(K) Kembali')
    if n == 1:
        jawab = input('\nPilih (1/K): ')
    elif n == 2:
        jawab = input('\nPilih (1/2/K): ')
    else:
        jawab = input(f'\nPilih (1/2/.../{n-1}/K): ')
    os.system('clear')
 
    if jawab == 'K' or jawab == 'k':
        home()
    elif jawab.isnumeric():
        if int(jawab) in range(1, n):
            url = province_dict[list(province_dict.keys())[int(jawab)-1]]
            get_city(url, list(province_dict.keys())[int(jawab)-1])
        else:
            invalid_selection()
            select_province(province_dict)
    else:
        invalid_selection()
        select_province(province_dict)

def get_city(url, prov_name):
    response = requests.get(url)
    r = response.text
    data = bs(r, 'xml')
    city = data.find_all('area')
    city_n = data.find_all('name', {'xml:lang': 'id_ID'})
    
    city_dict = {}
    city_list = []

    outside_dom_idx = []
    n = 0
    for i in city:
        if i['domain'] == prov_name:
            k, v = i['id'], i['description']
            city_dict[k] = v
            n += 1
        else:
            n += 1
            outside_dom_idx.append(n-1)
    
    for i in city_n:
            city_list.append(i.text)
    
    city_list = [city_list[i] for i in range(len(city_list)) if i not in outside_dom_idx]

    city_dict = {k: city_list[i]+f' ({v})' for i, (k, v) in enumerate(city_dict.items())} 

    select_city(city_dict, data)

def select_city(city_dict, data):
    print('+-------------------------- Pilih Daerah --------------------------+\n')
    n = 1
    for v in city_dict.values():
        print(f'({n}) {v}')
        n += 1
    print('\n+'+'-'*66+'+\n')
    print('(K) Kembali')
    jawab = input(f'\nPilih (1/2/.../{n-1}/K): ')
    os.system('clear')

    if jawab == 'K' or jawab == 'k':
        os.system('clear')
        select_province(province_url)
    elif jawab.isnumeric():
        if int(jawab) in range(1, n):
            key, value = list(city_dict.items())[int(jawab)-1]
            weather(key, value, city_dict, data)
        else:
            invalid_selection()
            select_city(city_dict, data)
    else:
        invalid_selection()
        select_city(city_dict, data)

def weather(city_id, city_n, city_dict, data):
    header(city_n)

    hourly_list = ['0', '6', '12', '18', '24', '30', '36', '42', '48', '54', '60', '66']
    param_id = ['weather', 't', 'hu', 'ws']

    weather_list = []
    i = 0
    for p in param_id:
        weather_list.append([])
        param_i = data.find(id=city_id).find(id=p)
        for h in hourly_list:
            h_i = param_i.find(h=h).value.string
            weather_list[i].append(h_i)
        i += 1
    
    wind_direction = data.find(id=city_id).find(id='wd')
    wind_dir_list = []
    for wd in hourly_list:
        wdh = wind_direction.find(h=wd).find(unit='CARD').text
        wind_dir_list.append(wdh)
    
    print('\n(1) Cuaca hari ini\n(2) Cuaca 3 hari kedepan\n(3) Kembali\n(4) Beranda')

    p3 = input('\nPilih (1/2/3/4): ')
    os.system('clear')
    if p3 == '1':
        os.system('clear')
        td_weather(weather_list, wind_dir_list, city_id, city_n, city_dict, data)
    elif p3 == '2':
        os.system('clear')
        tm_weather(weather_list, wind_dir_list, city_id, city_n, city_dict, data)
    elif p3 == '3':
        os.system('clear')
        select_city(city_dict, data)
    elif p3 == '4':
        os.system('clear')
        home()
    else:
        invalid_selection()
        weather(city_id, city_n, city_dict, data)

def td_weather(weather_list, wind_dir_list, city_id, city_n, city_dict, data):
    header(city_n, '', 109)
    date_time = datetime.now().strftime("%d %B %Y")
    date_time = date_time.replace(date_time[3:-5], month_id[date_time[3:-5]])
    day_name = datetime.now().strftime("%A")

    ver_grid = '|\n|\n|\n|\n|'
    td_list = []
    for i in range(0, 3):
        if i != 2:
            td_list.append([get_symbol(weather_list[0][i], weather_symbols), f'{weather_code[weather_list[0][i]]}\n{weather_list[1][i]}°C\n💧{weather_list[2][i]} %\n💨 {knot_to_kmh(weather_list[3][i])} km/jam\n{wind_d_code[wind_dir_list[i]]}', ver_grid])
        else:
            td_list.append([get_symbol(weather_list[0][i], weather_symbols), f'{weather_code[weather_list[0][i]]}\n{weather_list[1][i]}°C\n💧{weather_list[2][i]} %\n💨 {knot_to_kmh(weather_list[3][i])} km/jam\n{wind_d_code[wind_dir_list[i]]}'])

    table = PrettyTable()
    table._validate_field_names = lambda *a, **k: None
    table.title = f'{day_id[day_name]}, {date_time}'
    table.field_names = ['Pagi', '|'*15, '|', 'Siang', '|'*15, '|', 'Malam', '|'*15]
    table.add_row([td_list[0][0], td_list[0][1], td_list[0][2], 
                   td_list[1][0], td_list[1][1], td_list[1][2], 
                   td_list[2][0], td_list[2][1]])

    print(table)

    print('\n(1) Kembali\n(2) Beranda')

    p4 = input('\nPilih (1/2): ')
    os.system('clear')
    if p4 == '1':
        os.system('clear')
        weather(city_id, city_n, city_dict, data)
    elif p4 == '2':
        os.system('clear')
        home()
    else:
        invalid_selection()
        td_weather(weather_list, wind_dir_list, city_id, city_n, city_dict, data)

def tm_weather(weather_list, wind_dir_list, city_id, city_n, city_dict, data):
    header(city_n, '', 147)
    for i in range(0,3):
        for j in range(len(weather_list)):
            weather_list[j].append('(?)')

    for i in range(0,3):
        wind_dir_list.append('(?)')

    ver_grid = '|\n|\n|\n|\n|'
    n_list = [[3, 7], [7, 11], [11, 15]]

    def tm_data(i, n):
        tm_list = []
        for i in range(i, n):
            if i != n-1:
                tm_list.append([get_symbol(weather_list[0][i], weather_symbols), f'{weather_code[weather_list[0][i]]}\n{weather_list[1][i]}°C\n💧{weather_list[2][i]} %\n💨 {knot_to_kmh(weather_list[3][i])} km/jam\n{wind_d_code[wind_dir_list[i]]}', ver_grid])
            else:
                tm_list.append([get_symbol(weather_list[0][i], weather_symbols), f'{weather_code[weather_list[0][i]]}\n{weather_list[1][i]}°C\n💧{weather_list[2][i]} %\n💨 {knot_to_kmh(weather_list[3][i])} km/jam\n{wind_d_code[wind_dir_list[i]]}'])
        return tm_list
        
    def tm_table(tm_list, day_name, date_time):
        table = PrettyTable()
        table._validate_field_names = lambda *a, **k: None
        table.title = f'{day_id[day_name]}, {date_time}'
        table.field_names = ['Dini Hari', '|'*15, '|', 'Pagi', '|'*15, '|', 'Siang', '|'*15, '|', 'Malam', '|'*15]
        table.add_row([tm_list[0][0], tm_list[0][1], tm_list[0][2], 
                    tm_list[1][0], tm_list[1][1], tm_list[1][2], 
                    tm_list[2][0], tm_list[2][1], tm_list[2][2],
                    tm_list[3][0], tm_list[3][1]])

        print(table, '\n')
    
    for (i, j), x in zip(n_list, range(1, 4)):
        tm_date_time = datetime.now() + timedelta(days=x)
        day_name = datetime.now() + timedelta(days=x)

        tm_date_time = tm_date_time.strftime("%d %B %Y")
        tm_date_time = tm_date_time.replace(tm_date_time[3:-5], month_id[tm_date_time[3:-5]])
        day_name = day_name.strftime("%A")
        
        z = tm_data(i, j)
        tm_table(z, day_name, tm_date_time)
    
    print('(1) Kembali\n(2) Beranda')

    p4 = input('\nPilih (1/2): ')
    os.system('clear')
    if p4 == '1':
        os.system('clear')
        weather(city_id, city_n, city_dict, data)
    elif p4 == '2':
        os.system('clear')
        home()
    else:
        invalid_selection()
        tm_weather(weather_list, wind_dir_list, city_id, city_n, city_dict, data)

def header(place, place_2='Daerah', length=66):
    print('+'+'-'*length+'+')
    print('|'+'Prakiraan Cuaca'.center(length)+'|')
    print('|'+f'{place_2} di {place}'.center(length)+'|')
    print('+'+'-'*length+'+')

def invalid_selection():
    os.system('clear')
    print('[Pilihan tidak valid]')
    time.sleep(0.5)
    os.system('clear')

def get_symbol(id, weather):
    symbol = '\n'.join(weather[id])
    return symbol

def knot_to_kmh(knots):
    try:
        kmh = round(float(knots) * 1.852, 1)
    except ValueError:
        kmh = knots
    return kmh

if __name__ == '__main__':
    home()