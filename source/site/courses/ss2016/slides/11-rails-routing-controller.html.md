# Rails Routing + Controller

---

# Agenda

* Routes
  * CRUD
  * Non-CRUD
  * Nested Routes
* Controller
  * Konventionen
  * Model-Zugriff
  * Params + Strong parameters

---

# Routes

![Routing Job ](slides/rails-controllers/air-traffic-controller.jpg)

Routes: Mapping URLs to (Controller)-Code

---

# Routes

* URL <-> Code Mapping
  * CRUD Routing
  * Custom Routing
  * Nested Routes
  * Conditional Routing, …
* URL-Helper für Views (HTML-Templates)
* Konfiguration in: `config/routes.rb`
* `rake routes`: Listet verfügbare Routen auf
* Zunächst: CRUD Routing

---

# CRUD Routing

* CRUD-Operationen
  * URLs zur Verwaltung von Ressourcen (DB-Objekten)
  * C[reate] => HTTP POST: Ressource(n) erzeugen
  * R[ead]   => HTTP GET: Ressource(n) lesen
  * U[pdate] => HTTP PUT: Ressource(n) ändern
  * D[elete] => HTTP DELETE: Ressource(n) löschen

---

# CRUD Beispiel

~~~
# config/routes.rb
Rails.application.routes.draw do
  resources :blogs   # Definiert CRUD-Operationen f. Blogs
end
~~~
{: .lang-ruby }

Erzeugt die folgenden URL-Routen:

~~~
$ rake routes
   Prefix Verb   URI Pattern               Controller#Action
    blogs GET    /blogs(.:format)          blogs#index
          POST   /blogs(.:format)          blogs#create
 new_blog GET    /blogs/new(.:format)      blogs#new
edit_blog GET    /blogs/:id/edit(.:format) blogs#edit
     blog GET    /blogs/:id(.:format)      blogs#show
          PATCH  /blogs/:id(.:format)      blogs#update
          PUT    /blogs/:id(.:format)      blogs#update
          DELETE /blogs/:id(.:format)      blogs#destroy
~~~
{: .lang-bash }

---

# CRUD Beispiel

~~~
   Prefix Verb   URI Pattern               Controller#Action
    blogs GET    /blogs(.:format)          blogs#index
          POST   /blogs(.:format)          blogs#create
edit_blog GET    /blogs/:id/edit(.:format) blogs#edit
~~~
{: .lang-bash }

* `Prefix`: Wird für die URL-Helper verwendet (später)
* `Verb`: Die erwartete HTTP-Methode (GET, POST, …)
* `URI Pattern`: URL für das Matching
  * `:id`: Dynamischer URL-Parameter
  * `(.:format)`: Optionales Format, z.Bspw. `.html`
* `Controller#Action`: Beschreibt den Controller-Code der für diese URL aufgerufen wird
* Controller#Action im Detail

---

# CRUD Beispiel

~~~
   Prefix Verb   URI Pattern      Controller#Action
    blogs GET    /blogs           blogs#index
          POST   /blogs           blogs#create
edit_blog GET    /blogs/:id/edit  blogs#edit
~~~
{: .lang-bash }

* Controller#Action beschreibt Controller und Methode für URL
* `blogs#index` instanziiert den `BlogsController` und ruft dessen `index`-Methode auf
  * Muster: **blogs**#index => BlogsController
  * Muster: blogs**#index** => `index`-Methode von BlogsController

Da `(.:format)` optional, der Lesbarkeit halber entfernt

---

# CRUD Beispiel Blogs

~~~
  Prefix Verb   URI Pattern        Controller#Action
    blogs GET    /blogs             blogs#index   <-- Nutzen dieselbe URL
          POST   /blogs             blogs#create  <-/
 new_blog GET    /blogs/new         blogs#new
edit_blog GET    /blogs/:id/edit    blogs#edit
…
~~~
{: .lang-bash }

* `http://www.example.com/blogs`: je nach HTTP Verb
  * `GET /blogs`: `blogs#index`
  * `POST /blogs`: `blogs#create`
* Platzhalter `:id` in der Route für `blogs#edit` über `params`-bereitgestellt
  * `GET /blogs/821/edit` => `params[:id] = 821`
* Weiter: Semantik von CRUD-Methoden


