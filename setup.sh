# setup .bashrc di Nusantara
if [[ $1 == "router" ]]; then
    apt-get update

    echo 'iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 192.242.0.0/16' >> /root/.bashrc

elif [[ $1 == "client" ]]; then
    echo 'nameserver 192.168.122.1' > /etc/resolv.conf
    echo 'nameserver 192.242.1.3' >> /etc/resolv.conf #IP Sriwijaya sebagai dns-master
    echo 'nameserver 192.242.2.2' >> /etc/resolv.conf #IP Majapahit sebagai dns-slave

    apt-get update

    apt install dnsutils -y
    # host -t PTR 192.242.2.4 (IP KOTALINGGA buat ngecek)
    
elif [[ $1 == "dns-master" ]]; then
    echo 'nameserver 192.168.122.1' > /etc/resolv.conf

    apt-get update
    apt-get install bind9 -y

    # Echo for sudarsana.it18.com
    echo 'zone "sudarsana.it18.com" {' > /etc/bind/named.conf.local
    echo '    type master;' >> /etc/bind/named.conf.local
    echo '    notify yes;' >> /etc/bind/named.conf.local
    echo '    also-notify { 192.242.2.2; }; // IP Majapahit' >> /etc/bind/named.conf.local
    echo '    allow-transfer { 192.242.2.2; }; // IP Majapahit' >> /etc/bind/named.conf.local
    echo '    file "/etc/bind/jarkom/sudarsana.it18.com";' >> /etc/bind/named.conf.local
    echo '};' >> /etc/bind/named.conf.local

    # Echo for pasopati.it18.com
    echo 'zone "pasopati.it18.com" {' >> /etc/bind/named.conf.local
    echo '    type master;' >> /etc/bind/named.conf.local
    echo '    notify yes;' >> /etc/bind/named.conf.local
    echo '    also-notify { 192.242.2.2; }; // IP Majapahit' >> /etc/bind/named.conf.local
    echo '    allow-transfer { 192.242.2.2; }; // IP Majapahit' >> /etc/bind/named.conf.local
    echo '    file "/etc/bind/jarkom/pasopati.it18.com";' >> /etc/bind/named.conf.local
    echo '};' >> /etc/bind/named.conf.local

    # Echo for rujapala.it18.com
    echo 'zone "rujapala.it18.com" {' >> /etc/bind/named.conf.local
    echo '    type master;' >> /etc/bind/named.conf.local
    echo '    notify yes;' >> /etc/bind/named.conf.local
    echo '    also-notify { 192.242.2.2; }; // IP Majapahit' >> /etc/bind/named.conf.local
    echo '    allow-transfer { 192.242.2.2; }; // IP Majapahit' >> /etc/bind/named.conf.local
    echo '    file "/etc/bind/jarkom/rujapala.it18.com";' >> /etc/bind/named.conf.local
    echo '};' >> /etc/bind/named.conf.local

    # Reverse DNS Pasopati dengan IP Kotalingga
    echo 'zone "2.242.192.in-addr.arpa" {' >> /etc/bind/named.conf.local
    echo '    type master;' >> /etc/bind/named.conf.local
    echo '    file "/etc/bind/jarkom/2.242.192.in-addr.arpa";' >> /etc/bind/named.conf.local
    echo '};' >> /etc/bind/named.conf.local

    # named.conf.options di Sriwijaya
    echo 'options {' > /etc/bind/named.conf.options
    echo '        directory "/var/cache/bind";' >> /etc/bind/named.conf.options
    echo '        allow-query{any;};' >> /etc/bind/named.conf.options
    echo '' >> /etc/bind/named.conf.options
    echo '        auth-nxdomain no;    # conform to RFC1035' >> /etc/bind/named.conf.options
    echo '        listen-on-v6 { any; };' >> /etc/bind/named.conf.options
    echo '};' >> /etc/bind/named.conf.options


    mkdir /etc/bind/jarkom

    # Echo for sudarsana.it18.com
    echo ";" > /etc/bind/jarkom/sudarsana.it18.com
    echo "; BIND data file for local loopback interface" >> /etc/bind/jarkom/sudarsana.it18.com
    echo ";" >> /etc/bind/jarkom/sudarsana.it18.com
    echo "\$TTL    604800" >> /etc/bind/jarkom/sudarsana.it18.com
    echo "@    IN    SOA    sudarsana.it18.com. root.sudarsana.it18.com. (" >> /etc/bind/jarkom/sudarsana.it18.com
    echo "                  2        ; Serial" >> /etc/bind/jarkom/sudarsana.it18.com
    echo "             604800        ; Refresh" >> /etc/bind/jarkom/sudarsana.it18.com
    echo "              86400        ; Retry" >> /etc/bind/jarkom/sudarsana.it18.com
    echo "            2419200        ; Expire" >> /etc/bind/jarkom/sudarsana.it18.com
    echo "             604800 )    ; Negative Cache TTL" >> /etc/bind/jarkom/sudarsana.it18.com
    echo ";" >> /etc/bind/jarkom/sudarsana.it18.com
    echo "@     IN    NS        sudarsana.it18.com." >> /etc/bind/jarkom/sudarsana.it18.com
    echo "@     IN    A         192.242.3.2        ; IP Solok" >> /etc/bind/jarkom/sudarsana.it18.com
    echo "www   IN    CNAME     sudarsana.it18.com." >> /etc/bind/jarkom/sudarsana.it18.com
    echo 'cakra IN    A         192.242.1.5        ; IP Bedahulu' >> /etc/bind/jarkom/sudarsana.it18.com

    # Echo for pasopati.it18.com
    echo ';' > /etc/bind/jarkom/pasopati.it18.com
    echo '; BIND data file for local loopback interface' >> /etc/bind/jarkom/pasopati.it18.com
    echo ';' >> /etc/bind/jarkom/pasopati.it18.com
    echo '$TTL    604800' >> /etc/bind/jarkom/pasopati.it18.com
    echo '@    IN    SOA    pasopati.it18.com. root.pasopati.it18.com. (' >> /etc/bind/jarkom/pasopati.it18.com
    echo '                  2        ; Serial' >> /etc/bind/jarkom/pasopati.it18.com
    echo '             604800        ; Refresh' >> /etc/bind/jarkom/pasopati.it18.com
    echo '              86400        ; Retry' >> /etc/bind/jarkom/pasopati.it18.com
    echo '            2419200        ; Expire' >> /etc/bind/jarkom/pasopati.it18.com
    echo '             604800 )    ; Negative Cache TTL' >> /etc/bind/jarkom/pasopati.it18.com
    echo ';' >> /etc/bind/jarkom/pasopati.it18.com
    echo '@       IN      NS      pasopati.it18.com.' >> /etc/bind/jarkom/pasopati.it18.com
    echo '@       IN      A       192.242.2.4             ; IP Kotalingga' >> /etc/bind/jarkom/pasopati.it18.com
    echo 'www     IN      CNAME   pasopati.it18.com.' >> /etc/bind/jarkom/pasopati.it18.com
    echo 'ns1     IN      A       192.242.2.2             ; IP Majapahit' >> /etc/bind/jarkom/pasopati.it18.com
    echo 'panah   IN      NS      ns1' >> /etc/bind/jarkom/pasopati.it18.com


    # Echo for rujapala.it18.com
    echo ";" > /etc/bind/jarkom/rujapala.it18.com
    echo "; BIND data file for local loopback interface" >> /etc/bind/jarkom/rujapala.it18.com
    echo ";" >> /etc/bind/jarkom/rujapala.it18.com
    echo "\$TTL    604800" >> /etc/bind/jarkom/rujapala.it18.com
    echo "@    IN    SOA    rujapala.it18.com. root.rujapala.it18.com. (" >> /etc/bind/jarkom/rujapala.it18.com
    echo "                  2        ; Serial" >> /etc/bind/jarkom/rujapala.it18.com
    echo "             604800        ; Refresh" >> /etc/bind/jarkom/rujapala.it18.com
    echo "              86400        ; Retry" >> /etc/bind/jarkom/rujapala.it18.com
    echo "            2419200        ; Expire" >> /etc/bind/jarkom/rujapala.it18.com
    echo "             604800 )    ; Negative Cache TTL" >> /etc/bind/jarkom/rujapala.it18.com
    echo ";" >> /etc/bind/jarkom/rujapala.it18.com
    echo "@    IN    NS    rujapala.it18.com." >> /etc/bind/jarkom/rujapala.it18.com
    echo "@    IN    A     192.242.1.4        ; IP Tanjungkulai" >> /etc/bind/jarkom/rujapala.it18.com
    echo "www  IN    CNAME rujapala.it18.com." >> /etc/bind/jarkom/rujapala.it18.com

    # Reverse DNS Pasopati dengan IP Kotalingga
    echo ';' > /etc/bind/jarkom/2.242.192.in-addr.arpa
    echo '; BIND data file for local loopback interface' >> /etc/bind/jarkom/2.242.192.in-addr.arpa
    echo ';' >> /etc/bind/jarkom/2.242.192.in-addr.arpa
    echo '$TTL    604800' >> /etc/bind/jarkom/2.242.192.in-addr.arpa
    echo '@       IN      SOA     pasopati.it18.com. root.pasopati.it18.com. (' >> /etc/bind/jarkom/2.242.192.in-addr.arpa
    echo '                              2         ; Serial' >> /etc/bind/jarkom/2.242.192.in-addr.arpa
    echo '                         604800         ; Refresh' >> /etc/bind/jarkom/2.242.192.in-addr.arpa
    echo '                          86400         ; Retry' >> /etc/bind/jarkom/2.242.192.in-addr.arpa
    echo '                        2419200         ; Expire' >> /etc/bind/jarkom/2.242.192.in-addr.arpa
    echo '                         604800 )       ; Negative Cache TTL' >> /etc/bind/jarkom/2.242.192.in-addr.arpa
    echo ';' >> /etc/bind/jarkom/2.242.192.in-addr.arpa
    echo '2.242.192.in-addr.arpa.  IN      NS      pasopati.it18.com.' >> /etc/bind/jarkom/2.242.192.in-addr.arpa
    echo '4                        IN      PTR     pasopati.it18.com.' >> /etc/bind/jarkom/2.242.192.in-addr.arp

    service bind9 restart

