<!--
Agenda:
- Rails ORM ActiveRecord
  - Aufgaben von Models
    - CRUD-Operationen: Lesen/Schreiben von Ruby-Objekten in die Datenbank
    - Modellierung von Assoziationen
    - Validierungen
    - Callbacks
  - Unterschied DataMapper
      - Wir müssen Tabellen anlegen
      - Dafür definieren wir keine Attribute
  - Zum Anlegen nutzen wir Migrationen
  - Migrationen sind entweder Ruby-Syntax oder SQL
    - Beispiel-Migrationen für Kontakt-Anfragen / ContactRequests
  - Basis-Funktionen von ActiveRecord
    - .new erzeugt eine Instanz im Speicher
    - .create erzeugt DB-Eintrag
    - mit .update wird Eintrag modifiziert
    - mit .destroy wird Eintrag zerstört
      - Außerdem werden Callbacks aufgerufen
    - mit .delete wird Eintrag zerstört
  - Callbacks
  - Validierungen
  - Rails console

-->

# ActiveRecord

---

# Agenda

* Aufgaben von Models
* ActiveRecord Konventionen
* Migrationen
* CRUD mit ActiveRecord
* Validierungen
* Callbacks
* Live Coding

---

# Rails Models

![MVC-Model in Rails](slides/rails-getting-started/rails-mvc-model.png)

---

# Aufgaben von Models

* Persistenz-Zugriff: ORM
  * CRUD-Operationen zum Lesen/Schreiben in DB
  * Relationen modellieren
* Validierungen: Datenqualität sichern
* Callbacks: Lifecycle-Management von Daten

Zunächst: Konventionen

---

# ActiveRecord Konventionen

* Model-Dateien liegen im `app/models`-Ordner
* Ein Model ist eine Ruby-Klasse die von `ActiveRecord::Base` erbt
* Name der Ruby-Klasse singular, DB-Tabelle plural
  * `Product` => products
  * `User` => users
  * `Person` => people (Rails verwaltet *pluralisierung*)
* Tabellenspalte `id` wird als Primärschlüssel genutzt

---

# ActiveRecord Beispiel

DB-Tabelle `products`:

| id | name | price_in_cents | description | … |
|----------------------------------------------|
| 16 | Haartrockner | 5999 | Ein formschöner … | … |

~~~
# app/models/product.rb
class Product < ActiveRecord::Base
end
~~~
{: .lang-ruby }

~~~
# rails console
product = Product.find(16) # Lädt record mit id 16
product.name
=> "Haartrockner"
~~~
{: .lang-ruby }

---

# Migrationen

* Model-Attribute leiten sich von existierenden DB Tabellen ab
* Erzeugung/Verwaltung von DB Tabellen mit `Migrationen`
* `Migration`:
  * Ruby-Skript in Projekt-Ordner unter: `db/migrate`
  * Wird mit `rails generate migration NameDerMigration` erzeugt
  * `rails generate migration` nimmt *magische Argumente* entgegen

---

# Beispiel Migration

Anlegen der `products`-Tabelle

~~~
# Erzeugt neues Migrations-Skript im `db/migrate`-Ordner:
rails generate migration CreateProducts name:string price_in_cents:integer description:text
~~~
{: .lang-ruby }

Rails erkennt, dass eine SQL-Tabelle mit den Spalten `name`, `price_in_cents` und `description` erstellt werden soll:

~~~
# db/migrate/20160605195144_create_products.rb
class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price_in_cents
      t.text :description
    end
  end
end


~~~
{: .lang-ruby }

---

# Beispiel Migration #2

* Migration manuell erweitern

~~~
# db/migrate/20160605195144_create_products.rb
class CreateProducts < ActiveRecord::Migration
  def up
    create_table :products do |t|
      t.string   :name, limit: 255
      t.integer  :price_in_cents, default: 0
      t.text     :description

      t.datetime :created_at
      t.datetime :updated_at
    end
  end

  def down
    drop_table :products
  end
end
~~~
{: .lang-ruby }

---

# Migration Spaltentypen

* Integer
* String
* Text
* Datetime
* Decimal


---

# Beispiel Migration #3

* `rake db:migrate`: Führt Migration aus

DB-Tabelle `products`:

| Name | Datentyp | Kommentar |
|-------------------------------------|
| id   | Integer | Wird automatisch erzeugt. 4 Bytes Integer |
| name | Varchar | Bis 255 UTF8 Zeichen |
| price_in_cents | Integer | 4 Bytes Int. Max: 2147483647  |
| description | Text | Bis zu 65535 UTF8 Zeichen |
| created_at | Datetime | Wird von Rails verwaltet |
| updated_at | Datetime | Wird von Rails verwaltet |
|------------------------|

---

# Migrationen

* Anwendungsmöglichkeiten
  * Erstellen/Löschen von SQL-Tabellen
  * Hinzufügen/Ändern/Umbenennen von Spalten
  * Verwalten von SQL-Indizes
  * Referenzielle Integritätsprüfung (Foreign Keys)

