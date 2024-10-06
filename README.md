# Jarkom-Modul-2-IT18-2024

**KELOMPOK IT18**
| Nama | NRP |
|---------------------------|------------|
|Hazwan Adhikara Nasution | 5027231017 |
|Farand Febriansyah | 5027231084 |

<hr>

## Topology

<img width="1146" alt="image" src="https://github.com/user-attachments/assets/c16fddad-bc8a-4822-bbed-d000f8f4b208">

## Network Configuration

### > Nusantara (Router)

```
auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet static
	address 192.242.1.1
	netmask 255.255.255.0

auto eth2
iface eth2 inet static
	address 192.242.2.1
	netmask 255.255.255.0

auto eth3
iface eth3 inet static
	address 192.242.3.1
	netmask 255.255.255.0
```

### > Sriwijaya (DNS Master)

```
auto eth0
iface eth0 inet static
	address 192.242.1.3
	netmask 255.255.255.0
	gateway 192.242.1.1
```

### > Majapahit (DNS Slave)

```
auto eth0
iface eth0 inet static
	address 192.242.2.2
	netmask 255.255.255.0
	gateway 192.242.2.1
```

### > Tanjungkulai (Web Server)

```
auto eth0
iface eth0 inet static
	address 192.242.1.4
	netmask 255.255.255.0
	gateway 192.242.1.1
```

### > Bedahulu (Web Server)

```
auto eth0
iface eth0 inet static
	address 192.242.1.5
	netmask 255.255.255.0
	gateway 192.242.1.1
```

### > Sanjaya (Client)

```
auto eth0
iface eth0 inet static
	address 192.242.1.2
	netmask 255.255.255.0
	gateway 192.242.1.1
```

### > Anusapati (Client)

```
auto eth0
iface eth0 inet static
	address 192.242.2.3
	netmask 255.255.255.0
	gateway 192.242.2.1
```

### > Jayanagara (Client)

```
auto eth0
iface eth0 inet static
	address 192.242.2.5
	netmask 255.255.255.0
	gateway 192.242.2.1
```

### > Solok (load Balancer)

```
auto eth0
iface eth0 inet static
	address 192.242.3.2
	netmask 255.255.255.0
	gateway 192.242.3.1
```

## Notes

- `Prefix IP = 192.242`
- `Nameserver Nusantara(Router) = 192.168.122.1`
- `IP Sriwijaya(DNS Master) = 192.242.1.3`
- `IP Majapahit(DNS Slave) = 192.242.2.2`
- **`Kami menggunakan Telnet agar mempermudah pengerjaan`**
- `Untuk memudahkan pengerjaan, kami juga membuat argv dalam shell scriptnya`
- `Jangan lupa untuk add "nameserver 192.168.122.1" ke setiap /etc/resolve.conf pada terminal agar terhubung internet`
- `Serta lakukan apt-get update di setiap terminal`

## Shell Script

**Cara menggunakannya :**

