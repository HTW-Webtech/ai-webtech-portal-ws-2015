# Rails Tutorial

Nachdem du nun die Eckpfeiler (Models, Views und Controller) des Rails Framework kennengelernt hast,
kannst du gleich deine 1. Rails-Applikation realisieren.

Ziel dieser Übung ist das offizielle ["Getting Started"-Tutorial](http://guides.rubyonrails.org/getting_started.html)
von Rails abzuschließen.

Die Rails-Applikation soll abschließend auf Heroku deployed werden, weshalb deine ersten Arbeitsschritte
von den Angaben im Tutorial abweichen, mehr dazu unten im Briefing-Aschnitt.


## Allgemeines

| Git Abgabe bis      | Punkte (Jenkins) | CodeReview ab | Punkte (CodeReview) |
|------------------------------------------------------------------------------|
| 3. Juli, 23:59 Uhr  | 0-2 Punkte       | 6. Juli       | 0-6 Punkte          |
{: .table.table-bordered }


## Jenkins Tests zu der Aufgabe

Deine Rails-Applikation wird wieder via Jenkins getestet. Die Spec befindet sich auf
[github.com](https://github.com/HTW-Webtech/ai-webtech-functional-tests/blob/master/spec/exercises/rails_tutorial_spec.rb).


## Briefing

In dem ["Getting Started"-Tutorial](http://guides.rubyonrails.org/getting_started.html)
fehlen einige Arbeitsschritte die im Folgenden beschrieben werden.


### PostgreSQL Server installieren

Es empfiehlt sich bei der Entwicklung eine der Produktion möglichst ähnliche
Arbeitsumgebung herzustellen. Da die Applikation auf Heroku einen PostgreSQL-Server nutzen
wird, soll zunächst ein solcher installiert werden:

Im Terminal in der Virtualbox die folgenden Befehle ausführen:

~~~
sudo apt-get update              # Aktualisiert den Index von apt
sudo apt-get install postgresql  # Installiert den postgreSQL Server
createdb                         # Erzeugt eine Datenbank
psql                             # Zugriff auf den Sever testen: Wenn alles funktioniert hat öffnet sich eine Shell
\q                               # Schließt die postgres-shell wieder
~~~
{: .lang-bash }


### Rails-Projekt erzeugen

Rails benötigt für den Zugriff auf den PostgreSQL-Server einige Konfigurationsdateien, die
mit dem folgenden Befehl automatisch angelegt werden.

Im Terminal:

~~~
cd Workspace            # In das Workspace-Verzeichnis wechseln
rails -v                # Prüfen, dass Rails in der Version 4.2.x verfügbar ist
rails new Aufgabe7 --database=postgresql
~~~
{: .lang-bash }

Rails hat nun eine Konfigurationsdatei für den Zugriff auf die PostgreSQL-DB angelegt. Diese
befindet sich in dem Projekt in dem Pfad: `config/database.yml`.

Wichtig ist, dass in der `database.yml` der Eintrag für `production` den folgenden Wert hat:

~~~
production:
  <<: *default
  url: <%= ENV['DATABASE_URL'] %>
~~~
{: .lang-yaml }

Die App nutzt eine Umgebungsvariable `DATABASE_URL`. Wie diese funktioniert erfährst du [hier](http://www.jguru.com/faq/view.jsp?EID=690).


#### PostgreSQL Verbindung testen

Um die Verbindung zur DB zu testen, führe folgende Befehle aus:

~~~
rake db:create             # Erzeugt deine lokale Datenbank
rails server               # Startet den Rails Server für deine Applikation
open http://localhost:3000 # Öffnet die Rails-Applikation in einen Browser
~~~
{: .lang-bash }

Wenn dies funktioner hat, kannst du alle Änderungen via git speichern.

~~~
git init
git add .
git commit -m "Hello World"
~~~
{: .lang-bash }


### Heroku Deployment

Nun wird noch eine Heroku-App mit PostgreSQL-DB benötigt. Diese Schritte sind mit denen aus der
DataMapper-Aufgabe identisch. Du brauchst eine neue Heroku-App und fügst dieser als Add-On
eine Postgres-DB hinzu.

Zusätzlich zur Datenbank sollte für das Deployment von Rails-Applikationen auf Heroku
das `rails_12factor`-gem für die Produktions-Umgebung konfiguriert werden.

Dazu muss lediglich im `Gemfile` folgender Eintrag erzeugt werden:

~~~
# Gemfile
group :production do
  gem 'rails_12factor'
end
~~~
{: .lang-ruby }

Anschließend müssen diese Änderungen noch mit Bundler in das Gemfile.lock übertragen werden.

~~~
bundle install    # Aktualisiert das Gemfile.lock nach einer Änderung im Gemfile
git add .
git commit -m 'Add rails_12factor gem'
git push heroku master
heroku open       # Öffnet die Heroku-App.
~~~
{: .lang-bash }


Anschließend sollte die folgende Seite sichtbar sein:

![Heroku Rails Startseite](exercises/rails-tutorial/heroku-first-page.png)


Von hier an kann dem Rails-Tutorial gefolgt werden. Hinweis: Um Ihre Änderungen effektiv debuggen zu können,
sollten Sie das Tutorial zunächst auf Ihrem lokalen Computer erfolgreich abschließen und erst abschließend
alle Änderungen auch zum Heroku-Server hochladen.


### Heroku DB migrieren

Im Verlauf des Tutorials wurde mehrfach der Befehl `rake db:migrate` ausgeführt. Dieser sorgt dafür, dass alle
Migrations-Skripte in der konfigurierten Datenbank ausgeführt werden.

Dies muss auch auf dem Heroku-Server manuell angestoßen werden. Der Befehl dafür ist:

~~~
heroku run rake db:migrate
~~~
{: .lang-bash }

![DB]: Datenbank


## Rails Tutorial

Grundlage ist die offizielle ["Getting Started"-Anleitung](http://guides.rubyonrails.org/getting_started.html). Zu den zentralen Features gehört:

* Anlegen/Anzeigen/Bearbeiten/Löschen von Blog-Artikeln
* Hinzufügen/Löschen von Kommentaren zu den einzelnen Artikeln
* HTTP Basic Auth Passwortschutz für das Anlegen/Bearbeiten/Löschen von Blog-Artikeln und Kommentaren
  * Nutzer: admin
  * Passwort: admin


### Basic Authorization / Passwortschutz

In dem Rails-Tutorial wird im Abschnitt "Security" ein Passwortschutz via "Basic Authorization" eingerichtet.
Verwenden Sie für den Passwortschutz den User admin und das Passwort admin, also:

~~~
http_basic_authenticate_with name: "admin", password: "admin"
~~~
{: .lang-ruby }

### Meta Tag mit data-app-slug

Wie bei den bisherigen Apps soll auch die Rails-Applikation den folgenden `<meta>`-Tag enthalten
um die Applikation eindeutig identifizieren zu können:

~~~
<meta data-app-slug="app-id-aus-dem-aris">
~~~
{: .lang-html }

Damit dieser Meta-Tag auf allen Seiten der Rails-Applikation verfügbar ist, kann er in das Applikations-Layout
eingetragen werden `app/views/layouts/application.html.erb`.


# Lern-Bereich

## Artikel und Tutorials

* [Ruby on Rails Tutorial: Learn Web Development with Rails](https://www.railstutorial.org/book) Ruby on Rails Ebook
  im Web von Michael Hartl.

* [Rails for Zombies](http://railsforzombies.org/) Video-Tutorials für Lesefaule Einsteiger.


## Lynda-Videos

* [Ruby on Rails 4 Essential Training](http://www.lynda.com/Ruby-Rails-tutorials/Ruby-Rails-4-Essential-Training/139989-2.html)
  Umfassendes Beginner-Tutorial auf ähnlichen Niveau wie das "Getting Started" vom Rails-Guide. Dafür sehr viel
  ausührlicher und zugänglicher.
