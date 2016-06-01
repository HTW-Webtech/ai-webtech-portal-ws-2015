<!---

Lernziele:
- Landkarte des Rails-Frameworks zeichnen
  - MVC-Architektur
  - + Routing
  - + E-Mails
  - + Background jobs
- Beschreibung der Problemstellung
  - Am Beispiel der Sinatra-App
  - 150+ Zeilen Code für triviale App
  - Code in Einzeldatei skaliert nicht
- Rails-Philosophien
  - Omakase
  - DRY
  - Convention over Configuration

--->

# Rails MVC++

*Web application project blueprint*

![MVC in Rails](slides/rails-getting-started/blueprint.png)


---

# Agenda

* MVC?
  * Problemstellung
* Rails Philosophie
* Rails MVC
  * MVC+
  * Philosohpie
* Projektstruktur
* Routing + Controller
* Views
* Models

---

# Es war einmal

![Grenfield Project](slides/rails-getting-started/greenfield-project.png)

Idee für ein Software-Projekt

---

# Problem?

![Chaos](slides/rails-getting-started/network-chaos.png)

Software mit steigender Komplexität…

---

# Situation

* Wie wird Code für ein Projekt organisiert?
  * im Dateisystem
  * in logischen Einheiten meiner Laufzeitumgebung
  * …
* Welche Schnittstellen gibt es?
  * Zum Anwender/Client?
  * Zu dritten Systemen (Datenbank, Web Services, …)
  * zwischen den logischen Einheiten meiner Anwendung
  * …
* … im Web?

---

# Besonderheit: Web vs Desktop

* Kein Session-Management in HTTP
* Jeder Zugriff ein RPC (Remote Procedure Call)
* Multiple Clients
  * verschiedene Browser/OS
  * ggf. andere HTTP-Clients
* …

![Request Response](slides/http/request-response.png)


*[RPC]: Remote Procedure Call

---

# Dennoch: Bekannte Probleme

![Herausforderung angenommen](slides/rails-getting-started/challenge-accepted.jpg)

* Wohldefinierte Probleme mit gängigen Lösungen
* Bspw. MVC-Pattern für System Architektur
* Blick auf Konzepte des Rails Frameworks

---

# Rails is Omakase

![Rails is Omakase](slides/rails-getting-started/dhh-omakase.png)

DHH: Urheber des Rails Frameworks

*[DHH]: David Heinemeier Hanson

---

# Rails is Omakase

<p>
  <dl>
    <dt>o·ma·ka·se</dt>
    <dd>(Japanese restaurant) meal of dishes selected by a chef</dd>
  </dl>
</p>

* Rails ist ein Framework mit starken Meinungen
  * Wie ist die Projekt/Ordner-Struktur?
  * Wie funktioniert das Routing?
  * …
* Viele weitere Architektur-Entscheidungen sind vorgegeben
  * Entwickler hat wenig Einfluss auf Gesamt-Architektur
  * Wohldefinierte (uninteressante) Probleme vom Framework gelöst
  * …

