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

[Buka File setup.sh]

## Soal 1

Untuk mempersiapkan peperangan World War MMXXIV (Iya sebanyak itu), Sriwijaya membuat dua kotanya menjadi web server yaitu Tanjungkulai, dan Bedahulu, serta Sriwijaya sendiri akan menjadi DNS Master. Kemudian karena merasa terdesak, Majapahit memberikan bantuan dan menjadikan kerajaannya (Majapahit) menjadi DNS Slave.

1. pada Terminal **`Nusantara`**, lakukan ini

> `apt-get update`

> `echo 'iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 192.242.0.0/16' >> /root/.bashrc`

atau

> `./setup.sh router`

2. lalu untuk cek nameserver yang akan digunakan pada