---

# Semantik: GET /blogs

* Gib eine Liste (den Index) von Blogs zurück
* Selten möchte man wirklich ALLE Elemente
  * Paginierung bspw. via GET-Parameter
  * `/blogs?page=1`, `/blogs?page=2`

---

# Semantik: POST /blogs

* Nimm Formular-Felder zur Erzeugung eines neuen Blogs entgegen und speichert diesen
* Parameter (Titel, Beschreibung,…) sind im Body des POST Requests encodiert

---

# Semantik: GET /blogs/new

* Gib ein HTML-Formar zur Erstellung eines Blogs zurück

---

# Semantik: GET /blogs/12/edit

* Gib ein HTML-Formar zur Bearbeitung des Blogs mit der ID 12 zurück

---

# Semantik: GET /blogs/12

* Gib den Blog mit der ID 12 zurück
* Oft möchte man eine Ressource (wie Blog) nicht über die DB-ID adressieren
* Stattdessen nutzt man einen `slug` der den Blog identifiziert
  * Statt `/blogs/12` => `/blogs/titel-des-blogs`
  * Slug-Zugriff muss selbst implementiert werden

---

# Semantik: PUT /blogs/12

* Übschreibe die Daten des Blogs mit der ID 12 mit den folgenden Parametern
* Blog-Parameter sind im Body des Requests encodiert

---

# Semantik: DELETE /blogs/12

* Lösche den Blog mit der ID 12

---

# Non-CRUD URLs

* CRUD reicht i.d.R. nicht aus um Funktionalität abzubilden, Beispiel:

  Ein Blog soll nicht direkt veröffentlicht werden, da der Inhalt meist häufig überarbeit werden soll.
  Es soll einen Toogle-Mechanismus geben der den Blog aktiv/inaktiv schaltet.

---

# Non-CRUD URLs

~~~
# config/routes.rb
Rails.application.routes.draw do
  resources :blogs do
    member do
      post 'toggle_activation'
    end
  end
end
~~~
{: .lang-ruby }

~~~
                Prefix Verb   URI Pattern                            Controller#Action
toggle_activation_blog POST   /blogs/:id/toggle_activation(.:format) blogs#toggle_activation
                 blogs GET    /blogs(.:format)                       blogs#index
                       POST   /blogs(.:format)                       blogs#create
              new_blog GET    /blogs/new(.:format)                   blogs#new
             edit_blog GET    /blogs/:id/edit(.:format)              blogs#edit
                  blog GET    /blogs/:id(.:format)                   blogs#show
                       PATCH  /blogs/:id(.:format)                   blogs#update
                       PUT    /blogs/:id(.:format)                   blogs#update
                       DELETE /blogs/:id(.:format)                   blogs#destroy
~~~
{: .lang-ruby }

* URI Pattern: `POST /blogs/:id/toggle_activation`
* Controller#Action: `BlogsController` => `toggle_activation`-Methode

---

# Non-CRUD URLs

~~~
# config/routes.rb
Rails.application.routes.draw do
  resources :blogs do
    member do
      post 'toggle_activation'
    end
  end
end
~~~

* URI Pattern: `POST /blogs/:id/toggle_activation`
* Controller#Action: `BlogsController` => `toggle_activation`-Methode
* Weiter verschaltete Routen

---

# Nested Routes

* Häufig stehen Ressourcen in Beziehung zueinander
* Bspw. in Übung `Blogs` <-> `Kommentare`
* Diese Beziehung kann über das Routing in URLs ausgedrückt werden
* Dabei werden URLs verschachtelt/genested

~~~
# config/routes.rb
Rails.application.routes.draw do
  resources :blogs do
    resources :comments
  end
end
~~~
{: .lang-ruby }

---

# Nested Routes Beispiel

~~~
$ rake routes
             Prefix Verb   URI Pattern                       Controller#Action
      blog_comments GET    /blogs/:blog_id/comments          comments#index
                    POST   /blogs/:blog_id/comments          comments#create
   new_blog_comment GET    /blogs/:blog_id/comments/new      comments#new
  edit_blog_comment GET    /blogs/:blog_id/comments/:id/edit comments#edit
       blog_comment GET    /blogs/:blog_id/comments/:id      comments#show
                    PATCH  /blogs/:blog_id/comments/:id      comments#update
                    PUT    /blogs/:blog_id/comments/:id      comments#update
                    DELETE /blogs/:blog_id/comments/:id      comments#destroy

        # URL: http://www.example.com/blogs/123-abc/comments/12
          => params[:id] = "12"
          => params[:blog_id] = "123-abc"
