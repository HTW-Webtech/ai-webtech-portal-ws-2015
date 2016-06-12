# Rails Routing + Controller

---

# Agenda

* Allgemeines zu Routes <-> Controllers
* Rails Routing
* Rails Controller

---

# Rails Routes + Controllers

![Routing Job ](slides/rails-controllers/air-traffic-controller.jpg)

Rails' Routing-Funktionalität ordnet jedem Request den richtigen Controller zu

---

# Rails Routes + Controllers #2

* Routes + Controllers definieren "API" einer APP
* Routes: Definieren API-Input
* Controllers: Implementieren API-Output (Response-Body + Codes)

---

# Rails Routes

* Verknüpfung von Controller-Code mit URI
* HTTP-Request Parameter parsing
* URL-Helper für Views (HTML-Templates)
* Konfigurationsdatei: config/routes.rb
* `rake routes`-Befehl listet Routes

---

# Rails Routes

* CRUD-Operationen
* Basis-Operationen im Umgang mit Web-Ressourcen
* Ressource: Datenobjekt mit einer URI (e.g. http://foo.com/object/12)
* Translation der Operationen in HTTP-Aufrufe
* C[reate] => HTTP POST: Ressource(n) erzeugen
* R[ead] => HTTP GET: Ressource(n) lesen
* U[pdate] => HTTP PUT/PATCH: Ressource(n) ändern
* D[elete] => HTTP DELETE: Ressource(n) löschen

---

# Routes Beispiel

~~~
# config/routes.rb
Rails.application.routes.draw do
  resources :blogs
end
~~~
{: .lang-ruby }

Ausgeschriebene Variante

~~~
# config/routes.rb
Rails.application.routes.draw do
  # URI             # Controller (Klasse) + Action (Methode)
  get '/blogs',     'blogs#index'
  get '/blogs/:id', 'blogs#show'
  …
  post '/blogs',    'blogs#create'
end
~~~
{: .lang-ruby }

---

# Routes Beispiel #2

~~~
$ rake routes
  Prefix Verb   URI Pattern        Controller#Action
    blogs GET    /blogs             blogs#index
          POST   /blogs             blogs#create
 new_blog GET    /blogs/new         blogs#new
edit_blog GET    /blogs/:id/edit    blogs#edit
     blog GET    /blogs/:id         blogs#show
          PATCH  /blogs/:id         blogs#update
          PUT    /blogs/:id         blogs#update
          DELETE /blogs/:id         blogs#destroy
~~~
{: .lang-bash }

* URL: http://www.example.com/blogs/123-abc
  * `params[:id] = "123-abc"`
* URL: http://www.example.com/blogs/15
  * `params[:id] = "15"`

---

# Semantik: GET /blogs/new

Gib mir ein HTML-Formar zur Erstellung eines Blogs

---

# Semantik: POST /blogs

* Nimm diese Paramter zur Erstellung eines neuen Blogs
* Blog-Parameter (Titel, Beschreibung,…) sind im Body des Requests encodiert

---

# Semantik: GET /blogs/12

* Gib mir den Blog mit der ID 12
* Slugs/Permalinks sind Implementierungsdetail
* `/blogs/12-titel-des-blogs`

---

# Semantik: GET /blogs

* Gib mir eine Liste von Blogs
* Paginierung bspw. via GET-Parameter
* `/blogs?page=1`, `/blogs?page=2`

---

# Semantik: GET /blogs/12/edit

* Gib mir ein HTML-Formar zur Bearbeitung des Blogs mit der ID 12

---

# Semantik: PATCH/PUT /blogs/12

* Übschreibe die Daten des Blogs mit der ID 12 mit den folgenden Parametern
* Blog-Parameter sind im Body des Requests encodiert

---

# Semantik: DELETE /blogs/12

* "Lösche den Blog mit der ID 12"
* Verschaltete Ressourcen via URI abbilden
* Gedacht um Model-Relations abzubilden

---

# Routes Beispiel
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
             Prefix Verb   URI Pattern                                 Controller#Action
      blog_comments GET    /blogs/:blog_id/comments(.:format)          comments#index
                    POST   /blogs/:blog_id/comments(.:format)          comments#create
   new_blog_comment GET    /blogs/:blog_id/comments/new(.:format)      comments#new
  edit_blog_comment GET    /blogs/:blog_id/comments/:id/edit(.:format) comments#edit
       blog_comment GET    /blogs/:blog_id/comments/:id(.:format)      comments#show
                    PATCH  /blogs/:blog_id/comments/:id(.:format)      comments#update
                    PUT    /blogs/:blog_id/comments/:id(.:format)      comments#update
                    DELETE /blogs/:blog_id/comments/:id(.:format)      comments#destroy

        # URL: http://www.example.com/blogs/123-abc/comments/12
          => params[:id] = "12"
          => params[:blog_id] = "123-abc"
~~~
{: .lang-bash }

---

# Routes Zusatz-Features

* Bspw. namespacing + Passwort-Schutz
* `/admin/foo/bar` alles unter `/admin` ist Passwort-geschützt
* Redirects: bspw. `/old-system` => `/new-system`

---

# Rails Controller

* Input: Request, Output: Reponse mit:
* a) Code: HTTP Status Code
* b) Body: Text (meist HTML)
* Mittelsmann zwischen Model + Views
* Zugriff auf session, cookies, request, response
* Template-Rendering, HTTP-Redirects

