# echOpen - Project log : EchoBench developpment

Daily log of the echOpen transducers test bench

| Objet :        | This document will show the project developpment progression with many photos and some comments. |
| -------------- | ---------------------------------------- |
| **Réf/File :** | `2017-09-03 PRJLOG echobench_developpment_log en` |
| **Révision :** | v1 - 2017-09-03 - BVi - Creation         |
| **Révision :** | work in progress                         |

![viewme](viewme.jpg)

## 2017-09-10 Assemblage Raspberry Pi Zero W & US-SPI

![](2017-09-10 raspberry_us-spi.jpg)

### Installation RPi zero W

#### Installation Raspbian

#### Config wifi en mode headless

D'après https://core-electronics.com.au/tutorials/raspberry-pi-zerow-headless-wifi-setup.html

Il suffit d'ajouter un fichier `wpa_supplicant.conf` à la carte SD de boot. Il sera "consommé" au prochain boot pour surcharger le fichier de configuration Wifi `/etc/wpa_supplicant/wpa_supplicant.conf`. Il doit contenir :

```
network={
    ssid="Your SSID"
    psk="YourWPAPassword"
    key_mgmt=WPA-PSK
}
```

Cette opération est à reproduire à chaque changement d'access point Wifi. On peut mettre plusieurs config :

```
network={
   ...
}

network={
   ...
}
```


#### Config mode "Ethernet Gadget"

D'après https://learn.adafruit.com/turning-your-raspberry-pi-zero-into-a-usb-gadget/ethernet-gadget

* Connexion SSH depuis windows
* On peut scanner et tester la connexion Wifi avec :
```
ifconfig
iwconfig wlan0
sudo iwlist wlan0 scan
```

#### Maj système :
```
sudo apt-get update
sudo apt-get upgrade
sudo rpi-update
sudo apt-get autoremove
```

#### Partage répertoire de travail avec Samba !!! ne fonctionne pas !!!

D'après http://www.framboise314.fr/partager-un-repertoire-sous-jessie-avec-samba/

* Installation serveur Samba
```
sudo apt-get install samba samba-common-bin
```

* Faites une copie de sauvegarde du fichier de configuration
```
sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.org
```

* Editer le fichier `/etc/samba/smb.conf`
```
# The specific set of interfaces / networks to bind to
# This can be either the interface name or an IP address/netmask;
# interface names are normally preferred
interfaces = 127.0.0.0/8 eth0
bind interfaces only = yes
```

* Créez le dossier que vous souhaitez partager (s’il n’existe pas). J’ai choisi `/home/pi`.

* Maintenant rendez vous à la fin du fichier… oui, tout en bas et ajoutez :
```
[pihome]
comment = code folder
path = /home/pi
writeable = yes
browseable = yes
read only = no
guest ok = yes
guest only = yes
create mask = 0755 ????
create mode = 0777
directory mode = 0777
share modes = yes
```

* Définir le mot de passe réseau pour `pi`
```
sudo smbpasswd -a pi
```

* Redémarrez Samba sous (Jessie):
```
sudo systemctl restart smbd.service
```

#### Configuration Wifi
A défaut de pouvoir faire fonctionner SAMBA sur ethernet over USB on configure le wifi d'après https://core-electronics.com.au/tutorials/raspberry-pi-zerow-headless-wifi-setup.html :
* Sous SSH éditer le fichier `/boot/wpa_supplicant.conf` en y insérant (le choix est fait en dans l'ordre et en fonction des puissances :
```
network={
    ssid="Bivi's2-5G"
    psk="...password..."
    key_mgmt=WPA-PSK
}
network={
    ssid="Bivi's2"
    psk="...password..."
    key_mgmt=WPA-PSK
}
network={
    ssid="Bivi's"
    psk="...password..."
    key_mgmt=WPA-PSK
}
```

Avec cette config, en rebootant, la freebox attribue l'IP 192.168.1.120 au RPi et le partage pihome fonctionne correctement avec l'explorateur de fichier Windows sous \\192.168.1.120\pihome

#### Installation Python3 et lib

* Installer Pip3
```
sudo apt-get install python3-pip`
sudo python3 -m pip install --upgrade pip`
```

* Installer bottle, le serveur http et websocket pour Python3
```
sudo pip3 install bottle
sudo pip3 install python-dev !!! ECHEC !!!
sudo pip3 install gevent-websocket
```
* Tester bottle en exécutant les fichier `python3 bottle_hello.py` :
```python
from bottle import route, run, template

@route('/hello/<name>')
def index(name):
    return template('<b>Hello {{name}}</b>!', name=name)

run(host='0.0.0.0', port=8080)
```

* Installer l'accès au bus SPI
  D'après http://deusyss.developpez.com/tutoriels/RaspberryPi/PythonEtLeGpio/

* Lancer sudo raspi-config et valider le SPI dans Advanced options :
```
sudo raspi-config
```
* Après reboot, tester la présence du driver SPI :
```
lsmod | grep spi_
```
* Installation modules python pour SPI
```
sudo pip3 install spidev
```

## 2017-09-15 Montage Table XY

![](2017-09-15 xy_table_assembled.jpg)

## 2017-10-06 Premiers essais

Fantôme de pôche ;-)

