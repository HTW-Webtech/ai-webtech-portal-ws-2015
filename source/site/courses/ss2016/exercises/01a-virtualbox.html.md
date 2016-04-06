# Virtualbox als Entwicklungsumgebung nutzen

Die folgenden Schritte, insbesondere der Software-Download, können viel Zeit in
Anspruch nehmen.

Während Sie auf den Download warten, können Sie sich bereits einen
[Aris-Account erstellen](01-setup.html#erstellen-eines-aris-accounts).

1. Download der Virtualbox-Software (Version: 4.3.32)
  * [Windows](http://download.virtualbox.org/virtualbox/4.3.32/VirtualBox-4.3.32-103443-Win.exe)
  * [Mac OS X (Intel)](http://download.virtualbox.org/virtualbox/4.3.32/VirtualBox-4.3.32-103443-OSX.dmg)
  * [Ubunut 14.04](http://download.virtualbox.org/virtualbox/4.3.32/virtualbox-4.3_4.3.32-103443~Ubuntu~raring_amd64.deb)
  * [Weitere Betriebssyteme](http://download.virtualbox.org/virtualbox/4.3.32)
2. Download und Installation des [Virtualbox Extension Packs](http://download.virtualbox.org/virtualbox/4.3.32/Oracle_VM_VirtualBox_Extension_Pack-4.3.32-103443.vbox-extpack)
3. Download des Virtualbox Images für den aktuellen Kurs im [Download-Bereich](http://files.htw-webtech.com/)


## Import Virtualbox-Image

Nachdem das Virtualbox-Programm, sowie das VirtualBox Extension-Pack installiert
wurde, kann das heruntergeladene Virtualbox-Image importiert werden.

Ein [Youtube-Video](https://www.youtube.com/watch?v=wTp0XT43aqM) zeigt wie das
Virtualbox-Image importiert wird.


## Zugangsdaten

Sobald die Virtualbox gestartet wurde, können Sie sich mit den folgenden Zugangsdaten anmelden:

~~~
Login: student
Password: student
~~~


## Erzeugung von SSH-Keys

Nach dem ersten Start der Virtualbox müssen Sie noch das `setup`-Kommando ausführen.

Das `setup`-Kommando erzeugt ein [SSH](https://de.wikipedia.org/wiki/Secure_Shell) Schlüsselpaar um den Zugriff
zum Aris-Server via [Public-Key-Verfahren](https://en.wikipedia.org/wiki/Public-key_cryptography) zu ermöglichen.

![Terminal öffnen und das `setup` script ausführen](exercises/setup/setup-ssh-key1.png)
![Den public ssh key kopieren](exercises/setup/setup-ssh-key2.png)

Diese kryptische Zeichenkette ist nun der öffentliche SSH Schlüssel, der im
nächsten Schritt in Ihrem Profil auf dem Aris-Server eingetragen werden muss.

Kopieren Sie sich diesen öffentlichen Schlüssel bspw. in eine Textdatei außerhalb
der Virtualbox. Weiter geht es mit der [Einrichtung Ihres Aris-Accounts](01-setup.html#erstellen-eines-aris-accounts)
