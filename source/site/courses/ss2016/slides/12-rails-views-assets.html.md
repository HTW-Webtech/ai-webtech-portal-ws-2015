# Rails Views + Assets

---

# Agenda

* Layouts, Templates, Partials
* Template-Rendering
* ActionView::Base + ERB
* FormBuilder
* View Helper
* Custom Helper
* Assets

---

# Layouts, Templates, Partials

* Alle drei sind Views:
  * HTML-Code mit Ruby für serverseitige Dynamik im HTML
* Layout + Template
  * Generieren zusammen die HTML-Seite
  * Layout, Template können Partials verwenden
* Partial
  * Fasst redundanten HTML + Ruby zusammen

---

# Layout + Templates

![Rails Layout + Templates](slides/rails-views-assets/layout-template.png)

---

# Partials

![Rails Partials](slides/rails-views-assets/partials.png)

---

# Template-Rendering

* Controller wählt u.a. Template für HTTP-Response aus
* Genauer: Layout, Template und HTTP-Header

~~~
# app/controllers/projects_controller.rb
class ProjectsController < ApplicationController
  def show
    render # Layout:   app/views/application.html.erb
           # Template: app/views/projects/show.html.erb
  end
end
~~~
{: .lang-ruby }

---

# Layouts

* Standard-Layout: `app/views/layouts/application.html.erb`
* Verantwortlich für das HTML-Gerüst
  * Bspw. meta-Tags, favicon, Navigation, …
  * Inkludiert Stylesheet- und JavaScript-Dateien
  * …
* `yield`: Platzhalter für Template
* Es kann beliebig viele Layouts geben
  * Abweichendes Layout bspw. für Landingpages, Microsites, …

---

# Layout Beispiel

~~~
<!-- app/views/layouts/application.html.erb -->
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="author" content="Gregory Igelmund">
    <%= stylesheet_link_tag :application, media: 'all' %>
    <%= javascript_include_tag :application %>
  </head>
  <body>
    <%= yield # Hier setzt Rails das Template %>
  </body>
</html>
~~~
{: .lang-html }

---

# Templates

* HTML-Bausteine die im Layout eingesetzt werden
* Standard-Template: Dateipfad zum Template aus Controller-Action abgeleitet

---

# Template Beispiel

~~~
<!--
  Template f. den Aufruf von ProjectsController#show:
  app/views/projects/show.html.erb
-->
<h1><%= @project.title %></h1>
<p><%= @project.description %></p>
<div>
  <%= link_to 'Bearbeiten', edit_project_path(@project) %>
</div>
~~~
{: .lang-html }

---

# Partials

* Vermeidet Redundanz beim Rendering desselben HTML-Blocks
* Konvention: Partial Dateiname beginnt immer mit `_`
* Aufruf von Partial via `render 'path/to/some_widget', variable: "Test"`
  * Partial Dateiname: `_some_widget.html.erb`

---

# Partials Beispiel

~~~
<!-- app/views/projects/new.html.erb -->
<h1>Neues Projekt</h1>
<%= render 'projects/form', project: @project %>
~~~
{: .lang-html }

~~~
<!-- app/views/projects/_form.html.erb -->
<h1><%= project.title %></h1>
~~~
{: .lang-html }

---

# ActionView::Base + ERB

* Layouts, Templates, Partials sind Views
* View: Beliebige* Template-Sprache
* Standard: Embedded Ruby oder ERB
* Alternative populäre Template-Sprachen
  * HAML
  * Slim
  * Liquid
  * …

---

# Embedded Ruby + HTML

Erlaubt beliebigen Ruby-Code in HTML-Views

~~~
<!-- app/views/projects/new.html.erb -->
<% if true %>
<%= "Shopping List" %>
<% end %>
<ol>
<% ["Banana", "Coconut"].each do |item| %>
  <li><%= item %><li>
<% end %>
</ol>
~~~
{: .lang-html }

---

# Helper Code

* Innerhalb einer View hat man Zugriff auf Helper Code
* Beispiele
  * FormBuilder
  * URL-Helper
  * NumberHelper
  * SanititzeHelper
  * CacheHelper
