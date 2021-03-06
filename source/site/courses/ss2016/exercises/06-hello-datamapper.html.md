# DataMapper-Übung

In dieser Übung soll die Sinatra Applikation aus der vorhergehenden Übung um CRUD-Operationen
für die Kontaktanfragen erweitert werden.

*[Crud]: Create, Read, Update and Delete


## Allgemeines

| Git Abgabe bis      | Punkte (Jenkins) | CodeReview ab | Punkte (CodeReview) |
|------------------------------------------------------------------------------|
| 12. Juni, 23:59 Uhr | 0-8 Punkte       | 15. Juni      | 0-6 Punkte          |
{: .table.table-bordered }


## Jenkins-Test

Für diese Aufgabe werden keine automatischen Tests bereitgestellt. Die Ergebnisse werden manuell
von mir getestet und bewertet.


## Lösung zum Aris Server hochladen

Da Sie nun Ihre Lösung für die Live-Ansicht auf heroku deployen, sollten Sie daran denken Ihre
Lösung ebenfalls noch via git zum Aris-Server hochzuladen.

Nutzen Sie dazu einfach wie bisher den `git remote add` Code-Schnipsel von der Aris-Webseite.


## Beispiel-Implementierung

Unter [Heroku: HTW Datamapper](https://htw-datamapper-hello-world.herokuapp.com/) ist eine
Beispiel-Implementierung für diese Aufgabe zu finden.


## Briefing

Ziel ist es CRUD-Operationen für die Kontaktanfragen zu implementieren:

* **Create**: Die Anfrage wird von einem Besucher über das `/contact.html`-Formular erzeugt. (**1 Punkt**)
  * D.h. jede Anfrage über das Kontaktformular soll einen neuen DB-Eintrag erzeugen
* **Read**: Index-Seite und Show-Seite
  * Index-Seite: Unter `GET /admin/contact-requests.html` sollen alle Kontaktanfragen aufgelistet werden (**2 Punkte**)
    * Der Zugriff auf die Seite, wie alle Admin-Seiten, ist mit Nutzer/Passwort (admin:admin) geschützt
    * Für die Darstellung kann eine [HTML-table](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/table) Element genutzt werden
    * Jeder Eintrag hat bis zu zwei Links und ein Formular zum Löschen einer Konaktanfrage:
      * "Anzeigen"-Link auf die Show-Seite der Kontaktfrage, bspw. `GET /admin/contact-requests/12.html`. Dies wäre die Kontaktanfrage mit der ID 12
      * "Bearbeiten"-Link auf die Bearbeiten-Seite der Kontaktfrage, bspw. `GET /admin/contact-requests/12/edit.html`
      * "Löschen"-Button der ein Formular via HTTP DELETE an `DELETE /admin/contact-requests/12` schickt um bspw. die Kontaktanfrage 12 zu löschen
    * Show-Seite: `GET /admin/contact-requests/12.html` stellt eine einzelne Kontaktanfrage dar (**1 Punkt**)
      * Hat einen Link der zurück auf die Index-Seite führt: `GET /admin/contact-requests.html`
* **Update**: Edit-Seite und Endpunkt der Änderungen speichert (**2 Punkte**)
  * Edit-Seite: Edit-Seite und Endpunkt der Änderungen speichert
* **Delete**: Endpunkt der eine Kontaktanfrage löscht (**2 Punkte**)
  * Wird über `DELETE /admin/contact-requests/12` aufgerufen, wenn die Kontaktanfrage mit der ID 12 gelöscht werden soll
  * Die meisten Browser unterstützen nur HTTP POST und HTTP GET, d.h. für die Aufgabe
    bitte den Hinweis unten auf dieser Seite lesen.


## Setup

Grundlage für die App ist Euer Quellcode von der vorherigen Aufgabe. Ich empfehle den
Projekt-Ordner und die dazugehörige Heroku-App für diese Aufgabe zu übernehmen.

Tragt im Aris für die neue Aufgabe/App die Heroku-App URL aus der vorherigen Aufgabe
ein und aktualisiert den `data-app-slug`-Meta tag mit dem Neuen App-Namen.


### Rubygems / Gemfile

Um den DataMapper-Code nutzen zu können, könnt ihr entweder Euer Gemfile selber erweitern
oder das folgende Gemfile nutzen:

~~~
# Beispiel Gemfile
source "https://rubygems.org"

gem 'sinatra'
gem 'data_mapper'

group :development do
  gem 'dm-sqlite-adapter'
end

group :production do
  gem 'dm-postgres-adapter'
end
~~~
{: .lang-ruby }

Mit dem `group`-Aufruf können Ruby-Bibliotheken pro Laufzeitumgebung definiert werden.

In dem o.g. Gemfile wird für die lokale Entwicklung (`development`-Group) der DataMapper-Adapter
für die [SQLite](https://www.sqlite.org/)-Datenbank konfiguriert. Die Produktions-Umgebung (`production`-Group) soll
jedoch den Adapter für [PostgreSQL](https://www.postgresql.org/) nutzen.

SQLite wird als RDBMS auf den virtuellen Maschinen/die lokale Entwicklung genutzt. Das spart
die Installation und Konfiguration eines RDBM-Servers (bspw. MySQL oder PostgresSQL).

Um die richtigen Ruby gems zu installieren muss nun der `bundle install`-Aufruf parametrisiert werden:

~~~
bundle install --without=production # Ignoriert lokal den 'dm-postgres-adapter'
~~~
{: .lang-bash }

Der `bundle install`-Aufruf erzeugt ggf. ein `.bundle`-Verzeichnis im Projekt-Ordner. Diesen NICHT
in dem git-repository hinzufügen. Stattdessen sollte das Verzeichnis nach dem Installieren wieder gelöscht werden.


### DataMapper-Konfiguration

Nutzt entweder die folgende DataMapper-Konfiguration (`datamapper.rb`) für diese Aufgabe
oder legt eine vergleichbare selber an.

~~~
# datamapper.rb
require 'data_mapper'

DataMapper::setup(:default, ENV.fetch('DATABASE_URL', "sqlite3:///#{Dir.pwd}/data.db"))

class ContactRequest
  include DataMapper::Resource
  property :id, Serial
  property :name, String
  property :email, String
  property :message, Text
end

DataMapper.finalize
ContactRequest.auto_upgrade!
~~~
{: .lang-ruby }

Die Datei wird im Projekt-Ordner abgespeichert und via Ruby-`require` in der  `app.rb`
nachgeladen. Dazu wird in der `app.rb` in der 1. Zeile den folgender Code hinzugefügt:

~~~
# app.rb
require './datamapper' # Lädt den Code aus der `datamapper.rb`-Datei
…
~~~
{: .lang-ruby }


### Datenbank-Zugriff auf Heroku

Lokal wird für die Sinatra App als Datenbank SQLite3 benutzt. Für Heroku gibt es
anstelle von SQLite3 die Möglichkeit eine PostgreSQL-Datenbank zu nutzen.

Um die PostgreSQL-Datenbank auf Heroku zu aktivieren, muss diese als Add-On im
[Heroku-Dashboard](https://dashboard.heroku.com/apps) für die jeweilige Applikation aktiviert werden.

1. Für die ausgewählte App den Reiter *Resources* öffnen
1. Im Abschnitt *Add-ons* nach "Heroku Postgres" suchen
1. Heroku Postgres auswählen und als "Plan" die Hobby-Version aktivieren

![Heroku Add-On Suche](exercises/datamapper/heroku-addon-suche.png)

![Heroku Postgres auswählen](exercises/datamapper/heroku-addon-auswahl.png)


### Aufgabe DELETE/UPDATE

Das Löschen/Bearbeiten von Kontaktanfragen via HTTP DELETE bzw. HTTP PUT unterstützen die wenigsten Browser.

Diese haben i.d.R. lediglich HTTP GET und HTTP POST implementiert, bspw. HTTP POST für den Versand eines
HTML Formulars.

Um die Implementierung auf Server-Seite jedoch mit den richtigen HTTP Verben, also DELETE und PUT, zu realisieren
bieten viele Web-Frameworks dem Browser/Client einen Workaround einen HTTP POST semantisch als DELETE, PUT, PATCH, …
auszuzeichnen.

Auch Sinatra bietet einen solchen Workaround:

1. Dieser muss in der App zunächst aktiviert werden, mehr hier in der [Dokumentation](http://www.sinatrarb.com/configuration.html#methodoverride---enabledisable-the-post-method-hack)
2. HTML Formulare beschreiben das eigentlich gemeinte HTTP Verb mit einer `_method`-Variable.

~~~
<form method="post" action="/submit">
  <input type="hidden" name="_method" value="PUT">
  <!--
    Das Formular wird zwar als HTTP POST versendet, der Server erkennt jedoch, dass eigentlich ein HTTP PUT
    gemeint ist und interpretiert die HTTP Anfrage als solchen. Dasselbe gilt für andere Methoden wie bspw. DELETE
  -->
</form>
~~~
{: .lang-html }

Mehr Details zu dem Mechanismus in diesem [Blogpost](http://mikeebert.tumblr.com/post/26877173686/quick-tip-using-put-and-delete-in-sinatra).


### Aufgabe READ: Ausgabe von mehrere Kontaktanfragen

Auf der Übersichtsseite `GET /admin/contact-requests.html` sollen mehrere Kontaktanfragen
dargestellt werden. Dazu müssen Sie zunächst alle Anfragen aus der Datenbank lesen und
anschließend diese mit einer Art Schleife in der View ausgeben.

Zum Auslesen aller Datenbank-Objekte können Sie den `ContactRequest.all`-Aufruf nutzen.
Rückgabe ist ein Array von Kontaktanfragen.

Um dieses Array nun in der View ausgeben zu können, bietet Ruby die `.each`-Methode auf
einem Array an. Mehr dazu in den Folien unter [ERB-Schleifen](https://portal.htw-webtech.com/site/courses/ss2016/slides/06-sinatra-rubygems-bundler.html#erb-schleifen).
