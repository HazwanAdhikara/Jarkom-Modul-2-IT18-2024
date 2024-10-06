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

[[Click here](https://github.com/HazwanAdhikara/Jarkom-Modul-2-IT18-2024/blob/main/setup.sh)]

## Soal 1

Untuk mempersiapkan peperangan World War MMXXIV (Iya sebanyak itu), Sriwijaya membuat dua kotanya menjadi web server yaitu Tanjungkulai, dan Bedahulu, serta Sriwijaya sendiri akan menjadi DNS Master. Kemudian karena merasa terdesak, Majapahit memberikan bantuan dan menjadikan kerajaannya (Majapahit) menjadi DNS Slave.

1. pada Terminal **`Nusantara`**, lakukan ini

> `apt-get update`

> `echo 'iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 192.242.0.0/16' >> /root/.bashrc`

atau

> `./setup.sh router`

2. lalu cek nameserver yang akan digunakan pada Node lainnya
   ![alt text](image.png)

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

  ![alt text](image-1.png)

- lalu, `mkdir /etc/bind/jarkom` dan `nano /etc/bind/jarkom/sudarsana.it18.com` dan config seperti ini:

  ![alt text](image-2.png)

- jangan lupa untuk `service bind9 restart` setiap melakukan perubahan config

2. kita dapat lakukan ping pada **terminal Client**

### Client (Sanjaya)

- jangan lupa untuk config /etc/resolve.conf sesuai yang diperlukan
  ![alt text](image-3.png)

  `192.242.1.3 merupakan IP Sriwijaya`

- dan jangan lupa juga untuk `apt-get update` pada Client
- setelah itu, kita bisa test ping `sudarsana.it18.com` ataupun `www.sudarsana.it18.com`

![alt text](image-4.png)

## Soal 3

Para pasukan juga perlu mengetahui mana titik yang akan diserang, sehingga dibutuhkan domain lain yaitu pasopati.xxxx.com dengan alias www.pasopati.xxxx.com yang mengarah ke Kotalingga.

// untuk nomer 3 dan 4 sama aja seperti soal 2

1. pembuatan domain _pasopati.it18.com_

### Sriwijaya

- `nano /etc/bind/named.conf.local`
  dan config seperti ini:

  ![alt text](image-5.png)

- lalu, `nano /etc/bind/jarkom/pasopati.it18.com` dan config seperti ini:

  ![alt text](image-6.png)

- jangan lupa untuk `service bind9 restart` setiap melakukan perubahan config

2. kita dapat lakukan ping pada **terminal Client**

### Client (Sanjaya)

- setelah itu, kita bisa test ping `pasopati.it18.com` ataupun `www.pasopati.it18.com`

![alt text](image-7.png)

## Soal 4

Markas pusat meminta dibuatnya domain khusus untuk menaruh informasi persenjataan dan suplai yang tersebar. Informasi dan suplai meme terbaru tersebut mengarah ke Tanjungkulai dan domain yang ingin digunakan adalah rujapala.xxxx.com dengan alias www.rujapala.xxxx.com.

1. pembuatan domain _rujapala.it18.com_

### Sriwijaya

- `nano /etc/bind/named.conf.local`
  dan config seperti ini:

  ![alt text](image-8.png)

- lalu, `nano /etc/bind/jarkom/rujapala.it18.com` dan config seperti ini:

  ![alt text](image-9.png)

- jangan lupa untuk `service bind9 restart` setiap melakukan perubahan config

2. kita dapat lakukan ping pada **terminal Client**

### Client (Sanjaya)

- setelah itu, kita bisa test ping `rujapala.it18.com` ataupun `www.rujapala.it18.com`

![alt text](image-10.png)

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

![alt text](image-11.png)

### Client Jayanagara

![alt text](image-12.png)
