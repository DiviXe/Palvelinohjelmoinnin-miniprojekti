# Palvelinohjelmoinnin-miniprojekti (KESKEN VIELÄ, VOI MUUTTUA AJAN KANSSA) 
- Miniprojektissa tullaan käyttämään kolmea Ubuntu 20.04 konetta, ja yksi näistä toimii Masterina ja loput orjina.

# Mikä dilemma?!
- Ohjelmoijilla on pulaa saada ohjelmointi ympäristö sadalle koneelle (tässä vaiheessa ympäristö toteutetaan vain kahdelle koneelle programmer1 ja programmer2) 
- Masterkone tulee olemaan nimeltään programmerhost.
- Koneissa TÄYTYY olla Notepad++, Visualcode Studio ja yms. Toteutettu chocolateyllä. 


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

## Part 1: Back to the start
- Ensin luodaan vagrantfile, joka tekee meille kyseiset ubuntu 20.04 koneet.
- Mennään Hosti Windows koneella powershellillä hakemistoon C:\Users\vagrant\saltdemo
- Aloitetaan virtuaalikonedein boottaus komennolla vagrant up ja tämän jälkeen yritetään saada yhteys masteriin komennolla vagrant ssh tmaster
- Vagrantfile vielä tekeillä. 
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
- ![image](https://github.com/DiviXe/Palvelinohjelmoinnin-miniprojekti/assets/105793201/3a0d8ceb-4c4b-4666-a648-ffa95007b136)
- Kone raksuttaa mukavasti, kaikki näyttää olevan onnistuneesti asennettuna.
- ![image](https://github.com/DiviXe/Palvelinohjelmoinnin-miniprojekti/assets/105793201/773d82ab-b6c4-4d51-99f7-36a36d1764ce)
- Kokeillaan ottaa yhteys master koneeseen.
```
vagrant ssh programmerhost
```
- Yhdistäminen onnistunui, mutta (to be continued)
```
$ sudo salt-key -A
```
- Yhdistäminen 




## References
- https://terokarvinen.com/2023/palvelinten-hallinta-2023-kevat/, Tero Karvinen  Infra as Code
- https://terokarvinen.com/2023/salt-vagrant/, Tero Karvinen Salt Vagrant virtuaalikoneet
- https://terokarvinen.com/2018/control-windows-with-salt/, Tero Karvinen Control Windows With Salt
