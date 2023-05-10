# Palvelinohjelmoinnin-miniprojekti (KESKEN VIELÄ, VOI MUUTTUA AJAN KANSSA) 
- Miniprojektissa tullaan käyttämään kolmea Ubuntu 20.04 konetta, ja yksi näistä toimii Masterina ja loput orjina.

# Mikä dilemma?!
- Ohjelmoijilla on pulaa saada ohjelmointi ympäristö sadalle koneelle (tässä vaiheessa ympäristö toteutetaan vain kahdelle koneelle programmer1 ja programmer2) 
- Masterkone tulee olemaan nimeltään programmerhost.
- Koneissa TÄYTYY olla Notepad++, Visualcode Studio (frond-endiin), Eclipse ja Java-JDK17


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
- (to be continued)




## References
- https://terokarvinen.com/2023/palvelinten-hallinta-2023-kevat/, Tero Karvinen  Infra as Code
- https://terokarvinen.com/2023/salt-vagrant/, Tero Karvinen Salt Vagrant virtuaalikoneet
- https://terokarvinen.com/2018/control-windows-with-salt/, Tero Karvinen Control Windows With Salt
- https://docs.saltproject.io/salt/install-guide/en/latest/topics/install-by-operating-system/ubuntu.html#install-salt-on-ubuntu-20-04-focal, Salt for Ubuntu 20.04