---

# Controller Beispiel

~~~
# app/controllers/welcome_controller.rb
class WelcomeController < ApplicationController
  def show
    render html: '<strong>Dieser Text wird gerendert</html>', status: 200 # Response-Code 200
  end
end
~~~
{: .lang-ruby }

---

# Controller Beispiel mit Model + View

~~~
# app/controllers/blogs_controller.rb
class BlogsController < ApplicationController
  # http://www.example.com/blogs/12
  def show
    @blog = Blog.find(params[:id]) # params[:id] => 12
    # Der `render`-Aufruf ist optional. Ohne expliziten render-Aufruf, passiert:
    # render template: 'blogs/show', status: 200
  end

  def edit
    @blog = Blog.find(params[:id])
    # Impliziter render-Aufuruf:
    # render template: 'blogs/edit', status: 200
  end
end
~~~
{: .lang-ruby }

---

# Params

* params-Hash bietet u.a. Lesezugriff auf GET/POST Parameter
* params unterstützt Strings/Arrays/Hashes

---

# Params Beispiel

~~~
# app/controllers/blogs_controller.rb
# http://www.example.com/blogs/12
class BlogsController < ApplicationController
  def show
    params[:test] == 'bar'          # /blogs/12?test=bar
    params[:xids] == ['1', '2']     # /blogs/12?xids[]=1&xids[]=2
    params[:foo]  == { baz: 'bar' } # /blogs/12?foo[baz]=bar
  end
end
~~~
{: lang-ruby }

---

# Strong Params

* Rails Whitelisting-Feature für HTTP Parameter
* HTTP Parameter sind grundsätzlich als *unsafe* markiert
* Jeder Parameter muss via permit!-Aufruf *safe* markiert werden

---

# Strong Params Beispiel

~~~
# app/controllers/blogs_controller.rb
class BlogsController < ApplicationController
  def create
    @blog = Blog.new(blog_params)
  end

  private

  def blog_params
    # Erzeugt einen neuen Hash der nur noch die als *safe* markierten
    # Parameter :title und :description enthält.
    # Beispiel: params[:blog] = { title: 'Test', category: 'Sport', evil: 'Code' }
    # Wird mit:
    params.require(:blog).permit(:title, :category)
    # zu: { title: 'Test', category: 'Sport' }
  end
end
~~~
{: lang-ruby }

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

# Live-Coding

* Scaffolding für Projekte
* Anlegen einer Route für Projekte
* Anlegen eines Controllers für Projekte
