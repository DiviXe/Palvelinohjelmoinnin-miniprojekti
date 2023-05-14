# Palvelinohjelmoinnin-miniprojekti Ohjelmisto ympäristö kuntoon ubuntu koneille 
- Miniprojektissa tullaan käyttämään kolmea Ubuntu 20.04 konetta, ja yksi näistä toimii Masterina ja loput orjina.

# Mikä dilemma?!
- Ohjelmoijilla on pulaa saada ohjelmointi ympäristö sadalle koneelle (tässä vaiheessa ympäristö toteutetaan vain kahdelle koneelle programmer1 ja programmer2) 
- Masterkone tulee olemaan nimeltään programmerhost.
- Koneissa TÄYTYY olla Notepadqq, Visualcode Studio (frond-endiin), Eclipse, Java-JDK17 ja postman.
- Tässä on kuva master koneesta ja sen ohjelmista.
- ![image](https://github.com/DiviXe/Palvelinohjelmoinnin-miniprojekti/assets/105793201/20d14ba5-cd25-4665-aae6-e5b87a120dea)
- Älkää välittäkö Vimistä.



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
 - Kopioidaan kyseinen vagrantfile tiedoston sisälle.
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
- Myöhemmin huomasin, että kyseessä voi sittenkin olla palomuuri ongemat eikä palvelun lisääminen.
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
- Käytetään tässä pkg.installia ja cmd.runia. 
- luodaan kansio programmerenvironment /srv/salt kansiostoon
- ![image](https://github.com/DiviXe/Palvelinohjelmoinnin-miniprojekti/assets/105793201/e21edaa9-43d2-47ae-a625-e54adbc944e6)
- luodaan kansiostoon init.sls tiedosto
- Jätämme init.sls tiedoston nyt tähän ja lähdemme itse asentamaan ohjelmia ensin master koneelle ja tätä mukaan varmistamme, että ohjelmat on asennettu oikein.
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
tässä oltaisiin voitu käyttää myös sudo snap install notepadqq. 
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
- Asennetaan vikaksi visualcode studio.
- Ubuntulle visualcoden asennus onkin vähän vaikeampaa, koska ubuntulle ei ole saatavilla pkg.installia visual codesta niin joudumme hakemaan .deb versio paketin netistä.
- koodi toimii seuraavanlaisesti:
```
//otetaan uusin visualcodestudion paketti, joka on linux käyttäjille saatavilla
wget https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64 -O code_1.78.1-1683194560_amd64.deb
Lisätään Microsoft VS Code -tietovarasto järjestelmääsi:
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
Tehdään päivitys ja ladataan koodi.
sudo apt update
sudo apt install code

```
```
vagrant@programmerhost:/srv/salt/programmerenvironment$ sudo nano init.sls
```
```init.sls
install_eclipse:
  pkg.installed:
    - name: eclipse

install_java:
  pkg.installed:
    - name: openjdk-17-jdk

install_postman:
  pkg.installed:
    - name: postman

install_notepadqq:
  pkg.installed:
    - name: notepadqq

install_postman:
  pkg.installed:
    - name: postman

install_vscode:
  pkg.installed:
    - name: code
    - refresh: True

configure_java:
  file.managed:
    - name: /etc/environment
    - source: salt://programmerenvironment/environment

configure_eclipse:
  file.managed:
    - name: /etc/eclipse.ini
    - source: salt://programmerenvironment/eclipse.ini

```
- openjdk17, javalle on tehty /srv/salt/environment teksti tiedosto: 
```
JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/
PATH="$JAVA_HOME/bin:$PATH"

Määrittämällä JAVA_HOME ja lisäämällä $JAVA_HOME/bin PATH-muuttujaan varmistat, että järjestelmä tietää JDK:n asennussijainnin ja voi käyttää Javan suoritettavia tiedostoja helposti.
(tässä voi olla ongelmia, katson ratkaisuja myöhemmin
```
- Tätä tarvitaan, että löydämme oikean java version, jonka lataamme minioneille. 
- Seuraavaksi etsitään meidän eclipse.ini tiedosto. 
- Eclipsemme sijaitsee kansiossa, **/var/snap/eclipse/current/** otamme tästä kansiosta eclipse.ini tieodoston ja kopiomme sen programmerenvironment salt tiedostoon.
- ![image](https://github.com/DiviXe/Palvelinohjelmoinnin-miniprojekti/assets/105793201/5f51a966-da37-47e8-b2f5-23dd5b73cdf6)
- Eclipsen inin etsiminen olikin vähän vaikeampaa kuin ajattelinkin, se olikin kansiossa /snap/eclipse/66/eclipse.ini
- Kopioidaan tiedosto
```
sudo cp /snap/eclipse/66/eclipse.ini /srv/salt/programmerenvironment/

```
-Lisäämme tämän, jos koneella olisi eclipsen sisäisiä ajatuksia niin eclipse.ini tiedosto toisi asetukset minion koneille.
- Kansiossa sijaitsee nyt eclipse.ini ja environment tiedosto.
- ![image](https://github.com/DiviXe/Palvelinohjelmoinnin-miniprojekti/assets/105793201/74bfcf50-5a5e-430e-a316-d7aab5981f03)
- Ladataan visulcode ubuntulle Visual studio Ubuntu ohjeiden mukaan.
```
sudo apt-get install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt install apt-transport-https
sudo apt update
sudo apt install code
```
- Koodi toimi!
- ![image](https://github.com/DiviXe/Palvelinohjelmoinnin-miniprojekti/assets/105793201/a5f9f948-b522-44a4-936e-a04d5694e6ad)
- 

- annetaan meidän /srv/salt/programer environment init tiedostolle nyt oikeudet.
```
sudo chmod +x init.sls
```
## Part 2 Prepare the minions!
```
sudo salt '*' state.apply saltenv=base
```
- Ongelmien ratkaisujen jälkeen koodi raksuttaa nyt minioneilla ja katsotaan mitä käy..
- Java-17 latautui onnistuneesti, javan-configure, notepadqq ja Eclipse
- Asiat mitkä eivät lataantuneet olivat postman, visual-code ja Eclipsen asetukset.
- Tässä on lopputulokset:
- ![image](https://github.com/DiviXe/Palvelinohjelmoinnin-miniprojekti/assets/105793201/2268132f-2787-4a74-bf2f-dbd61b083f6d)
- Run time oli tässä aika pitkä.. jopa 367 sekuntia eli 6 minuuttia. 
- Katsotaan missä ongelma oli..
- ajetaan koodi uudestaan tersellä.
```
sudo salt '*' state.highstate saltenv=base test=True --state-output=terse
```
- ![image](https://github.com/DiviXe/Palvelinohjelmoinnin-miniprojekti/assets/105793201/7ffbddc8-4545-4881-b468-6bcfdc2e2531)
- 3 unchanged eli eclipse, postman, visualcode eivät toimineet, eclipsen ini tiedosto kuitenkin tomimi.
- Eclipseä ei voinutkaan ladata pkg.installerilla, eikö myöskään postmania.
- Muutetaan init.sls tiedostoa seuraavanlaisesti:
- Uusia ongelmia programmer1, programmer2 koneilla ei ole mounttia.
```
PS C:\Users\vagrant\saltdemo> vagrant ssh programmer1
Last login: Fri May 12 18:12:46 2023 from 10.0.2.2
-bash: groups: command not found
Command 'lesspipe' is available in the following places
 * /bin/lesspipe
 * /usr/bin/lesspipe
The command could not be located because '/bin:/usr/bin' is not included in the PATH environment variable.
lesspipe: command not found
Command 'dircolors' is available in the following places
 * /bin/dircolors
 * /usr/bin/dircolors
The command could not be located because '/bin:/usr/bin' is not included in the PATH environment variable.
dircolors: command not found
```
- Jouduin manuaalisesti luomaan path variablen molemmile koneille:
```
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
Tämän jälkeen komennot: 
sudo apt-get update
sudo apt-get install sudo util-linux
Get:1 http://us.archive.ubuntu.com/ubuntu focal-updates/main amd64 sudo amd64 1.8.31-1ubuntu1.5 [515 kB]
Fetched 515 kB in 1s (569 kB/s)
(Reading database ... 150840 files and directories currently installed.)
Preparing to unpack .../sudo_1.8.31-1ubuntu1.5_amd64.deb ...
Unpacking sudo (1.8.31-1ubuntu1.5) over (1.8.31-1ubuntu1.4) ...
Setting up sudo (1.8.31-1ubuntu1.5) ...
Processing triggers for man-db (2.9.1-1) ...
```
- Ei vieläkään onnistunut, poistetaan vscode, eclipse ja postman latauksista ja kokeillaan uudestaan.
- kokeillaan uudestaan sudo salt '*' state.highstate saltenv=base test=True --state-output=terse
- Mikään ei ole muuttunut, eli koodi on silti idempotenttinen.
- ![image](https://github.com/DiviXe/Palvelinohjelmoinnin-miniprojekti/assets/105793201/9b588785-1ba4-40d0-88ab-fcda70f4fafa)
- Java on asennettuna, notepadqq, java environment ja eclipse asetukset..
- Visual code asennettiin cmd.runin kautta kyseiselle koodilla:
```
sudo snap install --classic code
```
- ![image](https://github.com/DiviXe/Palvelinohjelmoinnin-miniprojekti/assets/105793201/eb2889a4-fbe3-4b2d-87c0-8b74ad829419)
- Post man to go! Eclipsekin on asennettu onnistuneesti.
- ![image](https://github.com/DiviXe/Palvelinohjelmoinnin-miniprojekti/assets/105793201/862916c9-a4a7-42e9-aa79-23797e9efbc7)
- Katsotaan mikä java-version on asennettuna programmer1 ja programmer2 koneille.
```
- sudo salt '*' cmd.run 'java --version'
```
- java 17 se siellä! 
- ![image](https://github.com/DiviXe/Palvelinohjelmoinnin-miniprojekti/assets/105793201/23d67fd4-983e-472f-9840-1743b99e534c)
## References
- https://terokarvinen.com/2023/palvelinten-hallinta-2023-kevat/, Tero Karvinen  Infra as Code
- https://terokarvinen.com/2023/salt-vagrant/, Tero Karvinen Salt Vagrant virtuaalikoneet
- https://terokarvinen.com/2018/control-windows-with-salt/, Tero Karvinen Control Windows With Salt
- https://docs.saltproject.io/salt/install-guide/en/latest/topics/install-by-operating-system/ubuntu.html#install-salt-on-ubuntu-20-04-focal, Salt for Ubuntu 20.04
https://code.visualstudio.com/docs/?dv=linux64_deb, visual code for ubuntu
https://code.visualstudio.com/docs/setup/linux, Visualcode for ubuntu docs 
https://stackoverflow.com/questions/35641991/invalid-configured-shell-error-when-running-the-official-freebsd-vagrant-box ssh shell issue fix on vagrantfile
https://linuxize.com/post/how-to-install-postman-on-ubuntu-20-04/ postman for ubuntu
https://askubuntu.com/questions/1231410/cant-log-in-on-ubuntu-20-04, cant log in to ubuntu
https://askubuntu.com/questions/452488/the-command-could-not-be-located-because-usr-bin-is-not-included-in-the-path, The command could not be located because '/usr/bin' is not included in the PATH environment variable [duplicate]
https://askubuntu.com/questions/338726/cant-execute-terminal-commands-the-command-sudo-is-available-in-usr-bin-s/338728#338728, Can't execute terminal commands: "the command 'sudo' is available in '/usr/bin/sudo'"