* [Helper-Übersicht](https://github.com/rails/rails/blob/master/actionview/lib/action_view/helpers.rb) und [Dokumentation](http://api.rubyonrails.org/)
* Auch eigene Helper-Methoden möglich

---

# FormBuilder

* Erzeugt <form>-Tag für Versenden von HTML-Formularen
* Generiert automatisch `form`-Attribute wie `action` und `method`
* …
* Mehr zum FormBuilder in der [offiziellen Doku](http://guides.rubyonrails.org/form_helpers.html)

---

# FormBuilder

~~~
<!-- app/views/projects/_form.html.erb -->
<%= form_for project do |f| %>
  <%= f.label :title %>
  <%= f.text_field :title %>
<% end %>
~~~
{: .lang-html }

Erzeugt etwa folgendes HTML

~~~
 <form accept-charset="UTF-8" action="/projects" method="post">
   <label for="project_title">Title</label>
   <input id="project_title" name="project[title]" type="text" value="" />
   <input type="submit" value="Create project" />
 </form>
~~~
{: .lang-html }

---

# View Helper

* ActionView::Base stellt Helper-Code/Methoden bereit
* Bspw. FormBuilder
* URL Helper
* AssetTagHelper
* NumberHelper
* … CacheHelper, etc.

---

# URL Helper

* Dynamisch generierte Methoden zur Erzeugung von URLs
* URL Helper werden aus `config/routes.rb` abgeleitet

~~~
# app/views/projects/show.html.erb
<p><a href="<%= edit_project_path(@project) %>">Edit</a> Project</p>
~~~
{: .lang-html }

~~~
# Erzeugt folgenden HTML-Output
<p><a href="/project/12/edit">Edit</a> Project</p>
~~~
{: .lang-html }

---

# AssetTagsHelper

* Generiert HTML-Tags zur Einbindung von statischen Dateien
* CSS/JS/Bilder: `app/assets/{stylesheets,javascripts,images}`
* AssetTagsHelper API
  * `image_tag`: Bindet Bild aus app/assets/images ein
  * `javascript_include_tag`: Bindet JavaScript aus app/assets/javascripts ein
  * `stylesheets_include_tag`: Bindet Stylesheet aus app/assets/stylesheets eink
  * `video_tag`: Bindet Video aus public/videos-Ordner ein
  * `audio_tag`: Bindet Video aus public/audios-Ordner ein

---

# AssetTagsHelper Beispiel

~~~
<!-- app/views/projects/show.html.erb -->
<%= image_tag 'foo/bar.png' %>          # Pfad: assets/images/foo/bar.png
<%= javascript_include_tag 'example' %> # Pfad: assets/javascripts/example.js
<%= video_tag 'kitten.mp4' %>           # Pfad: videos/kitten.mp4
~~~
{: .lang-html }

---

# NumberHelper

* Methoden zur Konvertierung von Zahlen in formatierte Strings
* Bspw: Telefonnummern, Prozentangaben, Währungen, …
* NumberHelper API:
  * number_to_percentage (Prozentzahldarstellung)
  * number_to_currency (Darstellung in Geldeinheiten mit Währung)
  * number_to_phone (Darstellung als US-Telefonnummer)

---

# NumberHelper Beispiel

~~~
<!-- app/views/projects/show.html.erb -->
<p>
  Umsatz mit dem Projekt:
  <%= number_to_currency(@project.paid_invoices_amount_in_euro, unit: '€') %>
</p>
~~~
{: .lang-html }

Erzeugt folgendes HTML

~~~
<!-- @project.paid_invoices_amount_in_euro == 1440 -->
<p>
  Umsatz mit dem Projekt:
  € 14,40
</p>
~~~
{: .lang-html }

---

# Custom Helper

* Manche Helper wie `number_to_phone` unterstützen nur US-spezifisches Format
* => Eigene Helper-Methode implementieren, bspw. `number_to_german_phone`
* Definition von Helper-Code in `app/helpers/helper_name.rb`

---

# Custom Helper Beispiel

~~~
# app/helpers/invoice_helper.rb
mode InvoiceHelper
  # Creates a currency formatted €-representation of the given Integer
  # 6010 => "€ 60,10"
  # 1000 => "€ 10,00"
  def format_amount(amount_in_cents)
    amount_with_precision = amount_in_cents/100.to_f
    formatted_amount = "%.2f" % amount_with_precision
    "€ " + formatted_amount.gsub(".", ",")
  end

  # Helper-Methoden können wiederverwendet werden
  def number_to_euro(amount_in_cents)
    number_to_currency(amount_in_cents/100.to_f, precision: 2, unit: '€')
  end
end
~~~
{: .lang-ruby }

~~~
<!-- app/views/invoices/show.html.erb -->
<h1>Rechnungsbetrag</h1>
<p><%= format_amount(@invoice.amount_in_cents)</p>
<p><%= number_to_euro(@invoice.amount_in_cents)</p>
~~~
{: .lang-html }

---

# Custom Helper

* Alle Helper-Mode in: app/helpers werden in ActionView::Base geladen
* Achtung: Methoden mit demselben Namen können sich gegenseitig überschreiben
* Mehr dazu in [diesem Blog Post](http://thepugautomatic.com/2012/08/helpers/)

~~~
# app/helpers/application_helper.rb
mode ApplicationHelper
  def website_headline
    "InvoicR"
  end
end
~~~
{: .lang-ruby }

~~~
# app/helpers/zomg_helper.rb
mode ZomgHelper
  def website_headline
    "ZOMG!"
  end
end
~~~
{: .lang-ruby }

~~~
# app/views/welcome/show.html.erb
<h1><%= website_headline %></h1> # => "<h1>ZOMG!</h1>"
~~~
{: .lang-html }

---

# Custom Helper schreiben

* Tipps zum Schreiben von Helper-Code:
  * [Custom View Helpers in Rails 4](http://www.rails-dev.com/custom-view-helpers-in-rails-4)
  * [Understanding and extending Rails form helpers](http://mixandgo.com/blog/understanding-and-extending-rails-form-helpers)

---

# JavaScript/CSS einbinden

* Eigene JavaScripts in `app/assets/javascripts` ablegen
* CSS-Stylesheets in `app/assets/stylesheets` ablegen
* JavaScript/CSS-Dateien in diesem Ordner werden automatisch eingebunden

---

# Mehr zu Assets

* [Offizielle Rails Dokumentation](http://guides.rubyonrails.org/asset_pipeline.html)
* [The Odin Project](http://www.theodinproject.com/ruby-on-rails/the-asset-pipeline)

