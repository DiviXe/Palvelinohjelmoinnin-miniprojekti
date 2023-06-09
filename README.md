# Palvelinohjelmoinnin-miniprojekti Ohjelmisto ympäristö kuntoon ubuntu 20.04 koneille 
- Miniprojektissa tullaan käyttämään kolmea Ubuntu 20.04 konetta, ja yksi näistä toimii Masterina ja loput orjina.
- Miksi ihmeessä ubuntu versio 20.04? 
- vapaa ja pitkäaikainen tuki
- laaja yhteensopivuus
- ubuntu 20.04 on vieläkin todella suosittu, koska tälle kyseiselle versiolle löytää paljon tietoa salt configuraatioista.

# Mikä dilemma?!
- Ohjelmoijilla on pulaa saada ohjelmointi ympäristö sadalle koneelle (tässä vaiheessa ympäristö toteutetaan vain kahdelle koneelle programmer1 ja programmer2) 
- Masterkone tulee olemaan nimeltään programmerhost.
- Koneissa TÄYTYY olla Notepadqq, Visualcode Studio (frond-endiin), Eclipse, Java-JDK17 ja postman.
- Tässä on kuva master koneesta ja sen ohjelmista.
- ![image](https://github.com/DiviXe/Palvelinohjelmoinnin-miniprojekti/assets/105793201/20d14ba5-cd25-4665-aae6-e5b87a120dea)

# Virtuaalikoneet Programmer1 ja Programmer2
- Virtuaalikoneiden luomiseen käytössä Oracle VM VirtualBox
- käytössä KAKSI corea per kone
- 256mb video memory
- 4GB ramia
- 128GB HDD (käytössä noin 5-7gb asennusten jälkeen)
- OS: Ubuntu 20.04

# Virtuaalikone programmerhost
- Virtuaalikoneiden luomiseen käytössä Oracle VM VirtualBox
- käytössä KAKSI corea
- 256mb video memory
- 2GB ramia
- 128GB HDD (käytössä noin 5-7gb asennusten jälkeen)
- OS: Ubuntu 20.04

# Host kone ympäristö
- GPU: Rtx 3070 TI
- CPU: i7-9700k 
- RAM: 32GB
- OS: Windows 10 Pro 


## Part 1: Back to the start luodaan kehitysympäristö
- Ensin luodaan vagrantfile, joka tekee meille kyseiset ubuntu 20.04 koneet.
- Mennään Hosti Windows koneella powershellillä hakemistoon.
 ```
C:\Users\vagrant\saltdemo
 ```
- Kopioidaan kyseinen vagrantfile tiedoston sisälle.
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
- Kaikki näyttää hyvältä, eikun eteenpäin!

## Part 2: downloading.. Ensin käsin, sitten automaattisesti.
- Aloitetaan luomalla saltiin kansiosto, johon laitamme scriptejä.
- Ensin kuitenkin tehdään koodit käsin, sitten laitamme ne minioneille myöhemmin kuin asennukset mastereille toimii.
- Käytetään tässä pkg.installia ja cmd.runia
- HUOM. yritin käyttää snap.installedia init.sls tiedostossa, mutta se ei toiminut. Yritin myös asentaa saltiin kyseisen paketin, mutta ei toiminut. Ajan takia en kerinnyt lähteä selvittämään asiaa.
- luodaan kansio programmerenvironment /srv/salt kansiostoon, joka on valmiiksi luotuna vagrantfilessä.
- ![image](https://github.com/DiviXe/Palvelinohjelmoinnin-miniprojekti/assets/105793201/e21edaa9-43d2-47ae-a625-e54adbc944e6)
- luodaan kansiostoon init.sls tiedosto
```
sudo nano init.sls
```
- Jätämme init.sls tiedoston nyt tähän ja lähdemme itse asentamaan ohjelmia ensin master koneelle ja tätä mukaan varmistamme, että ohjelmat on asennettu oikein.
- Asennamme master koneelle ensiksi Javan, Eclipsen, notepadqq, Postmanin ja Visualcode studion.
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
- TAI
``` 
sudo snap install notepadqq
``` 
- Notepadqq onnistuneesti asennettu programermasterille
-![image](https://github.com/DiviXe/Palvelinohjelmoinnin-miniprojekti/assets/105793201/50bee738-7c3c-40cf-ab24-b70b5168e3f1)
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
- Tai
```
 sudo snap install --code
```
- ![image](https://github.com/DiviXe/Palvelinohjelmoinnin-miniprojekti/assets/105793201/9356f356-7f39-41de-86a9-8638d9528432)
- Tässäkin oltaisiin voittaa käyttää snap installeria, joka tuleekin minioneille. 
- Täytetään init.sls tiedosto seuraavilla komennoilla:
```
vagrant@programmerhost:/srv/salt/programmerenvironment$ sudo nano init.sls
```
```init.sls
install_eclipse:
  cmd.run:
    - name: sudo snap install --classic eclipse
    - unless: snap list eclipse

install_java:
  pkg.installed:
    - name: openjdk-17-jdk

install_postman:
  cmd.run:
    - name: sudo snap install postman
    - unless: snap list postman

install_notepadqq:
  pkg.installed:
    - name: notepadqq

install_vscode:
  cmd.run:
    - name: sudo snap install --classic code
    - unless: snap list code

configure_eclipse:
  file.managed:
    - name: /etc/eclipse.ini
    - source: salt://programmerenvironment/eclipse.ini

```
- cmd.run komennoista on tehty IDEMPOTENTTISIA, unlessin avulla "unless tiedosto löytyy niin tiedostosta tulee idempotenttinen.
- Eclipsemme sijaitsee kansiossa, **/var/snap/eclipse/current/** otamme tästä kansiosta eclipse.ini tieodoston ja kopiomme sen programmerenvironment salt tiedostoon.
- ![image](https://github.com/DiviXe/Palvelinohjelmoinnin-miniprojekti/assets/105793201/5f51a966-da37-47e8-b2f5-23dd5b73cdf6)
- Eclipsen inin etsiminen olikin vähän vaikeampaa kuin ajattelinkin, se olikin kansiossa /snap/eclipse/66/eclipse.ini
- Kopioidaan tiedosto
```
sudo cp /snap/eclipse/66/eclipse.ini /srv/salt/programmerenvironment/

```
-Lisäämme tämän, jos koneella olisi eclipsen sisäisiä ajatuksia niin eclipse.ini tiedosto toisi asetukset minion koneille.
- Kansiossa sijaitsee nyt eclipse.ini ja init.sls tiedosto.
- ![image](https://github.com/DiviXe/Palvelinohjelmoinnin-miniprojekti/assets/105793201/74bfcf50-5a5e-430e-a316-d7aab5981f03)
- annetaan meidän /srv/salt/programer environment init tiedostolle nyt oikeudet.
```
sudo chmod +x init.sls
# muutetaan käyttöoikeuksia komennolla "chmod" ja +x tarkoittaa, että tiedostolla on ajo-oikeus.
```
## Part 2 Prepare the minions!
- Tehdään top.sls tiedosto /srv/salt kansiostoon joka on seuraavalainen:
```
base:
  '*':
    - programmerenvironment.init
```
- Tämä ajaa molemmat koodit järjestyksessä käyttämällä state.applya
```
sudo salt '*' state.apply saltenv=base --state-output=terse
top.sls "base": on erikseen, koska ajamme myöhemmin kahta eri tiedostoa.
```
- Ongelmien ratkaisujen jälkeen koodi raksuttaa nyt minioneilla ja katsotaan mitä käy..
- Kaikki lataukset on nyt onnistuneesti latautunut. 
- Tässä on lopputulokset:
- ![image](https://github.com/DiviXe/Palvelinohjelmoinnin-miniprojekti/assets/105793201/a4128def-7b77-4ddf-8d5b-6a97eb8e43c6)
- Run time oli tässä aika pitkä, minun netilläni lataus kesti noin 15-20 minuutia.
- Koodi on nyt idempotenttinen.
- Eclipseä ei pystynyt lataamaan pkg.installerilla, eikö myöskään postmania eikä visualcode studiota, tämän takia käytäämme "ghetto" tyylillä cmd.runia joissakin tilanteissa.
- Java on asennettuna, notepadqt ja eclipse asetukset..

## part 3 esimerkki java helloSalt
- Esimerkkinä on se, että java hello world toimii. 
- Eclipsen versiota ei voida näyttää eclipse --version komennolla, eikä myöskään postman tai notepadqq toimi koska tämä komento avaa itse sovellukset, joten esimerkki testinä on Javan verio ja testikoodi. 
- Esimerkki testi:
```  
copy_hello_salt:
  file.managed:
    - name: /usr/local/bin/HelloSalt.class
    - source: salt://programmerenvironment/HelloSalt.class
    - mode: "0755"
```
- Tehdään testversion.sls tiedosto, joka ajaa versiot läpi kansiostoon /srv/salt/programmerenvironment ja annetaan tiedostolle kyseiset oikeudet:
```
sudo nano testversion.sls
sudo chmod +x testversion.sls

```
- lisätään testversion top.sls tiedostoon
```
base:
  '*':
    - programmerenvironment.init
    - programmerenvironment.testversion
```
- Seuraavaksi tehdään testi java koodi, joka on vastaava nimeltään HelloSalt.java
```
public class HelloSalt {
    public static void main(String[] args) {
        System.out.println("Hello, SaltStack!");
    }
}
```
- annetaan koodille myös oikeudet!
```
sudo chmod o+w HelloSalt.java
# o+w tarkoittaa other(users) käyttäjät + write permit eli kirjoitus oikeus.
# compiling code:
 javac HelloSalt.java
# testing code:
java HelloSalt
```
- koodi toimii!
- ![image](https://github.com/DiviXe/Palvelinohjelmoinnin-miniprojekti/assets/105793201/f698c4aa-e005-488a-ab1e-000871d75747)
- nyt kokeillaan koodia komennolla 
```
sudo salt '*' cmd.run 'java -cp /usr/local/bin HelloSalt'
```
- Koodi toimii!
- ![image](https://github.com/DiviXe/Palvelinohjelmoinnin-miniprojekti/assets/105793201/b209f779-7165-4f2a-b36a-bb6577544727)
- katsotaan vielä kaikki komennot tersellä.
- En saanut cmd.runia java koodin ajamiseen idempotenttiseksi, niin päätin ajaa sen saltin kautta.
- kaikki toiminnassa.
- Kaikki koodit ovat idempotenttisia.
- ![image](https://github.com/DiviXe/Palvelinohjelmoinnin-miniprojekti/assets/105793201/db24b6c2-ff31-47e7-8f3d-0f0cbb158c03)
- loppukuva virtuaalimasiinasta
- ![image](https://github.com/DiviXe/Palvelinohjelmoinnin-miniprojekti/assets/105793201/770e74a5-6590-4c69-bd56-1e853d5945a3)
- Tässä tältä kertaa!

## References
- https://terokarvinen.com/2023/palvelinten-hallinta-2023-kevat/, Tero Karvinen  Infra as Code
- https://terokarvinen.com/2023/salt-vagrant/, Tero Karvinen Salt Vagrant virtuaalikoneet
- https://terokarvinen.com/2018/control-windows-with-salt/, Tero Karvinen Control Windows With Salt
- https://docs.saltproject.io/salt/install-guide/en/latest/topics/install-by-operating-system/ubuntu.html#install-salt-on-ubuntu-20-04-focal, Salt for Ubuntu 20.04
- https://code.visualstudio.com/docs/?dv=linux64_deb, visual code for ubuntu
- https://code.visualstudio.com/docs/setup/linux, Visualcode for ubuntu docs 
- https://stackoverflow.com/questions/35641991/invalid-configured-shell-error-when-running-the-official-freebsd-vagrant-box ssh shell issue fix on vagrantfile
- https://linuxize.com/post/how-to-install-postman-on-ubuntu-20-04/ postman for ubuntu
- https://askubuntu.com/questions/1231410/cant-log-in-on-ubuntu-20-04, cant log in to ubuntu
- https://askubuntu.com/questions/452488/the-command-could-not-be-located-because-usr-bin-is-not-included-in-the-path, The command could not be located because '/usr/bin' is not included in the PATH environment variable [duplicate]
- https://askubuntu.com/questions/338726/cant-execute-terminal-commands-the-command-sudo-is-available-in-usr-bin-s/338728#338728, Can't execute terminal commands: "the command 'sudo' is available in '/usr/bin/sudo'"

