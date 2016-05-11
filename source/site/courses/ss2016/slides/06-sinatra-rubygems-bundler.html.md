# Sinatra, Rubygems, Bundler

![Sinatra, Rubygems, Bundler Logo](slides/ruby-sinatra/logos.png)

---

# Agenda

* Sinatra Intro
* Rubygems und gem-Kommando
* Bundler, Gemfile, Gemfile.lock
* Sinatra Grundlagen
  * DSL Grundlagen
  * Views + Layout, ERB
  * Statische Dateien
  * Params
  * Sessions
  * Filter

---

# Sinatra

> Sinatra is a DSL for quickly creating web applications in Ruby with minimal effort

[Quelle: sinatrarb.com](http://www.sinatrarb.com/intro.html)

---

# Sinatra Minimalbeispiel

~~~
# app.rb
require 'sinatra' # Lädt Sinatra-Code nach
get "/" do        # Definiert ein GET an `/`, also root
  "Hello world!"  # => Gibt als "Hello World" aus.
end               # Der Status-Code ist implizit 200

get "/foo" do     # Definiert ein GET an `/foo`
  status 403      # Verbietet Zugriff via 403-Code
end
~~~
{: .lang-ruby }

~~~
$ ruby app.rb
~~~
{: .lang-bash }

~~~
$ curl localhost:4567
=> Hello world!

$ curl localhost:4567/foo
=> Bar
~~~
{: .lang-bash }

---

# Sinatra Live-Beispiel

---

# Sinatra Interna

* Eigener in Ruby geschriebener Web-Server
* Konventionen > Konfiguration
  * Default Port 4567
  * Status-Code implizit 200
* Wo kommt dieses Code her?

~~~
# app.rb
require 'sinatra' # <- require lädt Code nach.
…
~~~
{: .lang-ruby }

---

# Sinatra gem

* Das Sinatra Framework wird als gem auf <http://rubygems.org> veröffentlicht
* mit `require` kann Code aus einem gem in ein Skript nachgeladen werden
* Um Sinatra nutzen zu können, muss zunächst das gem installiert werden

---

# Gem

* Ein gem ist ein Archiv/Paket von ruby code mit einem Manifest (Meta-Informationen)
* Manifest: gemspec mit u.a. folgenden Inhalten
  * Version des veröffentlichen ruby codes
  * Name des Authors
  * Lizenz
  * …
* Ein gem kann Utility-Code oder auch ganze Frameworks enthalten

[Rubygems.org: What is a gem?](http://guides.rubygems.org/what-is-a-gem/)

---

# Rubygems und gem Kommando

* `gem`-Kommando ist ein CLI für <http://rubygems.org>
* Seit Version 1.9 in jeder Ruby-Installation
* Rubygems.org ist ein Code Repository über welches Ruby-Entwickler Code miteinander austauschen
  * Derzeit sind es 7533 gems mit ca. 8 Milliarden Downloads (Stand: 2016-05-16)
  * Jedes dieser gems wird zusätzlich in verschiedenen Versionen angeboten

Beispiel zur Nutzung vom `gem`-Kommando:

~~~
$ gem search sinatra           # Durchsucht rubygems.org nach gems mit diesem Namen
$ gem query sinatra --details  # Zeigt Author, Version, Lizenz, Homepage etc. zu gem
$ gem install sinatra          # Installiert das aktuellste Sinatra gem
$ gem uninstall sinatra        # Deinstalliert gem
~~~
{: .lang-bash }

*[CLI]: Command Line Interface

---

# Bundler

* Statt `gem install` auszuführen nutzen wir Bundler
* Bundler installiert gems automatisch
* Bundler installieren: `gem install bundler`
* Ein `Gemfile` im Projekt-Ordner anlegen (s.u.)
* Bundler ausführen: `bundle install`
* Bundler erzeugt `Gemfile.lock`

Beispiel-Gemfile für eine Sinatra-App

~~~
# Gemfile
source 'https://rubygems.org'

gem 'sinatra'
~~~

---

# Bundler #2

* `Gemfile`: Definiert Abhängigkeiten zu gems, bspw. sinatra
* `Gemfile.lock`: Definiert exakte zu installierende Versionen
* Beide Dateien via git zum Projekt einchecken

[Andre Arko: How does Bundler work anyway?](http://andre.arko.net/2015/04/28/how-does-bundler-work-anyway/)
[Pat Shaughnessy: How does Bundler bundle](http://patshaughnessy.net/2011/9/24/how-does-bundler-bundle)

---

# Sinatra Projekt

~~~
$ tree .            # Tree erzeugt Baum-Ansicht eines Ordners und aller
.                   # Unterordner und Dateien.
├── Gemfile         # Bundler benutzt diese Datei um sinatra zu installieren
├── Gemfile.lock
├── app.rb          # Die Implementierung der web applikation mit sinatra
├── config.ru       # Ein Hilfsskript zum Starten der sinatra applikation
├── public          # Ordner für statische Dateien (Stylesheets, Bilder, JavaSript, etc.)
│   └── sinatra-logo.png
└── views           # Ordner mit Template und Layout-Dateien
    ├── index.erb   # Template für die index-Seite
    └── layout.erb  # Layout das von allen Seiten genutzt wird
~~~
{: .lang-bash }

Bezieht sich auf Minmalbeispiel von github: <https://github.com/HTW-Webtech/ai-sinatra-base>

---

# Sinatra Dokumentation

Sehr gute Dokumentation, wenn ihr Dinge nachschlagen wollt: <http://www.sinatrarb.com/intro.html>

---

# Sinatra Classic vs. Modular

In der Praxis verwenden wir ausschließlich den Modular-Style

Beispiel Classic

~~~
# app_classic.rb
require 'sinatra'

get '/' do
  "Hallo Welt"
end
~~~
{: .lang-bash }


Beispiel Modular

~~~
# app_modular.rb
require 'sinatra/base'

class AppModular < Sinatra::Base
  get '/' do
    "Hallo Welt"
  end
  run! if app_file == $0 # start the server if ruby file executed directly
end
~~~
{: .lang-bash }

[Modular vs. Classic](http://www.sinatrarb.com/intro.html#Modular%20vs.%20Classic%20Style)

---

# Sinatra Features

* Templates + Layout
* Routing und HTTP Status Codes
* Statische Dateien
* GET und POST Parameter
* Sessions und Cookie-Verwaltung

---

# Templates + Layout

~~~
require 'sinatra/base'

class MyApp < Sinatra::Base
  get '/index.html' do
    "<!DOCTYPE>
    <html>
    <head>
      <title></title>
      …
      <body>
        <p>Hallo Frank!</p>
      </body>
    </html>"
  end
end
~~~
{: .lang-ruby }

---

# Templates + Layouts

* Stattdessen Templates als separate Datei im `view`-Ordner
* Trennung zwischen Template und Layout
  * Layout enthält redundaten HTML-Code, bspw. Navigation, Meta-Daten, etc.
  * Template enthält nur seitenspezifischen HTML-Code

---

# Layout-Beispiel

~~~
# views/layout.erb
<!DOCTYPE>
<html>
<head>
  <title>Meine Sinatra-App</title>
</head>
<body>
  <%= yield %>
</body>
</html>
~~~
{: .lang-html }

---

# Layout-Beispiel

* Datei-endung `.erb` steht für Embedded Ruby
* Erlaubt HTML und Ruby-Code in einer Datei zu mischen
  * `<%= ruby %>` führt Code aus und setzt Rückgabewert im HTML ein
  * `<% ruby %>` führt Code aus und ignoriert Rückgabewert
* `<%= yield %>` ist Platzhaler für Template

---

# Layout-Beispiel

~~~
# views/layout.erb
<!DOCTYPE>
<html>
<head>
  <title>Meine Sinatra-App</title>
</head>
<body>
  <%= yield %> <!-- Hier wird das `index.erb`-Template eingesetzt -->
</body>
</html>
~~~
{: .lang-html }

---

# Template-Beispiel

* Template und Layout haben Zugriff auf Instanzvariablen aus der app
* Bspw. `@greeting` wird in der `app.rb` auf "Hallo Frank!" gesetzt

~~~
# views/index.erb
<p><%= @greeting %></p> <!-- @greeting ist eine Instanzvariable aus der app.rb -->
~~~
{: .lang-html }

---

# Ergebnis:

~~~
require 'sinatra/base'

class MyApp < Sinatra::Base
  get '/index.html' do
    @greeting = "Hallo Frank!"
    erb :index               # Definiert das `views/index.erb`-Template für diese Seite.
  end                        # Außerdem wird immer `views/layout.erb` als Layout verwendet.
end
~~~
{: .lang-ruby }

Verknüpft die `views/layout.erb` und `index.erb` zu:

~~~
<!DOCTYPE>
<html>
<head>
  <title>Meine Sinatra-App</title>
</head>
<body>
  <p>Hallo Frank!</p>
</body>
</html>
~~~
{: .lang-html }

---

# Statische Dateien

* `public`-Ordner: Statische Dateien wie JavaScripts, Stylesheets oder Bilder
* Beispiel: `public/logo.png` -> `http://localhost:4567/logo.png`
* Stylesheet: `public/css/style.css` -> `http://localhost:4567/css/style.css`
* Beliebige Dateien: `public/dokument.pdf` -> `http://localhost:4567/dokument.pdf`

~~~
# Sinatra App Ordner
├── Gemfile
├── Gemfile.lock
├── app.rb
├── config.ru
├── public                <-- Hier können statische Dateien abgelegt werden
│   └── sinatra-logo.png
└── views
    ├── index.erb
    └── layout.erb
~~~

---

# Parameter

* Zugriff auf Query-String und POST-Params
* POST-Params werden bspw. via HTML-Formular versendet
* Query-String ist teil der URL
* Params als Schnittstelle zwischen Anwender und App

~~~
# URL mit Query-String: "Hallo Hans!"
http://example.com/?greeting=Hallo%20Hans!
~~~
[Wikipedia: Query-String](https://en.wikipedia.org/wiki/Query_string)

---

# Sinatra Params Beispiel

~~~
require 'sinatra/base'

class MyApp < Sinatra::Base
  get '/' do
    @greeting = params['greeting']  # @greeting wird auf den Wert von `params['geeting']` gesetzt
    erb :index
  end
end
~~~
{: .lang-ruby }

~~~
$ curl localhost:4567?greeting=Hallo%20Hans!
~~~
{: .lang-bash }

~~~
<!DOCTYPE>
<html>
<head>
  <title>Meine Sinatra-App</title>
</head>
<body>
  <p>Hallo Hans!</p> <!-- Hier ist 'Hallo Hans!' eingesetzt -->
</body>
</html>
~~~
{: .lang-html }

---

# Sinatra Params via HTML-Formular

~~~
<form method="post" action="/">
  <input type="text" name="greeting">
  <input type="submit" value="Absenden">
</form>
~~~
{: .lang-html }

---

# Sinatra Sessions

* Ermöglicht Lese-/Schreibzugriff auf Browser-Cookies
* Verwaltet Informationen die über mehrere Requests erhalten bleiben
* Standard-Einstellunge
  * Inaktiv: muss erst aktiviert werden
  * Expiration: Gültig bis der Cookie gelöscht wird
* Alternative Session-Implementierungen:
  * `Rack::Session::Pool`: speichert Daten im Prozess, im Browse-Cookie nur die ID
  * Bspw. ein zentraler Redis-Store

~~~
require 'sinatra/base'

class MyApp < Sinatra::Base
  enable :sessions     # Aktiviert Session-Zugriff via Browser-Cookie
end
~~~
{: .lang-ruby }

---

# Sinatra Sessions

* Zugriff über `session`-Objekt, ähnlich wie bei `params`.
* Mit dem `session`-Objekt kann `@greeting` zwischen mehreren Requests persistiert werden

~~~
require 'sinatra/base'

class MyApp < Sinatra::Base
  enable :sessions     # Aktiviert Session-Zugriff via Browser-Cookie

  get '/' do
    if params['greeting']                      # Wenn über params ein greeting gesetzt
      session['greeting'] = params['greeting'] # dann speicher diesen Wert in der Session/im Cookie
    end
    if session['greeting']
      @greeting = session['greeting']          # Wenn in der session ein greeting gesetzt
    end                                        # dann speicher diesen Wert in der Instanzvariable
    erb :index
  end
end
~~~
{: .lang-ruby }

Funktioniert nur in Verbindung mit Cookies.

---

# Filter

* Repetetiver Code in einer App kann mit [Filtern](http://www.sinatrarb.com/intro.html#Filters) realisiert werden
* Code der für jeden Request ausgeführt wird
* Anwendungszweck:
  * Logging für statistische Auswertungen
  * In der Sinatra-Übung

---

# Filter Beispiel

~~~
require 'sinatra/base'

class MyApp < Sinatra::Base
  before do
    log "Processing request at: #{request.path}"
  end

  get '/' do
    erb :index        # Vor dem get / wird das Logging ausgeführt
  end

  get '/contact' do
    erb :contact      # Vor dem get /contact wird das Logging ausgeführt
  end
end
~~~
{: .lang-ruby }

---

# Weitere Sinatra Features

* Datei-Uploads
* Streaming-Responses (Chat)
* Logging
* …

---

Danke für die Aufmerksamkeit

---

*[ERB]: Embedded Ruby

