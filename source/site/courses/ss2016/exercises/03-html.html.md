# HTML-Übung

Du studierst im 5. Semester Informatik und möchtest endlich mal Praxis-Erfahrung sammeln.
Vor kurzem hat dir jemand empfohlen dich bei der B!gUG zu bewerben.
Das hat auch geklappt und heute hast du deinen ersten Arbeitstag.

*[B!gUG]: Bazinga! Gemeinnützige Unternehmergesellschaft


## Allgemeines

| Git Abgabe bis    | Punkte (Jenkins) | CodeReview am | Punkte (CodeReview) |
|----------------------------------------------------------------------------|
| 8. Mai, 23:59 Uhr | 2 Punkte         | 11. Mai       | 2 Punkte |
{: .table.table-bordered }


## Briefing

Die BgUGs möchte bald ein neues Produkt auf den Markt bringen und hätte gerne eine Webseite um
das Produkt zu bewerben. Das Augenmerk bei der Aufgabe liegt vorerst auf dem Markup und nicht der Ästhetik.

Die Webseite besteht aus folgenden drei Teilen:

* Startseite (index.html). Diese Seite dient als Landingpage und beinhaltet die Marketing-relevante Texte.
* Kontakt-Seite (contact.html). Über diese Seite sollen Kunden Kontakt mit der BgUGs aufnehmen können.
* Impressum-Seite (imprint.html). Zu jeder Seite gehört ein Impressum das den Herausgeber und Verantwortlichen deklariert.

Die genauen Inhalte werden in den folgenden Abschnitten beschrieben.


### Jenkins Tests zu der Aufgabe

Um sicherstellen zu können, dass alle formalen Anforderungen an die Webseite
erfüllt sind gibt es eine [technische Spezifikation](https://github.com/HTW-Webtech/ai-webtech-functional-tests/blob/master/spec/exercises/html_spec.rb).

Ob deine Lösung alle Anforderungen erfüllt siehst du unter dem "Jenkins"-Link
neben deiner App im Aris.


## Anforderungen

Im folgenden ein paar Mockups zu den drei Unterseiten.


### Startseite

![Die Startseite: index.html](exercises/html/start.png)


### Kontakt-Formular

![Die Kontakt-Seite: contact.html](exercises/html/contact.png)


### Impressum

![Die Impressum Seite: imprint.html](exercises/html/imprint.png)


## Technische Anforderungen

Es sollen insgesamt drei statische Webseiten angelegt werden:

* `index.html`: Die ist die Startseite.
* `contact.html`: Ein HTML Kontaktformular (ohne Versand).
* `imprint.html`: Enthält eine Adresse.


Alle drei Seiten soll:

* das HTML-Markup mit dem W3C Markup Validator geprüft worden sein: <https://validator.w3.org>
* im `head` des Dokuments die folgenden [meta](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/meta)-Tags vorhanden sein:
  * dem Author: `<meta name="author" …>` => Dein Name
  * Keywords: `<meta name="keywords" …>` => Ein paar beliebige Keywords, bspw. `bazinga`, `scalable product`, …
* das Bazinga-Logo eingebunden sein. Der `img`-Tag muss als `src`-Attribut den String `bazinga-logo.png` enthalten.
* eine Navigation mit Links zu den jeweils anderen Seiten: `index.html`, `contact.html` und `imprint.html` zu sehen sein.


### Die Startseite

* Enthält einen Paragraphen mit dem mind. dem folgenden Produktext: `Bazinga! Focus on getting your software`


### Die Kontakt-Seite

* Enthält ein HTML-Formular mit den folgenden Eingabefeldern:
  * name
  * email
  * message
* Das Formular wird via HTTP `POST` an die URL `/contact` verschickt.


### Impressum

* Auf der Impressum-Seite soll die Adresse als [Address](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/address)-Element beschrieben werden.
* Die Telefonnummer im Adressblock soll als [Anchor](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/a) mit `tel:03050190` als `href`-Attribut umgesetzt werden.


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
