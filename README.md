# Palvelinohjelmoinnin-miniprojekti (KESKEN VIELÄ, VOI MUUTTUA AJAN KANSSA) 
- Miniprojektissa tullaan käyttämään kolmea Ubuntu 20.04 konetta, ja yksi näistä toimii Masterina ja loput orjina.

# Mikä dilemma?!
- Ohjelmoijilla on pulaa saada ohjelmointi ympäristö sadalle koneelle (tässä vaiheessa ympäristö toteutetaan vain kahdelle koneelle programmer1 ja programmer2) 
- Masterkone tulee olemaan nimeltään programmerhost.
- Koneissa TÄYTYY olla Notepadqq, Visualcode Studio (frond-endiin), Eclipse ja Java-JDK17


# Host kone ympäristö
- GPU: Rtx 3070 TI
- CPU: i7-9700k 
- RAM: 32GB
- OS: Windows 10 Pro 

# Virtuaalikoneet Programmer1 ja Programmer2
- Virtuaalikoneiden luomiseen käytössä Oracle VM VirtualBox
- käytössä KAKSI corea per kone
- 256mb video memory
- 4GB ramia
- 128GB HDD
- OS: Ubuntu 20.04

# Virtuaalikone programmerhost
- Virtuaalikoneiden luomiseen käytössä Oracle VM VirtualBox
- käytössä KAKSI corea
- 256mb video memory
- 2GB ramia
- 128GB HDD
- OS: Ubuntu 20.04

## Part 1: Back to the start luodaan kehitysympäristö
- Ensin luodaan vagrantfile, joka tekee meille kyseiset ubuntu 20.04 koneet.
- Mennään Hosti Windows koneella powershellillä hakemistoon 
 ```
C:\Users\vagrant\saltdemo
 ```
 - Vagrantfilessä oli paljon muunneltavaa, koska kyseessä oli ubuntu koneet, onneksi saltprojectin sivuilla on selvät ohjeet, voidaan käydä katsomassa vagrantfileä. 
 - 
- Aloitetaan virtuaalikonedein boottaus komennolla **vagrant up**
- Ensimmäinen Error vagrant filen kanssa
```
"schannel: next InitializeSecurityContext failed: Unknown error (0x80092012) - The revocation function was unable to check revocation for the certificate."
```
- Vissiin ubuntun lisääminen vagrantilla ei onnistunut, noh lisäsin sen manuaalisesti komennolla  vagrant box add generic/ubuntu2004, jonka jälkeen tuli viesti:



```
This box can work with multiple providers! The providers that it
can work with are listed below. Please review the list and choose
the provider you will be working with.

1) hyperv
2) libvirt
3) parallels
4) virtualbox
5) vmware_desktop
```

