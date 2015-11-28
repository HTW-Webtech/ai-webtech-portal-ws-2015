# HTML-Übung
Du studierst im 5. Semester Informatik und möchtest endlich mal Praxis-Erfahrung sammeln.
Vor kurzem hat dir jemand empfohlen dich bei der <abbr title="Bazinga! gUGs">BgUGs</abbr> zu bewerben.
Das hat auch geklappt und heute hast du deinen ersten Tag im 2-wöchtigen Praktikum bei der BgUGs.

## Allgemeines

| Abgabe bis            | Punkte (Tests) | Punkte (Review) |
|----------------------------------------------------------|
| 8.11.2015, 23.59 Uhr  | 2              | 2               |
{: .table .table-bordered }

## Briefing
Die BgUGs möchte bald ein neues Produkt auf den Markt bringen und hätte gerne eine Webseite um
das Produkt zu bewerben. Die Produkt-Seite soll im 1. Schritt nicht besonders schön aussehen.

Dein Vorgesetzter hätte gerne eine Webseite mit drei Unterseiten:

* Startseite (index.html) mit einer Produkt-Beschreibung
* Kontakt-Seite (contact.html) mit einem Kontakt-Formular
* Impressum-Seite (imprint.html) mit der Adresse

### Jenkins Tests zu der Aufgabe
[Spec auf github.com](https://github.com/HTW-Webtech/ai-webtech-functional-tests/blob/master/spec/exercises/exercise_1_spec.rb)


### Startseite
![Die Startseite: index.html](exercises/html/start.png)

### Kontakt-Formular
![Die Kontakt-Seite: contact.html](exercises/html/contact.png)

### Impressum
![Die Impressum Seite: imprint.html](exercises/html/imprint.png)


## Technische Anforderungen
Alle drei Webseiten sollen die folgenden Anforderungen erfüllen:


* Keine Fehler bei der Prüfung der Webseite mit dem W3C Markup Validator: <https://validator.w3.org>
* Im `head` des HTML-Dokuments befinden sich [meta](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/meta)-Tags mit Angaben zu:
  * author = dein Name
  * keywords = "bazinga"
* Auf allen Webseiten ist das Bazinga-Logo eingebunden. Der `img`-Tag soll als src `bazinga-logo.png` eingetragen haben.
* Es existiert eine Navigation mit drei Links zu allen Seiten: `index.html`, `contact.html` und `imprint.html`

### Die Startseite
Füge eine eine Produkt-Beschreibung hinzu, die den Text **Lorem Ipsum** enthält.

### Die Kontakt-Seite
Das Formular verschickt die Eingaben via `POST` an die Adresse `/contact`. Verschickt werden die folgenden Felder:

* name
* email
* message

## Ressourcen
Bazinga-Logo:

![Bazinga-Logo](exercises/html/bazinga-logo.png)


# Lern-Bereich
Diejenigen die bisher noch gar keine Erfahrung mit HTML gesammelt haben, aber auch diejenigen die ihre Kenntnisse
auffrischen möchten finden hier Links zu m.E. relevanten Online-Ressourcen.

## Einstieg
* [HTML/Tutorials/HTML-Einstieg](http://wiki.selfhtml.org/wiki/HTML/Tutorials/HTML-Einstieg)
  HTML-Grundlagen, sowie bereits eine Einführung in das Thema CSS.
* [HTML/Tutorials/HTML5-Grundstruktur](http://wiki.selfhtml.org/wiki/HTML/Tutorials/HTML5-Grundstruktur)
  Aufbau und Grundstruktur für HTML5 basierte Webseiten.

## Lynda-Videos
* [HTML Essential Training: James Williamson](http://www.lynda.com/HTML-tutorials/HTML-Essential-Training/170427-2.html)
  Sehr sehr sehr umfangreiche Video-Lektionen zu HTML5. Kapitel 1-6 sind HTML-Grundlagen, während Kapitel 7
  und 8 sich mit CSS und JavaScript beschäftigen. Ziemlich guter Sprecher!
* [HTML5: Structure, Syntax, and Semantics: James Williamson](http://www.lynda.com/HTML-tutorials/HTML5-Structure-Syntax-Semantics/182177-2.html)
  Tiefer Einstieg in die Themen *Struktur, Syntax und Semantik* von HTML5. Die Inhalte gehen zum Teil
  über die Anforderungen dieses Kurses hinaus, sind aber absolut relevant für alle Web-Interessierten. Derselbe Sprecher
  wie bei dem anderen Lynda-Video.