![](2017-09-30 pocket_phantom.png)

IHM sur navigateur Web

![2017-10-06 3.5MHz_80msps_HMI](2017-10-06 3.5MHz_80msps_HMI.png)Echantillonnage à 20Msps

![2017-10-06 3.5MHz_20msps](2017-10-06 3.5MHz_20msps.png)

Echantillonnage à 160Msps

![2017-10-06 3.5MHz_80msps](2017-10-06 3.5MHz_80msps.png)

## 2017-11-05 Adaptation Table XY sur aquarium (ou jardinière)

### Connexion Table XY <-> RPi0

On va établir une connexion série mais **attention** les niveau logiques sont à 3.3V côté RPi 
et 5V côté carte Me Orion (Arduino) de MakeBlock. Il faut un adaptateur de niveau :
* Le "Me Shield for Raspberry Pi" de chez MakeBlock http://learn.makeblock.com/en/me-shield-for-raspberry-pi/ (en stock chez Roboshop http://www.robotshop.com/en/makeblock-me-shield-raspberry-pi.html)
* Ou un adaptateur de niveau std https://hackspark.fr/fr/3-3v-5v-logic-level-converter.html ou https://hackspark.fr/fr/8-channel-bi-directional-logic-level-converter-txb0108-3-3-5v-or-others.html
* On évitera l'adaptation de niveau par pont diviseur qui présente un danger pour le T car la pin RX côté Arduino peut rester au niveau 5V dans certains cas.
  Un article complet sur la connexion Rpi Arduino : https://oscarliang.com/raspberry-pi-and-arduino-connected-serial-gpio/

### Pilotage de la table par le RPi

Au lieu d'utiliser les logiciels de dessin de haut niveau fournis avec la table (mDraw ou BenBox), nous allons installer sur la carte Me Orion de la table le firmware de pilotage CNC GCodeParser : https://github.com/Makeblock-official/XY-Plotter-2.0. Il interprète habituellement les commandes envoyées par le logiciel PC GRemote mais dans notre cas nous  enverrons directement les commandes depuis un script Python (serveur HTTP Bottle) via le port série.

### Codes G

```
G0  Xnnn Ynnn Znnn (Avance rapide)
G1  Xnnn Ynnn Znnn Fnnn (Avance usinage)
G2  Xnnn Ynnn Znnn Innn Jnnn (arc sens horaire)
G3  Xnnn Ynnn Znnn Innn Jnnn (arc sens anti-horaire)
G4  Pnnn (Pause)
G20 (Inch)
G21 (mm)
G28 (Home 0,0,0)
G30 Xnnn Ynnn Znnn (Home via XYZ)
G90 (Abs positionning)
G91 (Incr positionning)
G92 (Set as home)
$1  Xnnn Ynnn Znnn (set XYZ STEP PIN)
$2  Xnnn Ynnn Znnn (set XYZ DIR PIN)
$3  Xnnn Ynnn Znnn (set XYZ Min PIN)
$4  Xnnn Ynnn Znnn (set XYZ Max PIN)
$5  Znnn (ENABLE SERVO MOTOR FOR Z)
$6  Xnnn Ynnn Znnn (set XYZ STEPS PER MM)
$7  Xnnn Ynnn Znnn (set XYZ fast FEEDRATE)
$8  Snnn (set XYZ INVERT LIMIT SWITCH)
```

### Usage NetBeans

Pour permettre à Netbeans d'ouvrir des projets quelconques (juste une arborescence de fichier, sans fichier projet)
* Installer le plugin "Automatic Projects"

### Install Makeblock Library for Arduino

D'après http://learn.makeblock.com/en/learning-arduino-programming/

### Liaison Série RPi0 <-> Arduino

D'après http://learn.makeblock.com/me-shield-for-raspberry-pi/
D'après https://electrosome.com/uart-raspberry-pi-python/