- Valitsin vaihtoehdon 4 ja kokeilen koneiden boottamista uudestaan.  **box: Successfully added box 'generic/ubuntu2004' (v4.2.16) for 'virtualbox'!**
- kokeillaan vagrant up uudestaan. Koneet lähti lataukseen ja nyt ne ovat päällä!
- ![image](https://github.com/DiviXe/Palvelinohjelmoinnin-miniprojekti/assets/105793201/20ead284-1a35-4ecf-8217-e33e8a46ccc3)
- Kone raksuttaa mukavasti, kaikki näyttää olevan onnistuneesti asennettuna.
- ![image](https://github.com/DiviXe/Palvelinohjelmoinnin-miniprojekti/assets/105793201/a09dea1a-9004-4851-84b0-4b0f3f6cef63)

- Kokeillaan ottaa yhteys master koneeseen.
```
vagrant ssh programmerhost
```
- Yhdistäminen onnistunui, katsotaan samalla avaimet ja pingataan koneita, jotta tiedämme, että ne ovat oikeasti "hengissä"
- ![image](https://github.com/DiviXe/Palvelinohjelmoinnin-miniprojekti/assets/105793201/a02d1e4c-db1e-4f25-be2e-66a71c977c8c)
- Kaikki näyttä hyvältä, eikun eteenpäin!

## Part 2: downloading.. Ensin käsin, sitten automaattisesti.
- Aloitetaan luomalla saltiin kansiosto, johon laitamme scriptejä.
- Ensin kuitenkin tehdään koodit käsin, sitten laitamme ne minioneille myöhemmin kuin asennukset mastereille toimii.
- Käytetään tässä pkg.installia.
- luodaan kansio programmerenvironment /srv/salt kansiostoon
- ![image](https://github.com/DiviXe/Palvelinohjelmoinnin-miniprojekti/assets/105793201/e21edaa9-43d2-47ae-a625-e54adbc944e6)
- luodaan kansiostoon init.sls tiedosto
```
vagrant@programmerhost:/srv/salt/programmerenvironment$ sudo nano init.sls
```
- Asennamme master koneelle ensiksi Javan, Eclipsen, notepad ++, Postmanin ja Visualcode studion.
- -Ensiksi ladataan opendjk-17-jdk koneelle sudo apt installerilla. 
```
sudo apt update
sudo apt install openjdk-17-jdk
java -version
```
- ![image](https://github.com/DiviXe/Palvelinohjelmoinnin-miniprojekti/assets/105793201/18767c50-2402-4acf-a535-c4c70dced98c)
- Lataus onnistui.
- Asennetaan seuraavaksi notepadqq
``` 
//Tämä komento lisää notepadqq-ohjelmiston tiimin omistaman henkilökohtaisen pakettivaraston (Personal Package Archive, PPA) Ubuntu-järjestelmään. PPA:sta voi asentaa ohjelmistoversioita, jotka eivät ole saatavilla virallisista Ubuntu-pakettivarastoista. Komennolla voidaan helposti päivittää tai poistaa notepadqq-ohjelmisto tarvittaessa.
sudo add-apt-repository ppa:notepadqq-team/notepadqq
sudo apt-get update
sudo apt-get install notepadqq
``` 
- Notepadqq onnistuneesti asennettu programermasterille
- ![image](https://github.com/DiviXe/Palvelinohjelmoinnin-miniprojekti/assets/105793201/e07a2a75-1839-4230-936f-3bee6cb872ea)
- Asennettuna, mutta tulee jotain erroreita (selvitän myöhemmin)
- Asennetaan seuraavaksi Postman
``` 
sudo snap install postman
``` 
- ![image](https://github.com/DiviXe/Palvelinohjelmoinnin-miniprojekti/assets/105793201/91af847f-195e-4774-a8e6-6bd0ddaed827)
- ![image](https://github.com/DiviXe/Palvelinohjelmoinnin-miniprojekti/assets/105793201/b86633d9-cfea-4182-868e-1ad052b7bf7c)
- Postman on nyt onnistuneesti asennettu.
- Lopuksi Eclipse. 
``` 
sudo snap install --classic eclipse
``` 
- ![image](https://github.com/DiviXe/Palvelinohjelmoinnin-miniprojekti/assets/105793201/0000a892-c540-4e53-9463-9ca0e824173b)
- Eclipsen asennus onnistui

- 
``` init.sls
install_eclipse:
  pkg.installed:
    - name: eclipse

install_java:
  pkg.installed:
    - name: openjdk-17-jdk

install_notepadqq:
  pkg.installed:
    - name: notepadqq

install_postman:
  pkg.installed:
    - name: postman

install_notepadqq:
  pkg.installed:
    - name: notepadqq

install_postman:
  pkg.installed:
    - name: postman
configure_java:
  file.managed:
    - name: /etc/environment
    - source: salt://coming

configure_eclipse:
  file.managed:
    - name: /etc/eclipse.ini
    - source: salt://coming

configure_notepadqq:
  file.managed:
    - name: /path/to/notepadqq/config/file
    - source: salt://coming

configure_postman:
  file.managed:
    - name: /path/to/postman/config/file
    - source: salt://coming
- annetaan oikeudet kansiolle 
```
sudo chmod +x init.sls
```
-Ensiksi ladataan opendjk-17-jdk koneelle sudo apt installerilla. 

- Kaikki onnistui 
## References
- https://terokarvinen.com/2023/palvelinten-hallinta-2023-kevat/, Tero Karvinen  Infra as Code
- https://terokarvinen.com/2023/salt-vagrant/, Tero Karvinen Salt Vagrant virtuaalikoneet
- https://terokarvinen.com/2018/control-windows-with-salt/, Tero Karvinen Control Windows With Salt
- https://docs.saltproject.io/salt/install-guide/en/latest/topics/install-by-operating-system/ubuntu.html#install-salt-on-ubuntu-20-04-focal, Salt for Ubuntu 20.04