~~~
{: .lang-bash }

* IDs für den Blog und Kommentar werden beide in URL eingebettet
* Weiter: URL-Helper

---

# URL-Helper

* In Views zur Verlinkung von Ressourcen verwendet
* Wird mit Hilfe der `config/routes.rb` erzeugt
* Beispiel Blogs:

~~~
   Prefix Verb   URI Pattern      Controller#Action
    blogs GET    /blogs           blogs#index
          POST   /blogs           blogs#create
edit_blog GET    /blogs/:id/edit  blogs#edit
~~~

* Prefix: Bietet eine `_path` und eine `_url`-Methode
  * `_path`: Entält nur den URL-Pfad
  * `_url`: URL-Pfad mit Domain
  * `blogs_path` => `/blogs`
  * `blogs_url` => `http://www.example.com/blogs`
  * `edit_blogs_path(id: 12)` => `/blogs/12/edit`

---

# URL-Helper

* Funtkioniert auch mit nested Routes

~~~
             Prefix Verb   URI Pattern                       Controller#Action
      blog_comments GET    /blogs/:blog_id/comments          comments#index
                    POST   /blogs/:blog_id/comments          comments#create
   new_blog_comment GET    /blogs/:blog_id/comments/new      comments#new
~~~
{: .lang-bash }

* `blog_comments_path(blog_id: 1)` => `/blogs/1/comments`
* `new_blog_comment_url` => `http://www.example.com/blogs/1/comments/new`
* Weiter: Sonstige Routing Features

---

# Routes Zusatz-Features

* Routing bietet noch weitere Features, zwei Beispiele
* URL-Bereiche die mit `/admin` beginnen mit Passwort versehen
  * `/admin/foo/bar` alles unter `/admin` ist Passwort-geschützt
* Wenn URLs geändert werden, sollten Redirects eingerichtet werden
  * Redirects: bspw. `/old-system` => `/new-system`
* [Offizielle Dokumentation](http://guides.rubyonrails.org/routing.html) zum Routing
* Weiter: Controller

---

# Controller

* Nimmt `Request` entgegen und erzeugt `Reponse` mit:
  * a) HTTP Status Code
  * b) Body: meist HTML
* Mittelsmann zwischen Model + Views
* Aufgaben:
  * Kommnikation mit Browser
  * Template-Rendering, HTTP-Redirects
  * Delegiert DB-Operationen an Models
* Zugriff auf `session`, `cookies`, `request`, `response`

---

# Controller Konventionen

* Code liegt im Ordner: `apps/controller`
* Controller erbt immer von `ApplicationController`
  * `ApplicationController` stellt API-Zugriff bereit
    * Zugriff auf `request`, `response`, `session`, etc.
* Controller-Name i.d.R. Plural
  * Controller für Blogs => `BlogsController`
* Template-Name wird aus Controller- und Action-Name abgeleitet
  * `BlogsController` und `show`-Action
  * `app/views/blogs/show.html.erb`-Template

---

# Controller Beispiel

~~~
# config/routes.rb
Rails.application.routes.draw do
  resources :blogs   # Definiert CRUD-Operationen f. Blogs
end
~~~
{: .lang-ruby }

~~~
# app/controllers/blogs_controller.rb
class BlogsController < ApplicationController
  def index
    @greeting = "Hallo Rails!"
  end
end
~~~
{: .lang-ruby }

~~~
# app/views/blogs/index.html.rb
<h1><%= @greeting %></h1>
~~~
{: .lang-html }

* `/blogs`: Gibt "Hallo Rails!" und Status Code 200 zurück

---

# Controller mit Logik

~~~
# app/controllers/blogs_controller.rb
class BlogsController < ApplicationController
  def show
    @blog = Blog.find(params[:id]) # params[:id] wird aus URL extrahiert
    # render template: 'blogs/show', status: 200
  end
~~~
{: .lang-ruby }

