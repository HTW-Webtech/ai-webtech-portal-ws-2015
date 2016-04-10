# Entwicklungsumgebung

In diesem Kurs werden Sie zu jeder Übung Programmcode schreiben, den Sie über
git verwalten und mit git-ssh auf den Aris-Server kopieren.

Für git-ssh und vor allem die Entwicklung der Ruby-Anwendungen in den späteren
Übungen werden entweder einige Einstellungen an Ihrem Arbeitsrechner benötigt
oder Sie nutzen ein vorkonfiguriertes [VirtualBox-Image](https://de.wikipedia.org/wiki/VirtualBox).


## Virtualbox-Image nutzen

Prinzipiell bleibt jedem Teilnehmer offen seine Entwicklungsumgebung selbst einzurichten.
Wenn Sie jedoch einen ausreichend leistungsstarken Computer haben, empfehle ich die
Nutzung der Virtualbox:

* [Anleitung zur Einrichtung der Virtualbox](01a-virtualbox.html)

Für diejenigen die auf die Virtualbox verzichen möchten ist die benötigte Software
im folgenden aufgelistet:

* Editor: Wahlweise [Atom](https://atom.io/) oder [Vim](http://www.vim.org/)
* Versionskontrolle: [Git: Version: 2.6.7)](https://git-scm.com)
* Optionale git GUI: [Git Cola](https://git-cola.github.io)
* Programmiersprache: [Ruby Version: 2.2.3p173](https://www.ruby-lang.org/en)
* Ruby Bibliotheken (gems): [Rails: Version: 4.2.6](http://rubyonrails.org/)
* Browser: [Google Chrome](https://www.google.com/chrome/)


### SSH Schlüssel erzeugen

Virtualbox-Nutzer müssen dies nicht beachten.

Falls Sie auf die Virtualbox verzichten, müssen Sie sich ein gültiges SSH
Schlüsselpaar erzeugen um mit git-ssh auf den Aris-Server zugreifen zu können.

Eine Anleitung für Windows und Mac-User finden Sie hier: [Github: Generating an SSH key](https://help.github.com/articles/generating-an-ssh-key/)


# Erstellen eines Aris-Accounts

Registrieren Sie sich mit Ihrer E-Mail Adresse der Hochschule (bspw. s*****@htw-berlin.de)
auf dem [Aris-Projektserver](http://admin.htw-webtech.com).


## SSH Schlüssel eintragen

Sobald Sie einen Account haben und eingeloggt sind, müssen Sie den öffentlichen
SSH Schlüssel in Ihrem Aris Profil hinterlegen

![Das Profil im Aris öffnen](exercises/setup/aris-setup1.png)

Kopieren Sie den vollständigen Schlüssel in das Textfeld.

![Public ssh key einfügen und speichern](exercises/setup/aris-setup2.png)

Als nächstes geht es weiter mit der [Übung zu *Git*](02-git.html).

