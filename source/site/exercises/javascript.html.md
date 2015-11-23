# JavaScript-Übung
Deine Fähigkeiten haben überzeugt. Du hast dein Studium abgeschlossen und bei der BgUGs eine Stelle als
Web-Entwickler angenommen. Das nächste Projekt an dem du arbeiten sollst ist um einiges anspruchsvoller
die bisherigen Aufgaben.

## Allgemeines

| Abgabe bis            | Punkte (Tests) | Punkte (Review) |
|----------------------------------------------------------|
| 13.12.2015, 23.59 Uhr | 4              | 2-4             |
{: .table .table-bordered }

## Briefing
Einige Kunden der BgUGs hätten gerne eine App um Vokabeln zu lernen. "FlashCards" soll Sie heißen.
Die Idee ist, dass jeder Kunde diese App auf seinem Mobiltelefon bspw. öffnen kann und dort Lernkarten mit je einem
Text auf der Vorder- und Rückseite pflegen kann.

### Wireframes
Der Designer hat hierfür ein paar Wireframes vorbereitet.

![Die Startseite](exercises/javascript/flashcards-start.png)

Das ist die leere Startseite der App. Sie zeigt dem Nutzer rudimentäre Statistiken über
seine App-Nutzung an.

![Die Verwaltung der Lernkarten](exercises/javascript/flashcards-manage-overview.png)

Auf der Verwaltungs-Seite befindet sich eine Übersicht der Lernkarten, eine Möglichkeit
einzelne Karten zu löschen, ein Formular zur Erstellung von neuen Lernkarten, sowie zwei
Knöpfe "Demodaten laden" und **"Daten löschen"**. Der **"Demodaten laden"**-Knopf löscht alle
existieren Lernkarten und erzeugt die drei folgenden Karten (jeweils Vorder- und Rückseite):

* Badezimmer, bathroom
* Schachbrett, chess board
* Kindergarten, kindergarten

Der **"Daten löschen"**-Knopf löscht alle Lernkarten, sowie die notierte Anzahl der richtigen
und falschen Antworten. Der Knopf versetzt die App quasi in den Werkszustand.

![Eine Lernkarte anlegen](exercises/javascript/flashcards-create-card.png)

Mit dem Klick auf **"Hinzufügen"** wird ein Formular eingeblendet um eine neue Lernkarte anzulegen.
Dazu gehören 2 Input-Felder für die Vorder- und Rückseite, sowie ein **"Speichern"**-Knopf.

![Verwaltung nach Anlegen einer Karte](exercises/javascript/flashcards-manage-with-cards.png)

Nach dem **"Speichern"** gelangt der Nutzer wieder auf der Übersicht und sieht seine zuletzt
angelegte Lernkarte in der Übersichts-Tabelle.

![Die Lern-Seite](exercises/javascript/flashcards-learning.png)

Auf der Lern-Seite kann der Nutzer mit dem **"Beginn"**-Knopf eine Lern-Runde starten. Die App zeigt
dem Nutzer alle angelegten Lernkarten vor, während dieser sich mit 3 Knöpfen durch die Lern-Runde
navigieren kann.

![Das Interface beim Lernen](exercises/javascript/flashcards-learning-ui.png)

**"Ja"** bedeutet, dass der Nutzer die Karte verstanden hat. D.h. die Karte wird
wieder weggelegt und eine richtige Antwort notiert. **"Nein"** bedeutet eine falsche Antwort. Mit
dem **"Umdrehen"**-Knopf wird auf die Rück- und/oder Vorderseite der Karte gewechselt.

![Nachdem alle Lernkarten gesehen wurden](exercises/javascript/flashcards-learning-done.png)

![Startseite mit Lernkarten](exercises/javascript/flashcards-start-with-cards.png)

Auf der Startseite kann der Nutzer verfolgen wie viele Lernkarten angelegt, sowie wie viele
richtige oder falsche Antworten bisher gegeben wurden.


### Template

Ein anderer Entwickler von BgUGs hat bereits eine Vorlage entwickelt, die dafür werden kann um
die App fertig zu stellen.

* [Template Download](/downloads/exercises/javascript/flashcards-template.zip)


## Technische Anforderungen

Die Features zu jeder der 3 Seiten:

1. **Startseite (index.html)**: Anzeige der folgenden Daten
   * Anzahl der Karten
   * Anzahl der richtigen Antworten
   * Anzahl der falschen Antworten
1. **Verwaltung (manage.html)**:
   * Tabellarische Ansicht der Lernkarten
   * Löschen einzelner Lernkarten aus der tabellenarischen Ansicht heraus
   * Hinzufügen von neuen Lernkarten (mit Vorder- und Rückseite)
   * Laden von Demodaten (Alle Lernkarten werden durch die Demokarten ersetzt)
     * Badezimmer, bathroom
     * Schachbrett, chess board
     * Kindergarten, kindergarten
   * Löschen aller Daten
     * Lernkarten werden gelöscht
     * Anzahl der richtigen/falschen Antworten werden auf 0 gesetzt
1. **Lern-Seite (learn.html)**:
   * Beginn einer Lern-Runde
   * "Ja"-Knopf um eine Karte als richtig beantwortet zu markieren
   * "Nein"-Knopf um eine Karte als falsch beantwortet zu markieren
   * "Umdrehen"-Knopf um die jeweils andere Seite der Karte (Vorder- oder Rückseite) zu sehen


# Lern-Bereich

## Artikel und Tutorials
* [You Don't know JS](https://github.com/getify/You-Dont-Know-JS)
  Verschiedene JS-Bücher von Kyle Simpson kostenlos auf github.com. Interessant sind vor allem
  "this & Object Prototypes" sowie "Scope & Closures".
* [Eloquent JavaScript](http://eloquentjavascript.net)
  Sehr sehr gut geschriebene Einführung in JavaScript von Marijn Haverbeke. Es gibt zu den verschiedenen
  Aspekten von JavaScript jeweils sehr tief gehende Übungen.

## Lynda-Videos
* [JavaScript Essential Training](http://www.lynda.com/JavaScript-tutorials/JavaScript-Essential-Training/81266-2.html)
  JavaScript-Basics: Interessant für diejenigen, die noch Übung bei den Grundlagen brauchen.
* [Debugging the Web: JavaScript](http://www.lynda.com/JavaScript-tutorials/Debugging-Web-JavaScript/383908-2.html)
  Sehr umfassende Einführung in die Features des JavaScript Debuggers am Beispiel vom Google Chrome.