- `nano setup.sh` pada root terminal
- isi dengan _setup.sh_ pada [[Link ini](https://github.com/HazwanAdhikara/Jarkom-Modul-2-IT18-2024/blob/main/setup.sh)] dan save
- lalu, ketik `chmod +x setup.sh` pada terminal
- Setelah itu run dengan `./setup.sh ARGV`, ARGV sesuaikan dengan apa yang ingin anda jalankan.

> misal anda ingin setup Nusantara sebagai Router, maka run dengan `./setup.sh router`. dan untuk run lainnya silahkan lihat di link tadi.

## Soal 1

Untuk mempersiapkan peperangan World War MMXXIV (Iya sebanyak itu), Sriwijaya membuat dua kotanya menjadi web server yaitu Tanjungkulai, dan Bedahulu, serta Sriwijaya sendiri akan menjadi DNS Master. Kemudian karena merasa terdesak, Majapahit memberikan bantuan dan menjadikan kerajaannya (Majapahit) menjadi DNS Slave.

1. pada Terminal **`Nusantara`**, lakukan ini

> `apt-get update`

> `echo 'iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 192.242.0.0/16' >> /root/.bashrc`

atau

> `./setup.sh router`

2. lalu cek nameserver yang akan digunakan pada Node lainnya
   ![alt text](./assets/image.png)

3. Pada Terminal **`Sriwijaya`** kita perlu membuatnya menjadi DNS Master, dengan melakukan steps ini:

- `echo 'nameserver 192.168.122.1' > /etc/resolv.conf`
- `apt-get update`
- `apt-get install bind9 -y`

## Soal 2

Karena para pasukan membutuhkan koordinasi untuk melancarkan serangannya, maka buatlah sebuah domain yang mengarah ke Solok dengan alamat sudarsana.xxxx.com dengan alias www.sudarsana.xxxx.com, dimana xxxx merupakan kode kelompok. Contoh: sudarsana.it01.com.

1. Pembuatan domain _sudarsana.it18.com_

### Sriwijaya

- `nano /etc/bind/named.conf.local`
  dan config seperti ini:

  ![alt text](./assets/image-1.png)

- lalu, `mkdir /etc/bind/jarkom` dan `nano /etc/bind/jarkom/sudarsana.it18.com` dan config seperti ini:

  ![alt text](./assets/image-2.png)

- jangan lupa untuk `service bind9 restart` setiap melakukan perubahan config

2. kita dapat lakukan ping pada **terminal Client**

### Client (Sanjaya)

- jangan lupa untuk config /etc/resolve.conf sesuai yang diperlukan
  ![alt text](./assets/image-3.png)

  `192.242.1.3 merupakan IP Sriwijaya`

- dan jangan lupa juga untuk `apt-get update` pada Client
- setelah itu, kita bisa test ping `sudarsana.it18.com` ataupun `www.sudarsana.it18.com`

![alt text](./assets/image-4.png)

## Soal 3

Para pasukan juga perlu mengetahui mana titik yang akan diserang, sehingga dibutuhkan domain lain yaitu pasopati.xxxx.com dengan alias www.pasopati.xxxx.com yang mengarah ke Kotalingga.

// untuk nomer 3 dan 4 sama aja seperti soal 2

1. pembuatan domain _pasopati.it18.com_

### Sriwijaya

- `nano /etc/bind/named.conf.local`
  dan config seperti ini:

  ![alt text](./assets/image-5.png)

- lalu, `nano /etc/bind/jarkom/pasopati.it18.com` dan config seperti ini:

  ![alt text](./assets/image-6.png)

- jangan lupa untuk `service bind9 restart` setiap melakukan perubahan config

2. kita dapat lakukan ping pada **terminal Client**

### Client (Sanjaya)

- setelah itu, kita bisa test ping `pasopati.it18.com` ataupun `www.pasopati.it18.com`

![alt text](./assets/image-7.png)

## Soal 4

Markas pusat meminta dibuatnya domain khusus untuk menaruh informasi persenjataan dan suplai yang tersebar. Informasi dan suplai meme terbaru tersebut mengarah ke Tanjungkulai dan domain yang ingin digunakan adalah rujapala.xxxx.com dengan alias www.rujapala.xxxx.com.

1. pembuatan domain _rujapala.it18.com_

### Sriwijaya

- `nano /etc/bind/named.conf.local`
  dan config seperti ini:

  ![alt text](./assets/image-8.png)

- lalu, `nano /etc/bind/jarkom/rujapala.it18.com` dan config seperti ini:

  ![alt text](./assets/image-9.png)

- jangan lupa untuk `service bind9 restart` setiap melakukan perubahan config

2. kita dapat lakukan ping pada **terminal Client**

### Client (Sanjaya)

- setelah itu, kita bisa test ping `rujapala.it18.com` ataupun `www.rujapala.it18.com`

![alt text](./assets/image-10.png)

## Soal 5

Pastikan domain-domain tersebut dapat diakses oleh seluruh komputer (client) yang berada di Nusantara.

- untuk **Client Sanjaya** dapat lihat di soal 2, 3, dan 4
- jangan lupa untuk lakukan ini pada terminal Client:

```bash
    echo 'nameserver 192.168.122.1' > /etc/resolv.conf
    echo 'nameserver 192.242.1.3' >> /etc/resolv.conf #IP Sriwijaya sebagai dns-master

	apt-get update
```

### Client Anusapati

![alt text](./assets/image-11.png)

### Client Jayanagara

![alt text](./assets/image-12.png)

## Soal 6

Beberapa daerah memiliki keterbatasan yang menyebabkan hanya dapat mengakses domain secara langsung melalui alamat IP domain tersebut. Karena daerah tersebut tidak diketahui secara spesifik, pastikan semua komputer (client) dapat mengakses domain pasopati.xxxx.com melalui alamat IP Kotalingga (Notes: menggunakan pointer record).

- karena `IP Kotalingga = 192.242.2.4`, Reversenya adalah `2.242.192` (4nya disimpan untuk keperluan config nantinya)

### Sriwijaya

1. `nano /etc/bind/named.conf.local` untuk edit config, lalu tambahkan dengan ini

```bash
zone "2.242.192.in-addr.arpa" {
    type master;
    file "/etc/bind/jarkom/2.242.192.in-addr.arpa";
};
```

2. `nano /etc/bind/jarkom/2.242.192.in-addr.arpa`, lalu sesuaikan dengan config dibawah ini

```bash
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     pasopati.it18.com. root.pasopati.it18.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
2.242.192.in-addr.arpa.  IN      NS      pasopati.it18.com.
4                        IN      PTR     pasopati.it18.com.
```

> notes: angka 4 atau angka terakhir IP Kotalingga, kita gunakan diatas untuk Record PTR

3. `service bind9 restart`. Karena kita baru saja melakukan perubahan pada `/etc/bind/named.conf.local`.

### Client

1. jangan lupa untuk add nameserver pada `/etc/resolv.conf`
2. lakukan instalasi pada terminal `apt install dnsutils -y`
3. untuk ngetes nya kita lakukan `host -t PTR 192.242.2.4 (IP KOTALINGGA buat ngecek)`
   ![alt text](./assets/image-13.png)

## Soal 7

Akhir-akhir ini seringkali terjadi serangan brainrot ke DNS Server Utama, sebagai tindakan antisipasi kamu diperintahkan untuk membuat DNS Slave di Majapahit untuk semua domain yang sudah dibuat sebelumnya yang mengarah ke Sriwijaya.

- untuk membuat DNS Slave, kita perlu config pada (Sriwijaya) DNS Master dan (Majapahit) DNS Slave.

### Sriwijaya

1. `nano /etc/bind/named.conf.local` lalu sesuaikan dengan ini

```bash
zone "sudarsana.it18.com" {
    type master;
    notify yes;
    also-notify { 192.242.2.2; }; // IP Majapahit
    allow-transfer { 192.242.2.2; }; // IP Majapahit
    file "/etc/bind/jarkom/sudarsana.it18.com";
};
zone "pasopati.it18.com" {
    type master;
    notify yes;
    also-notify { 192.242.2.2; }; // IP Majapahit
    allow-transfer { 192.242.2.2; }; // IP Majapahit
    file "/etc/bind/jarkom/pasopati.it18.com";
};
zone "rujapala.it18.com" {
    type master;
    notify yes;
    also-notify { 192.242.2.2; }; // IP Majapahit
    allow-transfer { 192.242.2.2; }; // IP Majapahit
    file "/etc/bind/jarkom/rujapala.it18.com";
};
```

> terlihat disitu kita menambahkan config untuk IP Majapahit

2. jangan lupa restart `service bind9 restart`

### (Majapahit) DNS Slave

> jangan lupa untuk `echo 'nameserver 192.168.122.1' > /etc/resolv.conf`

1. update dan install bind9

```bash
apt-get update
apt-get install bind9 -y
```

2. config /etc/bind/named.conf.local seperti ini

```bash
zone "sudarsana.it18.com" {
    type slave;
    masters { 192.242.1.3; }; // IP Sriwijaya sbg DNS Master
    file "/var/lib/bind/sudarsana.it18.com";
};
zone "pasopati.it18.com" {
    type slave;
    masters { 192.242.1.3; }; // IP Sriwijaya sbg DNS Master
    file "/var/lib/bind/pasopati.it18.com";
};
zone "rujapala.it18.com" {
    type slave;
    masters { 192.242.1.3; }; // IP Sriwijaya sbg DNS Master
    file "/var/lib/bind/rujapala.it18.com";
};
```

3. jangan lupa untuk restart `service bind9 restart`

### Testing

1. pada `Sriwijaya` matikan service bind9 dengan cara

```bash
service bind9 stop
```

cek dengan,

```bash
root@Sriwijaya:~# service bind9 status
 * bind9 is not running
```

2. pada `Client` cek _/etc/resolve.conf_ pastikan ada nameserver yang mengarah ke IP Sriwijaya dan IP Majapahit

```bash
nameserver 192.168.122.1
nameserver 192.242.1.3 # IP Sriwijaya sbg DNS Master
nameserver 192.242.2.2 # IP Majapahit sbg DNS Slave
```

3. pada `Client` lakukan ping kepada domain manapun yang tersedia

   ![alt text](./assets/image-14.png)

4. Setelah berhasil, jangan lupa untuk nyalakan bind9 lagi, masuk ke terminal `Sriwijaya`, lakukan `service bind9 start`.

## Soal 8

Kamu juga diperintahkan untuk membuat subdomain khusus melacak kekuatan tersembunyi di Ohio dengan subdomain cakra.sudarsana.xxxx.com yang mengarah ke Bedahulu.

### Sriwijaya

1. Pada `Sriwijaya`, edit `/etc/bind/jarkom/sudarsana.it18.com` menjadi seperti

```bash
root@Sriwijaya:~# cat /etc/bind/jarkom/sudarsana.it18.com
;
; BIND data file for local loopback interface
;
$TTL    604800
@    IN    SOA    sudarsana.it18.com. root.sudarsana.it18.com. (
                  2        ; Serial
             604800        ; Refresh
              86400        ; Retry
            2419200        ; Expire
             604800 )    ; Negative Cache TTL
;
@     IN    NS        sudarsana.it18.com.
@     IN    A         192.242.3.2        ; IP Solok
www   IN    CNAME     sudarsana.it18.com.
cakra IN    A	      192.242.1.5        ; IP Bedahulu # Tambahkan ini dan sesuaikan IPnya
```

> tambahkan baris paling bawah kedalam config agar dia bisa menjadi subdomain sudarsana.it18.com

2. jangan lupa restart `service bind9 restart`

### Client

1. lakukan testing dengan ping subdomainnya

   ![alt text](./assets/image-15.png)

## Soal 9

Karena terjadi serangan DDOS oleh shikanoko nokonoko koshitantan (NUN), sehingga sistem komunikasinya terhalang. Untuk melindungi warga, kita diperlukan untuk membuat sistem peringatan dari siren man oleh Frekuensi Freak dan memasukkannya ke subdomain panah.pasopati.xxxx.com dalam folder panah dan pastikan dapat diakses secara mudah dengan menambahkan alias www.panah.pasopati.xxxx.com dan mendelegasikan subdomain tersebut ke Majapahit dengan alamat IP menuju radar di Kotalingga.

### Sriwijaya

1. kita perlu menambahkan beberapa config maka lakukan `nano /etc/bind/jarkom/pasopati.it18.com` dan sesuaikan dengan ini

```bash
;
; BIND data file for local loopback interface
;
$TTL    604800
@    IN    SOA    pasopati.it18.com. root.pasopati.it18.com. (
                  2        ; Serial
             604800        ; Refresh
              86400        ; Retry
            2419200        ; Expire
             604800 )    ; Negative Cache TTL
;
@       IN      NS      pasopati.it18.com.
@       IN      A       192.242.2.4             ; IP Kotalingga
www     IN      CNAME   pasopati.it18.com.
ns1     IN      A       192.242.2.2             ; IP Majapahit
panah   IN      NS      ns1
```

> Tambahkan 2 baris paling bawah, yang dimana `ns1` adalah IP Majapahit

2. pada `/etc/bind/named.conf.options` tambahkan `allow-query{any;};` kedalamnya, seperti ini

```bash
options {
        directory "/var/cache/bind";
        allow-query{any;}; # Tambahkan ini

        auth-nxdomain no;    # conform to RFC1035
        listen-on-v6 { any; };
};
```

3. juga pada `/etc/bind/named.conf.local`, sesuaian dengan ini

```bash
zone "pasopati.it18.com" {
    type master;
    notify yes;
    also-notify { 192.242.2.2; }; // IP Majapahit
    allow-transfer { 192.242.2.2; }; // IP Majapahit
    file "/etc/bind/jarkom/pasopati.it18.com";
};
```

> yang ditambahkan adalah IP Majapahit

4. restart `service bind9 restart`

### Majapahit

1. sesuaikan juga di majapahit `nano /etc/bind/named.conf.options`

```bash
options {
        directory "/var/cache/bind";
        allow-query{any;}; # Tambahkan ini juga

        auth-nxdomain no;    # conform to RFC1035
        listen-on-v6 { any; };
};
```

2. tambahkan zone baru pada `/etc/bind/named.conf.local`

```bash
zone "panah.pasopati.it18.com" {
        type master;
        file "/etc/bind/panah/panah.pasopati.it18.com";
};
```

3. buat folder panah

```bash
mkdir /etc/bind/panah
```

4. lalu config `/etc/bind/panah/panah.pasopati.it18.com` dengan ini,

```bash
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     panah.pasopati.it18.com. root.panah.pasopati.it18.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      panah.pasopati.it18.com.
@       IN      A       192.242.2.4                     ; IP Kotalingga
www     IN      CNAME   panah.pasopati.it18.com
```

> dengan IP Kotalingga

5. jangan lupa restart `service bind9 restart`

### Client

1. pastikan nameserver sudah sesuai pada `/etc/resolve.conf`

2. kita test dengan ping subdomainnya

![alt text](./assets/image-16.png)