---

# Migrationen

* Jede Migration hat Zeitstempel (Unix Timestamp) im Namen
  * Anwendungsfall: Verteilte Entwicklung
  * Definierte Reihenfolge

---

# AR Assoziationen

* DSL zur Beschreibung von Objekt/Daten-Relationen
* Persistierung von Objekt-Graphen
* OOP-Zugriff auf Relationen
  * One to One (Belong To, Has One)
  * One to Many (Has Many)
  * Many to Many (Has and belong to many)

---

# AR Assoziationen: Belongs to

![Belongs to](slides/rails-models/associations-belongs-to.png)

~~~
order = Order.find(3)  # SELECT * FROM orders WHERE id = 3;
order.customer.name    # SELECT * FROM customers WHERE id = 17;
=> "Jolly Inc."
~~~
{: .lang-ruby }

---

# AR Assoziationen: Has one
![Has one](slides/rails-models/associations-has-one.png)

~~~
supplier = Supplier.find(1)     # SELECT * FROM suppliers WHERE id = 1;
supplier.account.account_number # SELECT * FROM accounts WHERE supplier_id = 1;
=> "128-171"
~~~
{: .lang-ruby }

---

# AR Assoziationen: Has many

![Has Many](slides/rails-models/associations-has-many.png)

~~~
customer = Customer.find(4) # SELECT * FROM customers WHERE id = 4;
customer.orders             # SELECT * FROM orders WHERE customer_id = 4;
=> [<Order>, <Order>, …]
~~~
{: .lang-ruby }

---

# AR Assoziationen erzeugen

~~~
customer = Customer.find(4) # SELECT * FROM customers WHERE id = 4;
customer.orders.create(order_date: Date.current)
# Erzeugt einen Eintrag in der Orders-Tabelle mit customer_id = 4
# INSERT INTO customers (…, customers_id) VALUES (…, 4)
~~~
{: .lang-ruby }

---

# AR Validierungen

* Ziel: Integrität von Daten sicherstellen
* Problem: Integritätsprüfung an verschiedenen Stellen (Front End, DB)
* Validierungen im Code
  * Datenbank-Agnostisch
  * Sind leicht zu testen
  * Generieren Nutzer-Feedback bei Fehlern

---

# AR Validierungen

* Validierung passiert vor Persistenz: save, update, create
* Validierungen können umgangen werden (Vorsicht)
* Manuelle Validierung mit valid?

---

# AR Validierungen Beispiel

~~~
class Person < ActiveRecord::Base
  validates :name, presence: true
end

Person.new(name: "John Doe").valid? # => true
Person.new(name: nil).valid? # => false
~~~
{: .lang-ruby }

---

# AR Validierungstypen

* numericality: Wert muss (numerisch|größer null|gerade|ungerade) sein
* uniqueness: Wert soll in der DB-Tabelle einmalig vorkommen (via SQL-Check, Racy)
* presence: Wert darf nicht leer sein
* format: Wert muss RegExp matchen
* acceptance: Prüft ob bspw. Checkbox angehakt wurde
* …

---

# AR Validierungen: Format

~~~
class Product < ActiveRecord::Base
  validates :legacy_code, format: { with: /\A[a-zA-Z]+\z/,
    message: "only allows letters" }
end
Product.new(legacy_code: '123').valid? # => false
Product.new(legacy_code: 'abc').valid? # => true
~~~
{: .lang-ruby }

---

# Validierungen: Fehler

* Validierungen erzeugen Fehler-Nachrichten auf den AR-Objekten
* Diese können im Front End (View) angezeigt werden
* Fehler-Nachrichten sind mit I18n übersetzbar

~~~
class Product < ActiveRecord::Base
  validates :title, presence: true
end
product = Product.new(title: nil).valid? # => false
product.errors.full_messages # => ['Title can't be blank']
~~~
{: .lang-ruby }

---

# AR Validierungen: Anzeige im Front End

~~~
<% if @product.errors.any? %>
  <ul>
  <% @product.errors.full_messages.each do |msg| %>
    <li><%= msg %></li>
  <% end %>
  </ul>
<% end %>
~~~
{: .lang-html }

---

# AR Validierungen: Anzeige im Front End

~~~
# app/views/product.html.erb
<% if @product.errors.any? %>
  <ul>
  <% @product.errors.full_messages.each do |msg| %>
    <li><%= msg %></li>
  <% end %>
  </ul>
<% end %>
~~~
{: .lang-html }

---

# Models

~~~
# app/models/project.rb
class Project < ActiveRecord::Base
  validate :title, presence: true
  has_many :efforts
end

class Effort < ActiveRecord::Base
  belongs_to :project
end

class Invoice < ActiveRecord::Base
  belongs_to :project
end
~~~
{: .lang-ruby }

