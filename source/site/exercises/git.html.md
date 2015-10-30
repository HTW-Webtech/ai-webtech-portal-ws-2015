# Git-Übung
Bei dieser Übung gibt es keine Punkte und es wird dafür keine App im Aris benötigt.
Jedoch ist der Umgang mit Git die Grundlage für die folgenden Übungen. In dieser Übung
soll ihr *Git* richtig konfiguriert werden und Sie sich mit dem *Git*-Werkzeug vertraut
gemacht haben. Dazu empfehle ich die Links im [Lern-Bereich](#lern-bereich).

# Konfiguration
Jeder *commit* in Git referenziert einen Author (Das sind Sie!). Hierfür muss Git noch mitgeteilt werden
wer Sie sind. Der folgende Git Aufruf zeigt die aktuelle Author-Einstellungen.

~~~ bash
$ git config --get-regexp user
user.name Dein Name
user.email s000000htw-berlin.de
~~~

Um Git nun den richtigen Author (Deinen Namen und Deine E-Mail Adresse) mitzuteilen, kann der folgende Befehl
im Terminal ausgeführt werden.

~~~ bash
$ git config --global user.name "Max Mustermann"
$ git config --global user.email "s000001@htw-berlin.de"
~~~

Ein weitere Mal `git config --get-regexp user` im Terminal ausführen und schon sollte Git den
richtigen Namen und die richtige E-Mail anzeigen.

~~~ bash
$ git config --get-regexp user
user.name Max Mustermann
user.email s000001-berlin.de
~~~


# Lern-Bereich
Wer sich nach den folgenden Lern-Inhalten noch unsicher fühlt, soll sich an mich wenden. Das grundlegende
Verständnis von Git und dessen Funktionalität ist wesentlich für den übrigen Teil der Veranstaltung.

## Einstieg
* [Code school - Try Git](https://try.github.io)
  Interaktives Git-Tutorial im Browser. Erklärt in 25 Schritten alle wichtigen Git Befehle.
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
