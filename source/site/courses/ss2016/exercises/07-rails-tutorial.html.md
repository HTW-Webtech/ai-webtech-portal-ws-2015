# Rails Tutorial

Nachdem du nun alle relevanten Front End Technologien gesehen hast, geht es jetzt mit Ruby on Rails in die
Back End Welt. Mit JavaScript, HTML und CSS können heutzutage beeindruckende Applikationen entwickelt werden,
aber die Persistenz und Aufbereitung von Nutzerdaten findet meist noch auf dem Server statt.

Ziel dieser Übung ist ein triviales Blog- und Kommentar-System nach dem offiziellen
["Getting Started"-Tutorial](http://guides.rubyonrails.org/getting_started.html) auf <http://guides.rubyonrails.org/>
zu implementieren und damit die ersten praktischen Erfahrungen mit dem Rails Framework zu sammeln.


## Allgemeines

| Git Abgabe bis      | Punkte (Jenkins) | CodeReview ab | Punkte (CodeReview) |
|------------------------------------------------------------------------------|
| 26. Juni, 23:59 Uhr | 0-2 Punkte       | -             | -                   |
{: .table.table-bordered }


## Jenkins Tests zu der Aufgabe

Der Rails Blog wird ebenfalls via Jenkins getestet. Die Spec befindet sich auf
[github.com](https://github.com/HTW-Webtech/ai-webtech-functional-tests/blob/master/spec/exercises/exercise_4_spec.rb).

*Achtung*: Damit der Test auf den Passwort-geschützten Bereich zugreifen kann, sollten User und Passwort für
die Basic Authorization admin/admin sein.


## Briefing

### PostgreSQL Server installieren

Um in der Virtualbox in einer der Produktion möglichst ähnlichen Umgebung zu arbeiten, muss auf der Virtualbox
zunächst ein PostgreSQL-Server installiert werden:

Im Terminal in der Virtualbox die folgenden Befehle ausführen:
~~~
sudo apt-get update              # Aktualisiert den Index von apt
sudo apt-get install postgresql  # Installiert den postgreSQL Server
createdb                         # Erzeugt eine Datenbank
psql                             # Öffnet eine postgres-shell, wenn alles funktioniert hat
\q                               # Schließt die postgres-shell wieder
~~~
{: lang-bash }


### Rails-App erstellen

Rails benötigt für den Zugriff auf den PostgreSQL-Server einige Konfigurationsdateien, die
mit dem folgenden Befehl automatisch angelegt werden.

Im Terminal:
~~~
cd Workspace            # In das Workspace-Verzeichnis wechseln
rails -v                # Prüfen, dass Rails in der Version 4.2.x verfügbar ist
rails new Uebung-7 --database=postgresql
…
git init
git add .
git commit -m "Hello World"
~~~
{: lang-bash }


### Heroku Deployment

Heroku bietet mit dem `rails_12factor`-gemein paar Optimierungen für das Rails-Deployment. Um diese
zu nutzen, müssen die folgenden drei Zeilen im `Gemile` eingetragen werden.

~~~
# Gemfile
group :production do
  gem 'rails_12factor'
end
~~~
{: lang-ruby }


Anschließend müssen diese Änderungen noch mit Bundler in das Gemfile.lock übertragen werden.

~~~
bundle install
git add .
git commit -m 'Add rails_12factor gem'
git push heroku master
~~~
{: lang-bash }


Von hier an kann dem Rails-Tutorial gefolgt werden. Hinweis: Um Ihre Änderungen effektiv debuggen zu können,
sollten Sie das Tutorial zunächst auf Ihrem lokalen Computer erfolgreich abschließen und erst abschließend
alle Änderungen auch zum Heroku-Server hochladen.


### Rails Tutorial

Grundlage ist die offizielle ["Getting Started"-Anleitung](http://guides.rubyonrails.org/getting_started.html). Zu den zentralen Features gehört:

* Anlegen/Anzeigen/Bearbeiten/Löschen von Blog-Artikeln
* Hinzufügen/Löschen von Kommentaren zu den einzelnen Artikeln
* HTTP Basic Auth Passwortschutz für das Anlegen/Bearbeiten/Löschen von Blog-Artikeln und Kommentaren
  * Nutzer: admin
  * Passwort: admin


### Basic Authorization / Passwortschutz

In dem Rails-Tutorial wird im Abschnitt "Security" ein Passwortschutz via "Basic Authorization" eingerichtet.
Verwenden Sie für den Passwortschutz den User admin und das Passwort admin, also:

~~~ruby
http_basic_authenticate_with name: "admin", password: "admin"
~~~




# Lern-Bereich

## Artikel und Tutorials

* [Ruby on Rails Tutorial: Learn Web Development with Rails](https://www.railstutorial.org/book) Ruby on Rails Ebook
  im Web von Michael Hartl.

* [Rails for Zombies](http://railsforzombies.org/) Video-Tutorials für Lesefaule Einsteiger.


## Lynda-Videos

* [Ruby on Rails 4 Essential Training](http://www.lynda.com/Ruby-Rails-tutorials/Ruby-Rails-4-Essential-Training/139989-2.html)
  Umfassendes Beginner-Tutorial auf ähnlichen Niveau wie das "Getting Started" vom Rails-Guide. Dafür sehr viel
  ausührlicher und zugänglicher.