~~~
# app/views/blogs/show.html.rb
<h1><%= @blog.title %></h1>
<p><%= @blog.body %></p>
~~~
{: .lang-html }

* `/blogs/14`: Rendert HTML-Seite mit Blog-Informationen

---

# Params

* `params` bietet Lesezugriff auf GET/POST Parameter
* Parameter werden als Ruby `Hash` zurückgegeben
* Zugriff via `:symbol` oder `"name"`, meist `:symbol`
* HTTP GET: params aus Query-Params: `http://example.com?foo=bar`
  * `params[:foo] == "bar"`
  * `params["foo"] == "bar"`
* HTTP POST: params bspw. von Formular-Feldern
  * Query-Params haben höhere Präzedenz als POST Parameter
* Weiter: Anwendungszweck params

---

# Params

~~~
<form action="/blogs" method="post">
  <input type="text" name="blog[title]" />
  <input type="text" name="blog[description]" />
  …
</form>
~~~
{: lang-html }

Formular wird via HTTP POST verschickt. Zugriff via `params`:

~~~
# app/controllers/blogs_controller.rb
class BlogsController < ApplicationController
  def create
    # params == { blog: { title: "Hi", description: "Test" } }
    @blog = Blog.create(params[:blog])
    # @blog = Blog.create(title: "Hi", description: "Test")
  end
end
~~~
{: lang-ruby }

* Parameter aus `params` an der Stelle `blog` werden ohne Prüfung weitergereicht
* Dies kann zu folgendem Sicherheitsproblem führen:

---

# Params Whitelisting

DB-Tabelle `users` für Nutzer:

~~~
id | email | first_name | … | is_admin |
~~~

Controller-Code für Registrierung:

~~~
# app/controllers/users_controller.rb
class UsersController < ApplicationController
  def create
    @user = User.create(params[:user])
  end
end
~~~
{: lang-ruby }

* Wenn `params[:user][:is_admin] == 1` gesetzt ist, wird ein Admin-User angelegt
* Lösung: Whitelisting mit Strong Params

---

# Strong Params

* Lösung: Whitelisting der Parameter im Controller
* HTTP Parameter sind als *unsafe* markiert
* Jeder Parameter wird explizit via `permit!` freigegeben

---

# Strong Params Beispiel

~~~
# app/controllers/users_controller.rb
class UsersController < ApplicationController
  def create
    @user = User.create(user_params)
  end

  private

  def user_params
    # Beispiel:
    #  params = { user: { email: 'hans@web.de', is_admin: '1' } }
    params.require(:user).permit(:email)
    # entfernt `is_admin`: { email: 'hans@web.de' }
  end
end
~~~
{: lang-ruby }

* Weiter: Template Rendering

---

# Template-Rendering

* render-Methode ist implizit und auto-generiert Template-Pfad
* Alternativ kann `render` auch explizit aufgerufen werden
* Instanz-Variablen aus dem Controller sind in View verfügbar

---

# Template-Rendering Beispiel

~~~
# app/controllers/blogs_controller.rb
class BlogsController < ApplicationController
  def new
    @blog = Blog.new
    # Rendert implizit app/views/blogs/new.html.erb
  end
end
~~~
{: lang-ruby }

---

# HTTP-Redirects

* Ggf. soll ein GET/POST mit einem Redirect beantwortet werden
* Bspw. nach dem POST zum Erstellen einer Ressource folgt redirect zur Ressource

---

# HTTP-Redirects Beispiel

~~~
# app/controllers/blogs_controller.rb
class BlogsController < ApplicationController
  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      # Hier bekommt der Browser einen Redirect zu `blogs_path(@blog)`.
      # `blogs_path(@blog)` erzeugt folgenden String: "/blogs/123",
      # wobei 123 die ID von @blog ist.
      redirect blogs_path(@blog)
    else
      # `render :edit` bedeutet dasselbe wie `render template: 'blogs/edit'`
      render :edit
    end
  end
end
~~~
{: .lang-ruby }

---

# Sonstige Controller Features

* Zugriff auf `session`, `cookie`, `request` und `reponse`
* Ähnliche Syntax wie in Sinatra
* [Offizielle Dokumentation](http://guides.rubyonrails.org/action_controller_overview.html) zu Rails Controller

---

# Übung heute

* Rails Tutorial