elif [[ $1 == "dns-slave" ]]; then
    echo 'nameserver 192.168.122.1' > /etc/resolv.conf

    apt-get update
    apt-get install bind9 -y

    # Echo for sudarsana.it18.com (Slave)
    echo 'zone "sudarsana.it18.com" {' > /etc/bind/named.conf.local
    echo '    type slave;' >> /etc/bind/named.conf.local
    echo '    masters { 192.242.1.3; }; // IP Sriwijaya sbg DNS Master' >> /etc/bind/named.conf.local
    echo '    file "/var/lib/bind/sudarsana.it18.com";' >> /etc/bind/named.conf.local
    echo '};' >> /etc/bind/named.conf.local

    # Echo for pasopati.it18.com (Slave)
    echo 'zone "pasopati.it18.com" {' >> /etc/bind/named.conf.local
    echo '    type slave;' >> /etc/bind/named.conf.local
    echo '    masters { 192.242.1.3; }; // IP Sriwijaya sbg DNS Master' >> /etc/bind/named.conf.local
    echo '    file "/var/lib/bind/pasopati.it18.com";' >> /etc/bind/named.conf.local
    echo '};' >> /etc/bind/named.conf.local

    # Echo for rujapala.it18.com (Slave)
    echo 'zone "rujapala.it18.com" {' >> /etc/bind/named.conf.local
    echo '    type slave;' >> /etc/bind/named.conf.local
    echo '    masters { 192.242.1.3; }; // IP Sriwijaya sbg DNS Master' >> /etc/bind/named.conf.local
    echo '    file "/var/lib/bind/rujapala.it18.com";' >> /etc/bind/named.conf.local
    echo '};' >> /etc/bind/named.conf.local

    # Echo for panah.pasopati.it18.com (Slave)
    echo 'zone "panah.pasopati.it18.com" {' >> /etc/bind/named.conf.local
    echo '        type master;' >> /etc/bind/named.conf.local
    echo '        file "/etc/bind/panah/panah.pasopati.it18.com";' >> /etc/bind/named.conf.local
    echo '};' >> /etc/bind/named.conf.local

    # named.conf.options di Majapahit (Slave)
    echo 'options {' > /etc/bind/named.conf.options
    echo '        directory "/var/cache/bind";' >> /etc/bind/named.conf.options
    echo '        allow-query{any;};' >> /etc/bind/named.conf.options
    echo '' >> /etc/bind/named.conf.options
    echo '        auth-nxdomain no;    # conform to RFC1035' >> /etc/bind/named.conf.options
    echo '        listen-on-v6 { any; };' >> /etc/bind/named.conf.options
    echo '};' >> /etc/bind/named.conf.options

    mkdir /etc/bind/panah

    # nano panah.pasopati.it18.com
    echo ';' > /etc/bind/panah/panah.pasopati.it18.com
    echo '; BIND data file for local loopback interface' >> /etc/bind/panah/panah.pasopati.it18.com
    echo ';' >> /etc/bind/panah/panah.pasopati.it18.com
    echo '$TTL    604800' >> /etc/bind/panah/panah.pasopati.it18.com
    echo '@       IN      SOA     panah.pasopati.it18.com. root.panah.pasopati.it18.com. (' >> /etc/bind/panah/panah.pasopati.it18.com
    echo '                              2         ; Serial' >> /etc/bind/panah/panah.pasopati.it18.com
    echo '                         604800         ; Refresh' >> /etc/bind/panah/panah.pasopati.it18.com
    echo '                          86400         ; Retry' >> /etc/bind/panah/panah.pasopati.it18.com
    echo '                        2419200         ; Expire' >> /etc/bind/panah/panah.pasopati.it18.com
    echo '                         604800 )       ; Negative Cache TTL' >> /etc/bind/panah/panah.pasopati.it18.com
    echo ';' >> /etc/bind/panah/panah.pasopati.it18.com
    echo '@       IN      NS      panah.pasopati.it18.com.' >> /etc/bind/panah/panah.pasopati.it18.com
    echo '@       IN      A       192.242.2.4                     ; IP Kotalingga' >> /etc/bind/panah/panah.pasopati.it18.com
    echo 'www     IN      CNAME   panah.pasopati.it18.com' >> /etc/bind/panah/panah.pasopati.it18.com

    service bind9 restart

else
    echo "Usage: $0 [router|dns-master|dns-slave|client]"
    exit 1
fi

