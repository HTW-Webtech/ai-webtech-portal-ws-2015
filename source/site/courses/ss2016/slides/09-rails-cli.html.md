<!--

Agenda:
- Rails Commands
  - rails new
- Ordnerstruktur
  - app/{models,controllers,views,mailers,assets,…}
- Rails Commands #2
  - rails server
  - rails console
- Rake Command

-->

# Rails CLI

## Installation, Projektstruktur, Scaffolding

---

# Agenda

* Rails installieren
  * `rails new`
* Rails CLI
  * `rails server`
  * `rails console`
  * `rails generate`
* Rake Command
* Rails scaffolding

---

# Rails installieren

~~~
gem install rails -v '4.2.6'
~~~
{: .lang-bash }

* Installiert `rails`-Kommando
  * in der VirtualBox ggf. rails updaten
* Rails Version == 4.2.6

~~~
rails -v
=> Rails 4.2.6
~~~
{: .lang-bash }

~~~
# Update für Virtualbox
gem update
…
~~~
{: .lang-bash }

---

# Neues Rails Projekt

1. `rails new project-name`
1. Git repository initialisieren
1. `rails server`
1. <http://localhost:3000> öffnen

~~~
rails new project-name
…
cd project-name
git init
git add .
git commit -m 'Neues Rails Projekt-Template erzeugt'
rails server # Open in Browser: http://localhost:3000
~~~
{: .lang-bash }

---

# Rails Projektstruktur

~~~
tree . -L 1     # Einträge die mit einem Stern (*) beginnen, sind vorerst unwichtig
├── Gemfile
├── Gemfile.lock
├── README.rdoc
├── Rakefile     # * Ein Ruby-Makefile. Kann ignoriert werden.
├── app          # <-- Hier ists interessant: 90-100% von Eurem Code lebt hier.
├── bin          # * Wrapper-Skripte für die App. [Mehr Infos](http://notes.jerzygangi.com/what-is-the-bin-directory-in-a-ruby-on-rails-project/)
├── config       # Verschiedene Konfigurationsdateien für die App
├── config.ru    # * Ein Start-Skript für Rack-Apps. Kann ignoriert werden.
├── db           # Migrationsdateien und eine schema.rb die das DB-Schema darstellt
├── lib          # * Nur selten ist es sinnvoll hier Code abzulegen.
├── log          # log-Dateien vom Server
├── public       # Order für statische Dateien (favicon, robots.txt, …)
├── test         # * Software-Tests für Code
├── tmp          # * Temporäre Dateien (Sessions, Cache, …)
└── vendor       # * Code von Dritten, der nicht mit Bundler/rubygems installiert wird
~~~
{: .lang-bash }

---

# Rails `app`-Ordner

~~~
tree app -L 1    # Einträge die mit einem Stern (*) beginnen, sind vorerst unwichtig
app
├── assets       # Ressourcen für das Front End wie CSS, JavaScript und Bild-Dateien
├── controllers  # Controller code
├── helpers      # View Helper code
├── mailers      # Mailer für E-Mail Versand
├── models       # Model code
└── views        # Templates für die HTML-Erzeugung
~~~
{: .lang-bash }

---

# Rails Commands

* `rails server`: Bootet lokal Web-Server und startet Rails-App
* `rails console`: Öffnet interaktive Ruby-Shell mit Zugriff auf Rails-Code
* `rails generate`: Skript zum scaffolden von Code

---

# rails server

* Web-Server wird auf Port 3000 gestartet
* Code-Änderungen erfordern KEINEN Server-Neustart

---

# rails console

* Startet `irb` (ruby REPL) und lädt Rails-Code
  * REPL: Read evaluate print loop
* Wichtiges Werkzeug zur Interaktion mit Rails-Models
* Wenn Änderungen am Code durchgeführt:
  * `reload!` in der console lädt Code neu

*[REPL]: Read evaluate print loop

---

# rails generate

Als Demo zum Ende. Vorher rake commands.

---

# Rake Commands

* `rake` ist `make` für Ruby
  * basiert auf einem `Rakefile` statt `Makefile`
  * `rake -T` listet alle verfügbaren Befehle auf
* Rails benutzt `rake` um gängige Tasks zu automatisieren
  * `rake -T` in einem Rails-Projekt listet derzeit 39 Tasks

---

# Rake Commands

* `rake routes`: Listet alle konfigurierten Routes für eine Rails-App auf
* `rake db:migrate`: Führt alle noch auszuführenden DB-Migrationen durch
* `rake db:migrate:rollback`: Führt alle noch auszuführenden DB-Migrationen durch

---

# rails generate

* Skript zur Erzeugung von Boilerplate-Code
* Generiert: Controller, Models, Views und DB-Skripte (Migrations)
* `rails generate controller …`
* `rails generate model …`
* `rails generate migration …`
* …

---

# Scaffolding Beispiel

`rails generate scaffold Blog title:string body:text`

* Erzeugt Model, Views, Controller, Migrationsskript, Routen, Tests,…
  * Model: `app/models/blog.rb`
  * Controller: `app/controllers/blogs_controller.rb`
  * Views: `app/views/blogs/…`
      * index.html.erb
      * …
  * Migrations-Skript: `db/migrate/201******_create_blogs.rb`
  * …

---

# Scaffolding Beispiel

* `rake db:migrate`: Erzeugt DB-Tabellen aus Migrationsskript
* `rails server`: Server starten
* <http://localhost:3000/blogs> öffnen

---

# Live Coding

~~~
cd /tmp
rails new demo-project; cd demo-project
rails generate scaffold Blog title:string body:text
rake db:migrate
rails server
~~~
{: .lang-bash }

---

# Links

* Offizielle Docs zu [The Rails Command Line](http://guides.rubyonrails.org/v3.2/command_line.html)
* TeamTreehouse [An introduction to the Rails Command](http://blog.teamtreehouse.com/introduction-rails-command)