* Libérer /dev/ttyAMA0 en désactivant le Bluetooth (cf https://www.raspberrypi.org/documentation/configuration/uart.md, https://hallard.me/enable-serial-port-on-raspberry-pi/). Depuis que les RPi sont équipés de Bluetooth (RPi3 et RPi0 W), l'UART hard est directement connecté au BT et un UART soft /dev/ttyS0 est connecté au GPIO 14 et 15. Il faut ici le récupérer
```
sudo nano /boot/config.txt
... ajouter à la fin la ligne:
dtoverlay=pi3-disable-bt
... sauver/quiter
sudo systemctl disable hciuart
... rebooter
sudo shutdown -r now
```
* Installer pyserial
```
sudo apt-get install python-serial
sudo pip3 install pyserial
```
* Reboucler RX/TX et tester :
```
python -m serial.tools.miniterm /dev/ttyAMA0 115200
... ou
minicom -b 115200 -o -D /dev/ttyAMA0
```

### Pieds supports

![echo_bench_support_v1](echo_bench_support_v1.jpg)

![echo_bench_support_v1](echo_bench_support_v2.jpg)

![2017-11-05 pieds](2017-11-05 pieds.jpg)

### Support de transducteur

![echo_bench_bracket_top](echo_bench_bracket_top.jpg)

![echo_bench_bracket_bottom](echo_bench_bracket_bottom.jpg)

![echo_bench_bracket_bottom_v2](echo_bench_bracket_bottom_v2.jpg)



![2017-11-05 support](2017-11-05 support.jpg)

### Pince de cible métallique

![echo_bench_tie](echo_bench_tie.jpg)

![2017-11-05 cible](2017-11-05 cible.jpg)

![2017-11-05 ensemble](2017-11-05 ensemble.jpg)

![2017-11-09 transducteur étanche](2017-11-09 transducteur étanche.jpg)



![2017-11-09 ensemble 2](2017-11-09 ensemble 2.jpg)Premier essai

![2017-11-11 first_field_measure](2017-11-11 first_field_measure.png)

## 2017-11-16 Essais tranducteur en direct

Echelle orthonormée.

![2017-11-16 direct ortho F35_T50_G15 S225-10x10-2 D5](2017-11-16 direct ortho F35_T50_G15 S225-10x10-2 D5.png)

Echelle dilatée en Y.

![2017-11-16 direct F35_T50_G15 S225-10x10-2 D5](2017-11-16 direct F35_T50_G15 S225-10x10-2 D5.png)

## 2017-11-16 Essais avec périscope

Essai avec un périscope, mais miroirs de mauvaise qualité.

![echo_bench_mirror_holder](echo_bench_mirror_holder.jpg)

![2017-11-16_192912](2017-11-16_192912.jpg)

![2017-11-16c periscop F35_T65_G20_S225-10x10-2_D90 miroirs](2017-11-16c periscop F35_T65_G20_S225-10x10-2_D90 miroirs.png)




## 2017-11-18 Essais avec un miroir à 45°

Support miroir à 45°. Le miroir est un bout de PCB simple face de 45x30.

![echo_bench_single_mirror_holder](echo_bench_single_mirror_holder.jpg)

![](2017-11-18 45deg_mirror_holder.jpg)

![2017-11-18 mirror_inclined_target F35_T75_G16_S225-10x10-2_D40](2017-11-18 mirror_inclined_target F35_T75_G16_S225-10x10-2_D40.png)

## 2017-11-19 Réglage verticalité de la tige cible

Réglagle de l'angle de la tige cible par rapport à la verticale pour maximiser l'echo à 150mm.

![](2017-11-19 reglage cible.jpg)

Le résultat obtenu est meilleur et comparable à la mesure sans miroir à tension et gain identiques.

![](2017-11-19 mirror_vertical_target F35_T50_G15_S225-10x10-2_D35.png)

## 2017-11-19 Mesures affichées en dB

![2017-11-19 mirror dB F35_T50_G15_S225-10x10-2_D35](2017-11-19 mirror dB F35_T50_G15_S225-10x10-2_D35.png)

## 2017-11-26 Ajout Lib plotly et mesure imasonic

![2017-11-27 35labo](2017-11-09 ensemble 2.jpg)

![2017-11-27 35labo](2017-11-27 35labo.png)

![2017-11-27 35labo](2017-11-27 35imasonic.png)

## 2017-11-24 Cible avec fil de nylon
![echo_bench_bow](echo_bench_bow.jpg)

![2017-11-24_archet](2017-11-24_archet.jpg)

![2017-11-24_archet2](2017-11-24_archet2.jpg)

## 2018-01-31 Connexion console par Bluetooth

D'après https://hacks.mozilla.org/2017/02/headless-raspberry-pi-configuration-over-bluetooth/
et https://github.com/DrRowland/RPi-Bluetooth-Console/blob/master/setup.sh

```
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install bluetooth bluez blueman
```


----
----
----
----
----
----
----
# Poubelle !!!

### Communication RPi / PyBoard

* Installer PySerial : 
  `python -m pip install pyserial`
* Installer le serveur Web Bottle et l'extension pour faire du WebSocket :
  `pip install bottle`  
  `pip install python-dev`
  `pip install gevent-websocket`



## Installation RPi

#### Mise à jour du système

​~~~~sh
sudo apt-get update
sudo apt-get upgrade
sudo rpi-update
sudo apt-get autoremove
​~~~~
=> avec rpi-update le firmware passe de   Linux raspberrypi 4.1.19-v7+ #858  à   rpi-4.4.y

Et reboot ! ... perte écran LCD :-(

### Config Samba



### Reconfiguration écran LCD

Atteindre le wiki Waveshare http://www.waveshare.com/wiki/3.5inch_RPi_LCD_\(A\) et télécharger la dernière version des drivers : http://www.waveshare.com/w/upload/3/3d/LCD-show-160811.tar.gz

Extraire l'archive dans `/home/pi/LCD-show` et :

​~~~~sh
cd LCD-show
./LCD35-show
​~~~~
  ```

  ```

```

```