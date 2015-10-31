# Allgemeines zu den Übungen
Alle Übungen/Lösungen dieser Veranstaltung werden via *Git* verwaltet. Für jede Übung wird dazu auf dem
[Aris Projekt-Server](http://admin.htw-webtech.com) eine *App* eingerichtet. Zu jeder App gehört ein
Git-Repository zu dem der Code für die jeweilige Übung hochgeladen wird.

![Schematische Darstellung von Aris](exercises/setup/aris-flow.png)

# Entwicklungsumgebung
Für die Bearbeitung der Übungen in dieser Veranstaltung wird eine vorkonfigurierte Entwicklungsumgebung auf
Basis von [VirtualBox](https://de.wikipedia.org/wiki/VirtualBox) bereitgestellt.

Prinzipiell bleibt jedem Student offen seine eigene Entwicklungsumgebung einzurichten. Der folgende Abschnitt
listet dazu die installierte Software-Konfiguration auf.

## Konfiguration
* Editor: [Atom](https://atom.io/)
* Versionskontrolle: [Git (Version: 2.6.7)](https://git-scm.com)
* GUI Versionskontrolle: [Git Cola](https://git-cola.github.io)
* Programmiersprache: [Ruby (Version: 2.2.3p173](https://www.ruby-lang.org/en)
* Browser: [Google Chrome](https://www.google.com/chrome/)

### Zugang
Login: student
Passwort: student


## Installation
1. Download der Virtualbox-Software (Version: 4.3.32)
  * [Windows](http://download.virtualbox.org/virtualbox/4.3.32/VirtualBox-4.3.32-103443-Win.exe)
  * [Mac OS X (Intel)](http://download.virtualbox.org/virtualbox/4.3.32/VirtualBox-4.3.32-103443-OSX.dmg)
  * [Ubunut 14.04](http://download.virtualbox.org/virtualbox/4.3.32/virtualbox-4.3_4.3.32-103443~Ubuntu~raring_amd64.deb)
  * [Weitere Betriebssyteme](http://download.virtualbox.org/virtualbox/4.3.32)
2. Download und Installation des [Virtualbox Extension Packs](http://download.virtualbox.org/virtualbox/4.3.32/Oracle_VM_VirtualBox_Extension_Pack-4.3.32-103443.vbox-extpack)
3. Download des [Virtualbox Images](http://files.htw-webtech.com/htw-webtech-ws-2015.ova)

### Import Virtualbox-Image
Nachdem das Virtualbox-Programm, sowie das VirtualBox Extension-Pack installiert haben, kann das heruntergeladene
Virtualbox-Image importiert werden.

[Import der Virtualbox](https://www.youtube.com/watch?v=wTp0XT43aqM)

Sobald die Virtualbox gestartet wurde, können Sie sich mit den [Zugangsdaten](#zugang) anmelden.


### Erzeugung von SSH-Keys
Für die Abgabe der Übungen wird Code mit *Git* über *SSH* auf den Aris-Server hochgeladen. Für die SSH-Authentifizierung
wird ein [Public-Key-Verfahren](https://en.wikipedia.org/wiki/Public-key_cryptography) eingesetzt, wofür einmalig ein
privater und öffentlicher Schlüssel generiert werden muss.

![Terminal öffnen und das `setup` script ausführen](exercises/setup/setup-ssh-key1.png)
![Den public ssh key kopieren](exercises/setup/setup-ssh-key2.png)

Der public key wird für den nächsten Schritt benötigt.


# Einreichen von Übungen
Zu den meisten Übungen wird HTML, CSS oder Ruby-Code geschrieben. Der Code wird via *Git* verwaltet. Zu jeder Übung wird
dazu im [Aris App-Management](http://aris.htw-webtech.com) eine eigene App verwaltet.

## Zugang zu Aris
Registrieren Sie sich mit Ihrer E-Mail Adresse der Hochschule (bspw. s00000@htw-berlin.de) unter <http://admin.htw-webtech.com/users/sign_up>

### Public ssh key im Profil hinterlegen
![Das Profil im Aris öffnen](exercises/setup/aris-setup1.png)
![Public ssh key einfügen und speichern](exercises/setup/aris-setup2.png)

### Die erste App für eine Übung anlegen
![Die erste App für Übung 1 anlegen](exercises/setup/aris-setup3.png)

Sobald der Account freigeschaltet ist, geht es weiter mit der [Übung zu *Git*](/site/exercises/git.html).

