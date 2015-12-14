# Rails Blog-Übung

Nachdem du nun alle relevanten Front End Technologien gesehen hast, geht es jetzt mit Ruby on Rails in die
Back End Welt. Mit JavaScript, HTML und CSS können heutzutage beeindruckende Applikationen entwickelt werden,
aber die Persistenz und Aufbereitung von Nutzerdaten findet meist noch auf dem Server statt.

Ziel dieser Übung ist ein triviales Blog- und Kommentar-System nach dem offiziellen
["Getting Started"-Tutorial](http://guides.rubyonrails.org/getting_started.html) auf <http://guides.rubyonrails.org/>
zu implementieren und damit die ersten praktischen Erfahrungen mit dem Rails Framework zu sammeln.


## Allgemeines

| Abgabe bis            | Punkte (Tests) | Punkte (Review) |
|----------------------------------------------------------|
| 10.01.2015, 23.59 Uhr | 2              | 2               |
{: .table .table-bordered }


## Briefing

Die Rails-Applikation wird ebenfalls auf dem Aris Server deployed. Aus verschiedenen Gründen ist das Deployment
einer Rails App ein bisschen anders als das Deployment der bisherigen HTML/JavaScript-Seiten.
Das folgende Video zeigt hierzu die wichtigsten Schritte:

<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/uMpOxGj8EGs?rel=0" frameborder="0" allowfullscreen></iframe>


### Jenkins Tests zu der Aufgabe

Der Rails Blog wird ebenfalls via Jenkins getestet. Die Spec befindet sich auf
[github.com](https://github.com/HTW-Webtech/ai-webtech-functional-tests/blob/master/spec/exercises/exercise_4_spec.rb).


## Technische Anforderungen

Grundlage ist die offizielle ["Getting Started"-Anleitung](http://guides.rubyonrails.org/getting_started.html). Zu den zentralen Features gehört:

* Anlegen/Anzeigen/Bearbeiten/Löschen von Blog-Artikeln
* Hinzufügen/Löschen von Kommentaren zu den einzelnen Artikeln
* HTTP Basic Auth Passwortschutz für das Anlegen/Bearbeiten/Löschen von Blog-Artikeln und Kommentaren
  * Nutzer: admin
  * Passwort: admin


# Lern-Bereich

## Artikel und Tutorials

* [Ruby on Rails Tutorial: Learn Web Development with Rails](https://www.railstutorial.org/book) Ruby on Rails Ebook
  im Web von Michael Hartl.

* [Rails for Zombies](http://railsforzombies.org/) Video-Tutorials für Lesefaule Einsteiger.


## Lynda-Videos

* [Ruby on Rails 4 Essential Training](http://www.lynda.com/Ruby-Rails-tutorials/Ruby-Rails-4-Essential-Training/139989-2.html)
  Umfassendes Beginner-Tutorial auf ähnlichen Niveau wie das "Getting Started" vom Rails-Guide. Dafür sehr viel
  ausührlicher und zugänglicher.
