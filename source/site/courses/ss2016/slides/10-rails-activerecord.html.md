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
* Assoziationen
* Validierungen
* Live Coding

---

# Rails Models

![MVC-Model in Rails](slides/rails-getting-started/rails-mvc-model.png)

---

# Aufgaben von Models

* CRUD-Operationen zum Lesen/Schreiben in DB
* Assoziationen: Modellieren von Relationen
* Validierungen: Sicherung von Datenqualität
* Callbacks: Lifecycle-Management von Daten
  * Mehr Infos hier
  * [The Problem with Rails Callbacks](http://samuelmullen.com/2013/05/the-problem-with-rails-callbacks/)
  * [Offizielle Rails Docs zu Callbacks](http://guides.rubyonrails.org/active_record_callbacks.html)

Zunächst: Konventionen

---

# ActiveRecord Konventionen

* Model-Dateien liegen im `app/models`-Ordner
* Ein Model ist eine Ruby-Klasse die von `ActiveRecord::Base` erbt
* Name der Ruby-Klasse singular, DB-Tabelle plural
  * `Product` => products
  * `User` => users
  * `Person` => people (Rails verwaltet *Pluralisierung*, siehe [Rails Inflections](https://github.com/rails/rails/blob/master/activesupport/lib/active_support/inflections.rb))
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

* SQL-Tabellen manuell verwalten oder skripten
* Manuelle Verwaltung ist fehleranfällig, daher `Migrationen`
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
  def change
    create_table :products do |t|
      t.string   :name, limit: 255
      t.integer  :price_in_cents, default: 0
      t.text     :description

      t.datetime :created_at # <- Spalte wird von Rails verwaltet
      t.datetime :updated_at # <- Spalte wird von Rails verwaltet
    end
  end
end
~~~
{: .lang-ruby }

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
| created_at | Datetime | Rails-Feld: Erstellt am |
| updated_at | Datetime | Rails-Feld: Zuletzt bearbeitet am |
|--------------------------------------------------|

---

# Migrationen

* Anwendungsmöglichkeiten
  * Erstellen/Löschen von SQL-Tabellen
  * Hinzufügen/Ändern/Umbenennen von Spalten
  * Verwalten von SQL-Indizes
  * Referenzielle Integritätsprüfung (Foreign Keys)
* Mehr zu Migrationen
  * [Understanding Ruby on Rails Migrations](http://culttt.com/2015/10/07/understanding-ruby-on-rails-migrations/)
  * [Data Migrations in Rails](https://robots.thoughtbot.com/data-migrations-in-rails)
  * [Offizielle Rails-Docs zu Migrationen](http://edgeguides.rubyonrails.org/active_record_migrations.html)
* Weiter: CRUD Operationen

---

# CRUD-Operationen

* OOP-Methoden (API) für Lese-/Schreibzugriff auf DB
* `rails console` zum testen nutzen

~~~
class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :id, null: false
      t.string :name
      t.string :email
    end
  end
end
~~~
{: .lang-ruby }

`users`-Tabelle

| id | name | email |
|-------------------|
| 1 | Harald | harald@web.de |

~~~
class User < ActiveRecord::Base
end
~~~
{: .lang-ruby }

---

# Create

~~~
# harald ist erst mal eine neue User-Instanz
harald = User.new
harald.name = 'Harald' # mit Zugriff auf Spaltennamen wird Wert gesetzt
harald.email = 'harald@web.de'
harald.id
=> nil       # Noch hat Harald keine id, da er nicht gespeichert wurde
harald.save  # Führt SQL-INSERT aus…
harald.id
=> 1

# Erstellen mit Hash-Syntax via `create`
peter = User.create(name: 'Peter', email: 'peter@web.de')
# Führt SQL-INSERT aus…
peter.id
=> 2

~~~
{: .lang-ruby }

Als nächstes: Daten wieder auslesen

---

# Read

~~~
harald = User.first    # Lädt User-record mit der niedrigsten ID
=> #<User: name: 'Harald' …>
peter  = User.last     # Lädt User-record mit der höchsten ID
=> #<User: name: 'Peter' …>

harald = User.find(1)  # Lädt User-record mit id 1
=> #<User: name: 'Harald' …>
peter  = User.where(name: 'Peter') # Lädt alle Records mit name = 'Peter'
=> [#<User: name: 'Peter' …>]     # Daher Rückgabewert Array von User-records

users = User.all       # Lädt alle User-records
=> [#<User: name: 'Harald' …>, #<User: name: 'Peter' …>]

~~~
{: .lang-ruby }

Aggregierungs-Methoden:

~~~
# Führt Berechnungen auf allen records aus wie `.count`, `.sum`, `.minimum`, …
User.count # Zählt die Anzahl der user in der DB
=> 2
~~~
{: .lang-ruby }

* `User.where` erlaubt auch komplexe Bedingungen. Mehr dazu:
  * [Offizielle Rails Docs zu Active Record Query Interface](http://guides.rubyonrails.org/active_record_querying.html)
  * [The Odin Project: Active Record Queries](http://www.theodinproject.com/ruby-on-rails/active-record-queries)

---

# Update

~~~
harald = User.first
=> #<User: name: 'Harald' …>

harald.email
=> 'harald@web.de'

harald.email = 'harald@gmx.de'
harald.save # Führt SQL-UPDATE aus

peter = User.last
=> #<User: name: 'Peter' …>

peter.update email: 'peter@gmx.de' # Führt SQL-UPDATE aus

User.update_all(name: 'Kevin')     # Jetzt heißen alle Kevin
~~~
{: .lang-ruby }

---

# Delete

~~~
harald = User.first
=> #<User: name: 'Harald' …>
harald.destroy

User.destroy_all  # Löscht alle Einträge in der `users`-Tabelle
~~~
{: .lang-ruby }

* Mehr zu CRUD-Operationen:
  * [Coursera Video: ActiveRecord and CRUD](https://www.coursera.org/learn/rails-with-active-record/lecture/RHWbJ/active-record-crud-part-1)
  * [Offizielle Rails Docs zu CRUD](http://guides.rubyonrails.org/active_record_basics.html#crud-reading-and-writing-data)
* Weiter: Assoziationen

---

# Assoziationen/Relationen

* Objekte haben Beziehungen (Kunde <-> Bestellungen)
* Auf SQL-Ebene mit Fremdschlüsseln (FK: Foreign Key) realisiert
* ActiveRecord-Assoziationen modelliert folgende Beziehungen
  * 1 <-> 1 (belongs_to, has_one)
  * 1 <-> n (has_many)
  * n <-> n (has_and_belongs_to_many)
* Assoziationen bieten Lese/Schreibzugriff auf Relationen
* Ein Beispiel für 1 <-> 1

---

# Assoziation: has_one (1 <- 1)

![Has one and belongs to](slides/rails-models/associations-has-one-belongs-to.png)

~~~
class Supplier < ActiveRecord::Base
  has_one :account # Definiert `account`-Methode auf Supplier-Objekten
                   # FK auf `accounts`-Tabelle.
end
~~~
{: .lang-ruby }


Lesezugriff

~~~
supplier = Supplier.find(1)  # SELECT * FROM suppliers WHERE id = 1;
supplier.account             # SELECT * FROM accounts WHERE supplier_id = 1;
=> #<Account: id: 3 …>       # wählt richtigen Account über FK aus
~~~
{: .lang-ruby }

---

# Assoziation: has_one (1 <- 1)

![Has one and belongs to](slides/rails-models/associations-has-one-belongs-to.png)

Schreibzugriff

~~~
supplier = Supplier.find(4)  # SELECT * FROM suppliers WHERE id = 4;
supplier.account             # Supplier hat noch keinen Account
=> nil
supplier.account = Account.create(account_number: '123')
# INSERT INTO "accounts" ("account_number", "created_at", "updated_at") VALUES ("123", …)
# UPDATE "accounts" SET "supplier_id" = 4, … WHERE "accounts"."id" = 1
supplier.account             # Gibt nun den assoziierten Account zurück
=> #<Account: account_number: '123'…>
~~~
{: .lang-ruby }

---

# Assoziation: belongs_to (1 -> 1)

![Has one and belongs to](slides/rails-models/associations-has-one-belongs-to.png)

~~~
class Account < ActiveRecord::Base
  belongs_to :supplier # Definiert `supplier`-Methode auf Account- Objekten
                       # FK auf `accounts`-Tabelle.
end
~~~
{: .lang-ruby }

Lese-/Schreibzugriff

~~~
account = Account.find(4)  # SELECT * FROM accounts WHERE id = 4;
account.supplier           # SELECT * FROM suppliers WHERE supplier_id = 2;
=> #<Supplier: id: 2 …>    # wählt richtigen Supplier über FK aus

account = Account.find(5)
account.supplier = Supplier.create(name: 'ACME Inc.')
~~~
{: .lang-ruby }

---

# Assoziation: Has many (1 <- n)

![Has Many](slides/rails-models/associations-has-many.png)

~~~
class Customer < ActiveRecord::Base
  has_many :orders # Definiert `orders`-Methode auf customer-Objekten
                   # FK auf `orders`-Tabelle.
end
~~~
{: .lang-ruby }

Lesezugriff

~~~
customer = Customer.find(4) # SELECT * FROM customers WHERE id = 4;
customer.orders             # SELECT * FROM orders WHERE customer_id = 4;
=> [<Order>, <Order>, …]
~~~
{: .lang-ruby }

---

# Assoziation: Has many (1 <- n)

![Has Many](slides/rails-models/associations-has-many.png)

~~~
class Customer < ActiveRecord::Base
  has_many :orders # Definiert `orders`-Methode auf customer-Objekten
                   # FK auf `orders`-Tabelle.
end
~~~
{: .lang-ruby }

Schreibzugriff

~~~
# Neues Objekt wird entweder via `.create` auf Assoziation erzeugt
customer.orders.create(description: 'Neue Bestellung')

# Oder Objekt wird erzeugt und via `push` oder `<<` der Assoziation hinzugefügt
new_order = Order.create(description: 'Neue Bestellung')
customer.orders.push(new_orders)
customer.orders << new_orders
~~~
{: .lang-ruby }

---

# n <-> n
Has and belongs to many

![Has Many](slides/rails-models/associations-has-and-belongs-to-many.png)

* Nutzt eine join-Table die Fremdschlüssel verwaltet

---

# n <-> n
Aus Sicht der Playlist

~~~
class Playlist < ActiveRecord::Base
  has_and_belongs_to_many :listeners
  # Definiert `listeners`-Methode auf Playlist-Objekten.
  # Name der Join-Table ergibt sich implizit aus den Klassen-Namen
  # in alphabetischer Reihenfolge => `listeners_playlists` oder
  # kann auch explizit angegeben werden, bspw:
  # has_and_belongs_to_many :listeners, join_table: 'some_other_table_name'
end
~~~
{: .lang-ruby }

~~~
playlist = Playlist.find(1) # SELECT * FROM playlists WHERE id = 1;
playlist.listeners
# SELECT "listeners".* FROM "listeners" INNER JOIN "listeners_playlists"
#   ON "listeners"."id" = "listeners_playlists"."listener_id"
#   WHERE "listeners_playlists"."playlist_id" = 1
=> [#<Listener: …>, #<Listener: …>, …]
~~~
{: .lang-ruby }


---

# n <-> n
Aus Sicht eines Zuhörers (Listeners)

~~~
class Listener < ActiveRecord::Base
  has_and_belongs_to_many :playlists
  # Definiert `playlists`-Methode auf Listener-Objekten.
end
~~~
{: .lang-ruby }

~~~
listener = Listener.find(1) # SELECT * FROM listeners WHERE id = 1;
listener.playlists
# SELECT "playlists".* FROM "playlists" INNER JOIN "listeners_playlists"
#   ON "playlists"."id" = "listeners_playlists"."playlist_id"
#   WHERE "listeners_playlists"."listener_id" = 1
=> [#<Playlist: …>, #<Playlist: …>, …]
~~~
{: .lang-ruby }

---

# n <-> n

* Schreibzugriff identisch zu `has_many`-Assoziationen
* Mehr zu Assoziationen:
  * [The Odin Project: Rails Associations](http://www.theodinproject.com/ruby-on-rails/active-record-associations)
  * [Offizielle Rails Docs zu Assoziationen](http://guides.rubyonrails.org/association_basics.html)
* Weiter: Validierungen

---

# Validierungen

* Integrität von Daten sicherstellen
* Problem: Integritätsprüfung an verschiedenen Stellen (Front End, DB)
* Rails-Weg: Validierung via Ruby-Code im Back end
  * Datenbank-Agnostisch
  * Leicht zu testen
  * Generieren automatische Fehlernachrichten

---

# Validierungen

* Ausführung vor Speichern: `.save`, `.update`, `.create`
* Gängige Validierungen
  * Sind alle Pflichtangaben erfüllt?
  * Gültige E-Mail Adresse angegeben?
  * Password-Eingabe komplex genug?
  * Besteht eingegebene PLZ aus genau fünf Zahlen?
  * …

---

# Validierungen Beispiel

~~~
class Person < ActiveRecord::Base
  validates :name, presence: true
end

Person.new(name: "John Doe").valid? # => true
Person.new(name: nil).valid?        # => false
~~~
{: .lang-ruby }

---

# Arten von Validierungen

* `numericality`: Wert muss {numerisch, größer null, gerade, ungerade} sein
* `uniqueness`: Wert soll in der DB-Tabelle einmalig vorkommen (via SQL-Check, Racy)
* `presence`: Wert darf nicht leer sein
* `format`: Wert muss RegExp matchen
* `acceptance`: Prüft ob bspw. Checkbox angehakt wurde
* …

---

#  PLZ-Validierung

~~~
class Address < ActiveRecord::Base
  validates :plz, numericality: true, length: { is: 5 }
end

address1 = Address.new(plz: 123)
address1.valid?      # => false
address2 = Address.new(plz: 'abc')
address2.valid?      # => false
address3 = Address.new(plz: 12345)
address3.valid?      # => true
~~~
{: .lang-ruby }

---

# Validierungen: Fehler

* Validierungen erzeugen Fehler-Nachrichten auf dem Objekt
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

# Validierungen: Fehleranzeige

~~~
<ul>
<% @product.errors.full_messages.each do |msg| %>
  <li><%= msg %></li>
<% end %>
</ul>
~~~
{: .lang-html }

* Mehr zu Validierungen:
  * [Rails Validations for Beginners](http://buildingrails.com/a/rails_validations_for_beginners)
  * [Offizielle Rails Docs zu Validierungen](http://guides.rubyonrails.org/active_record_validations.html)
* Weiter Live Coding

---

# Live Coding

~~~
cd /tmp
rails new live-code-project; cd live-code-project
rails generate model User name:string email:string
rake db:migrate
rails console
~~~
{: .lang-bash }

---

# Danke

---
