# Palvelinohjelmoinnin-miniprojekti
- Miniprojektissa tullaan käyttämään kolmea Ubuntu 20.04 konetta, ja yksi näistä toimii Masterina ja loput orjina.

# Mikä dilemma?!
- Ohjelmoijilla on pulaa saada ohjelmointi ympäristö sadalle koneelle (tässä vaiheessa ympäristö toteutetaan kahdelle koneelle programmer1 ja programmer2) Hosti kone tulee olemaan nimeltään programmerhost.
- Koneissa TÄYTYY olla Notepad++, Visualcode Studio ja yms. Toteutettu chocolateyllä. 


# Host kone ympäristö
- GPU: Rtx 3070 TI
- CPU: i7-9700k 
- RAM: 32GB
- OS: Windows 10 Pro 

# Virtuaalikoneilla on Käytössä Oracle VM VirtualBox

## Part 1: Back to the start
- Ensin luodaan vagrantfile, joka tekee meille kyseiset ubuntu 20.04 koneet.


## References
- https://terokarvinen.com/2023/palvelinten-hallinta-2023-kevat/, Tero Karvinen  Infra as Code
- https://terokarvinen.com/2023/salt-vagrant/, Tero Karvinen Salt Vagrant virtuaalikoneet
- https://terokarvinen.com/2018/control-windows-with-salt/, Tero Karvinen Control Windows With Salt