[12/2012: Rails is omakase @ DHHs Blog](http://david.heinemeierhansson.com/2012/rails-is-omakase.html)

---

# Rails Philosophie

* CoC: Convention over Configuration
  * Vorgaben ermöglichen es ohne extra Konfiguration produktiv zu arbeiten
  * ähnlich wie eine Sinatra-App auf Port 4567 started
  * Schritt 1: Konventionen erlernen und diesen folgen
  * Schritt 2: Konventionen erweitern, bei Bedarf umkonfigurieren
* DRY: Dont repeat yourself
  * Vermeide Code-Duplikation, bspw. Boilerplate
  * Vermeide Konzept-Duplikation

---

# Rails CoC Beispiele

* Klassisches Security-Problem: XSS (Cross-Site Scripting)
  * Browser/Client (A) injiziert JavaScript-Code in DB von Server
  * Browser/Client (B) öffnet seite und führt Schadcode aus
* Rails-Lösung: Allen Strings aus DB wird misstraut und werden escaped

---

# Rails is Omakase

* Herausforderungen für Entwickler
  * Erlernen der Konventionen/APIs
  * Das Framework ist nicht für alle Anwendungsfälle geeignet
  * …
* Vorteile für Entwickler
  * Produktivitätsschub durch geringe Setup-Kosten
  * Rails Projekte sind meist sehr ähnlich
  * Einmal gelernt ist man als Entwickler schnell eingearbeitet
  * …
* Zurück zu MVC

---

# MVC

![MVC GUI](slides/rails-getting-started/mvc-gui.png)

---

# MVC

* Architektur Software Pattern für GUIs (Desktop)
* Beschreibt logische/interne Struktur einer Anwendung
  * Definition von Komponenten/Verantwortlichkeiten
  * Definition von Schnittstellen zwischen Komponenten
* Mit Java/Objective-C ins Web portiert
* Bekannt außerhalb von Enterprise durch Rails
* Implementierung variiert von Framework zu Framework
* Das Konzept…

---

# Ziele von MVC

* Vorgabe von Struktur und Schnittstellen:
  * Entkopplung von Code-Komponenten
  * Reduziert Boilerplate-Code
  * Erhöht Wiederverwendbarkeit
  * Erhöht Testbarkeit von Code
  * Komplexitäts-Reduktion durch Teile und Hersche -Prinzip
* Rails MVC…

---

# Rails MVC

![MVC in Rails](slides/rails-getting-started/mvc-rails.png)

---

# Rails MVC

* Models:
  * verantwortlich für Geschäftslogik und Daten (+Persistenz)
  * beschreiben Entitäten und deren Interaktion
* Views:
  * verantwortlich die Darstellung im Browser/Client (HTML, JSON, …)
  * auch assets, wie: Bilder, Schriftarten, Stylesheets (CSS), etc.
* Controller:
  * verantwortlich für das Zusammenspiel von Models+Views
  * einzige direkte Schnittstelle zum Browser/Client
* *Routes + Dispatcher*:
  * verantwortlich für die Verknüpfung von URL mit Controller-Code

---

# Rails MVC

![MVC in Rails](slides/rails-getting-started/mvc-not-sure.png)

---

# Request -> Response Zyklus

* Browser stellt HTTP GET Anfrage
* Web-Server leitet Anfrage an Rails-App
  * Dispatcher analysiert URL-String
  * Und identifiziert den geeigneten Controller
* Controller bekommt Request und erzeugt Response
  * Dazu nutzt er Models für Zugriff auf Geschäftslogik
  * Und Views dienen als Repräsentation für das Ergebnis
* Das Response-Objekt besteht aus HTTP Headern und Body (HTML-String)

---

# Schritt 1: Routing + Dispatcher

`http://www.example.com/contact-requests/5.html`

![Rails Routing](slides/rails-getting-started/rails-cycle-step1.png)

---

# Routes + Dispatcher

Routes in Sinatra

~~~
get '/contact-requests/:id.html' do
  # Hier fehlt noch Code, der das eigentliche Objekt aus der DB liest.
  erb :contact # Rendert das contact-Template
end
~~~
{: .lang-ruby }

Routes in Rails

~~~
# Statt der Implementierung enthält die Route nur einen Bezeichner,
# `contact_requests#show` der den Controller referenziert, der diese
# Anfrage bearbeiten soll.
get '/contact-requests/:id', to: 'contact_requests#show'
~~~
{: .lang-ruby }

---

# Schritt 2: Controller

![MVC-Controller in Rails](slides/rails-getting-started/rails-mvc-routing-controller.png)

---

# Controller

In Sinatra ist der "Controller" Bestandteil der Route

~~~
get '/contact-requests/:id.html' do
  # Der Code innerhalb einer Route hat Zugriff auf ein Hash-ähnliches `params`-Objekt.
  # Dieses gibt Zugriff auf POST/GET Parameter mit dem User-Input verarbeitet wird.
  @contact_request = ContactRequest.find(params[:id])
  erb :contact # Rendert das contact-Template
end
~~~
{: .lang-ruby }

Rails Controller

~~~
# Das ist der `ContactRequests`-Controller. Der Name ist i.d.R. Plural, außer
# die zu verarbeitende Ressource exitiert wirklich nur 1mal (aus Nutzersicht).
class ContactRequestsController < ApplicationController
  def show
    # Ein Rails-Controller erbt von `ApplicationController`.
    # GET/POST Parameter können über das `params`-Objekt ausgelesen werden.
    @contact = ContactRequest.find(params[:id]) <- Hier geht es gleich weiter
    # In einem Rails-Controller ist wird das Template für die View aus dem
    # Controller und
  end
end
~~~
{: .lang-ruby }

---

# Rails Controller

* Erbt Verhalten von `ApplicationController`
* Nimmt Request-Objekt und (User-Input) params entgegen
* Verwaltet Session- und Cookie-Daten
* Authentifizierung/Authorisierung von Nutzern
* Rendert Templates oder leitet Browser/Client via HTTP-Header weiter
* Validieren/Reinigen von Eingabe-Parametern (GET/POST)
* Speichern oder Lesen von Daten in/aus einer Daten-Quelle via Model
* Starten von asynchronen Jobs (bspw. E-Mail Versand)
* …

---

# Schritt 3: Model

![MVC-Model in Rails](slides/rails-getting-started/rails-mvc-model.png)

---

# Model

Model mit DataMapper

~~~
class ContactRequest
  include DataMapper::Resource
  property :id, Serial
  property :name, String
  property :email, String
  property :message, Text
end
~~~
{: .lang-ruby }

Rails Models

~~~
class ContactRequest < ActiveRecord::Base
  # Attribute von Rails-Models werden nicht via Code definiert, sondern
  # aus der Datenbank ausgelesen.
end
~~~
{: .lang-ruby }

---

# Rails Model

* Erbt Verhalten von `ActiveRecord::Base`
* `ActiveRecord` ist die Standard-ORM von Rails
* Attribute/Felder werden aus DB ausgelesen
* Vorraussetzung: SQL-Datenbank und -Tabellen existieren bereits

---

# Schritt 4: View

![MVC-View in Rails](slides/rails-getting-started/rails-mvc-view.png)

---

# Views

Views in Sinatra

~~~
# views/admin.erb
<h1>Admin-Bereich</h1>
<p>Hallo <%= @user_name %></p>
…
~~~

Rails Views

~~~
# views/admin.html.erb
<h1>Admin-Bereich</h1>
<p>Hallo <%= @user_name %></p>
…
~~~

---

# Rails Views

* HTML Front End besteht meist aus Layout und mehreren Templates
  * Layout: Das Grundgerüst der Webseite enthält doctype, head, body und footer
  * Template(s): In sich geschlossene Teile des HTML Front Ends werden in Templates gepflegt
* Eine View sollte so wenig Ruby-Code wie möglich enthalten

---

# Request -> Response

![MVC in Rails](slides/rails-getting-started/mvc-rails.png)

Weiter: Projektstruktur

---

# Rails Projektstruktur

* Rails erzeugt umfassende Projekt-Struktur mit jedem Projekt
* Jedes Rails-Projekt startet mit:

    rails new projekt-name
    …

---

# Rails Projektstruktur

~~~
tree . -L 1 # Nur 1. Ordnerebene anzeigen
.
├── Gemfile      # ruby gems die dieses Projekt benutzt
├── Gemfile.lock
├── README.md
├── Rakefile     # ähnlich wie ein Makefile
├── app          # Hier lebt der Haupt-Code
| …
└── vendor
~~~
{: .lang-bash }

---

# Rails Projektstruktur

~~~
tree app -L 1 # Nur 1. Ordnerebene anzeigen
app
├── assets       # JavaScript, CSS und Bild-Dateien und Schriftarten
├── channels     # Ruby-Klassen für Web-Sockets Kommunikation (bpsw. Realtime-Chat)
├── controllers  # Controller-Code
| …
├── jobs         # ActiveJob-Code für Background-Processing
├── mailers      # ActionMailer-Code für E-Mail Versand
├── models       # ActiveRecord-Code DB-Zugriff via ORM
└── views        # Template-Dateien
~~~
{: .lang-bash }

---

# Stopp

![Confused](slides/rails-getting-started/confused.png)

---

# Herangehensweise

* Rails ist ein stark gewachsenes Framework
* Es bietet viele Werkzeuge
  * Bspw. Channels habe ich selber noch nicht genutzt
* Zum Lernen/Anwendungen der Konzepte beginnen wir mit MVC
  * Models: ActiveRecord (ähnlich DataMapper)
  * Views: sehr ähnlich zu den Views bei Sinatra
  * Controller: ähnlich dem Routes-Code bei Sinatra
* Wir machen hier eine Theorie-Pause
* Nächste Woche: Rails ORM ActiveRecord Models und Migrations

---

# Bis dahin

* Lynda-Video [Ruby on Rails: Essential Training](http://www.lynda.com/Ruby-Rails-tutorials/Welcome/139989/159038-4.html)
  * Nutzt Video als Lern-Unterstützung

---
