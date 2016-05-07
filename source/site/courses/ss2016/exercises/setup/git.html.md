# Git-Übung

In dieser Übung werden Sie mit *git* und Aris die erste Webseite bauen.
Dazu gehören die folgenden Schritte:

* [Konfiguration von git](#konfiguration)
* [Erstellen einer App in aris](#aris-app)
* [Erzeugen eines neuen git-repositories](#git-repository)
* [Der erste git commit](#erster-git-commit)
* [Code via git push auf Aris kopieren](#push-git-changes)


# Konfiguration

Jeder *commit* in git enthält Informationen über den Author. Der folgende Befehl
fragt git nach dem aktuellen Author-Informationen.

~~~
git config --get-regexp user
~~~
{: .lang-bash }

Um Git nun den richtigen Author (Deinen Namen und Deine E-Mail Adresse) mitzuteilen:

~~~
git config --global user.name "Max Mustermann"         # Der richtige Name
git config --global user.email "s000001@htw-berlin.de" # E-Mail mit Matrikelnummer
~~~
{: .lang-bash }

Um zu prüfen, ob die Einstellungen übernommen wurden, erneut die Author-Informationen
abfragen:

~~~
git config --get-regexp user
~~~
{: .lang-bash }


Das Ergebnis sollten jetzt der angegebene Name und E-Mail-Adresse sein.

~~~
user.name Max Mustermann
user.email s000001-berlin.de
~~~
{: .lang-bash }


# Aris App

Nachdem Sie Ihre Entwicklungsumgebung vorbereitet haben, Git konfiguriert und einen
Aris Account erstellt haben, kann auch schon die erste Webseite auf den Aris Server
hochgeladen werden.

1. Im Aris die erste *App* erstellen
1. Ein neues Projekt-Verzeichnis anlegen
1. In diesem (noch leeren) Projekt-Verzeichnis ein git Repository erzeugen
1. Das lokale Repository mit den git-ssh Daten aus der Aris App konfigurieren
1. Ein neues Dokument (index.html) im git Repository einchecken
1. Das lokale git Repository via git-ssh zum Aris Server hochladen


## Im Aris eine App erstellen

Melden Sie sich im [Aris](http://admin.htw-webtech.com/) an und erstellen Sie Ihre
erste App.

Stellen Sie sicher, dass die App Ihren lokalen im SSH konfigurierten öffentlichen
Schlüssel eingetragen hat.

![So sieht bspw. eine neu erstelle App aus](exercises/setup/aris-setup3.png)

So sieht bspw. eine neu erstellte App aus.


## Neues Projekt-Verzeichnis und git konfigurieren

Legen Sie nun für die 1. Aufgabe ein neues leeres Projekt-Verzeichnis an und
erzeugen Sie ein leeres neues git Repository:

~~~
mkdir aufgabe1
cd aufgabe1
git init
~~~
{: .lang-bash }

Konfigurieren Sie das neu angelegte git Repository mit den *Git access* Daten
aus der vormals erzeugten Aris App.

~~~
git remote add origin ssh://********@htw-webtech.com/var/apps/*********/code
~~~
{: .lang-bash }

Jetzt ist ihr lokales git Repository mit einem git Repository auf dem Server
verknüpft.


### HTML-Dokument im git einchecken

Erzeugen Sie als nächtes in demselben Verzeichnis - dem Working Directory von git -
ein HTML-Dokument (index.html) mit dem folgenden Inhalt:

~~~
<!DOCTYPE html>
<html>
<body>
  <h1>Hat geklappt!</h1>
</body>
</html>
~~~
{: .lang-html }

Mit dem `git status`-Befehl lässt sich anziegen, dass git diese noch unbekannte
Datei nun gerne im Repository verwalten möchte.

~~~
git status
~~~
{: .lang-bash }

Mit dem folgenden Befehl wird das HTML-Dokument in die Staging von git kopiert.

~~~
git add index.html
~~~
{: .lang-bash }

Und anschließen kann git mitgeteilt werden aus allen Dateien in der Staging area
einen commit zu erzeugen. Das `-m`-Flag soll eine kurze inhaltliche Beschreibung
der Änderung sein. In diesem Fall wurde die das HTML-Dokument hinzugefügt.

~~~
git commit -m "Added index.html"
~~~
{: .lang-bash }


### Lokales git Repository zum Aris server synchronisieren

Nun kann die Änderung von gerade eben auf den Aris Server kopiert werden. Dies
geschieht einfach mit dem `git push`-Befehl.

~~~
git push origin master --set-upstream
~~~
{: .lang-bash }

Das `--set-upstream`-Flag muss nur beim ersten `git push` benutzt werden. Alle
Folgeänderungen werden ohne `--set-upstream` auf den Server kopiert.

~~~
git push origin master
~~~
{: .lang-bash }

Wenn der push funktioniert hat, kann nun die Webseite im Aris geöffnet werden:

![Der Link zu einer App im Aris](exercises/setup/aris-open-web.png)

Als nächstes bietet sich an bei Bedarf die Videos oder Ressourcen aus dem [Lern-Bereich](#lern-bereich)
zu studieren.


# Lern-Bereich

Wer sich nach den folgenden Lern-Inhalten noch unsicher fühlt, soll sich an mich wenden. Das grundlegende
Verständnis von Git und dessen Funktionalität ist wesentlich für den übrigen Teil der Veranstaltung.


## Einstieg

* [Code school - Try Git](https://try.github.io)
  Interaktives Git-Tutorial im Browser. Erklärt in 25 Schritten alle wichtigen Git Befehle.
* [Codeacademy: Create and explore a simple Git-managed project](https://www.codecademy.com/learn/learn-git)
  Interaktives Beginner-Tutorial der codeacademy.
* [Version Control System Introduction - Georgia Tech - Software Development Process](https://www.youtube.com/embed/zbKdDsNNOhg)
  Kurzes und prägnantes Video das erklärt warum Versionskontrolle wichtig ist
* [Learn Git in 20 Minutes](https://www.youtube.com/embed/Y9XZQO1n_7c?t=2m10)
  Erklärt in ruhigem Tempo die wichtigsten Git-Befehle. Zwar passiert das in dem Beispiel unter Windows, aber
  die Befehle sind unter jedem Betriebssytem dieselben. Erst ab Minute **2:10** wird es m.E. interessant.
* [Learn Git in 20 Minutes](https://www.youtube.com/embed/o4PFDKIc2fs)
  Wer davon überzeugt ist, nicht mehr ohne Git arbeiten zu wollen.

## Lynda-Videos
* [Git Essential Training: Kevin Skoglund](http://www.lynda.com/Git-tutorials/Git-Essential-Training/100222-2.html)
  Sehr empfohlen. Detaillierte Informationen zu den wichtigsten Git features. Geht oft über das hinaus, was wir machen
  werden. Nicht alle Git Funktionen müssen verstanden werden. Die Videos eignen sich sehr gut die wichtigen Funtkionen
  nachzuschlagen und gut erklärt zu bekommen.
* [Fundamentals of Software Version Control: Michael Lehman](http://www.lynda.com/Version-Control-tutorials/Fundamentals-Software-Version-Control/106788-2.html)
  Fast 3 Stunden Video-Material zu verschiedenen Systemen zur Versionskontrolle. Sehr umfassend. Sprengt den Rahmen
  dieser Veranstaltung und hat keinerlei Relevanz für Eure praktische Arbeit. Wer sich aber für das Thema interessiert
  kann hier etwas schlauer werden.
