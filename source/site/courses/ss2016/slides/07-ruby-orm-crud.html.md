# Ruby ORM: CRUD

---

# Agenda

* Data-driven web applications
* RDBMS vs. NoSQL
* CRUD
* OOP und RDBMS
* RDBMS Zugriff
* ORM: Design Pattern
* DataMapper Beispiel-Code für CRUD

---

# Data-driven web applications

![Ruby App und Datenbank](slides/database/ruby-database-sketch.png)

---

# Data-driven web applications

* Web-Applikationen bieten Nutzern Lese-/Schreibzugriff
  * Kurzlebig: Login, Warenkorb
  * Langlebig: Nutzerkonto, Bestellungen
* Langlebige Daten meist in (RD)BMS
  * RDBMS: Relationale Datenbank
* RDBMS <-> NoSQL

[Sitepoint: SQL vs. NoSQL](http://www.sitepoint.com/sql-vs-nosql-differences/)

---

# RDBMS vs. NoSQL

* RDBMS: Relationale Datenbanksysteme
  * Daten in Tabellen organisiert
  * Datenrelationen über Fremdschlüssel
  * Daten werden häufig Normalisiert (1NF, 2NF, …)
  * Transaktionssicherheit
  * …
* NoSQL: Nicht-relationale Systeme
  * Bspw. Dokumentenbasiert wie MongoDB
  * Oder Key-Value Speicher wie Redis
* Fokus: RDBMS

*[SQL]: Structured Query Language
*[RDBMS]: Relational Database Management Systems

---

# CRUD

* Akronym/Systematik für Basis-Funktionen von Datenoperationen
  * [C]reate: Erzeugt Ressource(n)
  * [R]read: Liest Ressource(n)
  * [U]pdate: Ändert Ressource(n)
  * [D]elete: Löscht Ressource(n)

[Wikipedia: CRUD](https://en.wikipedia.org/wiki/Create,_read,_update_and_delete)

---

# CRUD: Web

* Web-Applikationen mit CRUD nutzen oft Semantik von HTTP-Methoden
* URL-Schema für CRUD-Operationen (RESTful)

| Operation | SQL | HTTP Method | URL |
|-------------------------------------|
| Create | INSERT | POST | /users |
|----------------------------------|
| Read | SELECT | GET | /users/1 |
|-------------------------------|
| Update | UPDATE | PUT/PATCH | /users/1 |
|-------------------------------|
| Delete | DELETE | DELETE | /users/1 |
|-------------------------------|

[Wikipedia: Representational State Transfer](https://en.wikipedia.org/wiki/Representational_state_transfer)

---

# CRUD Create: Web Beispiel

* `POST http://example.com/users`
  * Erzeugt neue User-Ressource
  * Daten werden im Request-Body mitgesendet

---

# CRUD Read: Web Beispiel

* `GET http://example.com/users.html`
  * Liest alle User-Ressourcen

* `GET http://example.com/users/1.html`
  * Liest die User-Ressource mit der ID 1

---

# CRUD Update: Web Beispiel

* `PUT http://example.com/users/6.html`
  * Überschreibt die User-Ressource mit der ID 6

---

# CRUD Delete: Web Beispiel

* `DELETE http://example.com/users/5.html`
  * Löscht die User-Ressource mit der ID 5

---

# Non-CRUD Operationen

* CRUD deckt nur Basis-Operationen ab
* Komplexe oder individuelle Operationen müssen individuell gelöst werden, bspw:
  * Merge von Ressourcen
  * Toggle eines binären Zustands

* Beispiel Merge von Ressourcen
  * `PUT http://example.com/user-merge/4/17`
  * Kopiert alle Daten vom Nutzer mit der ID 4 zum Nutzer mit Id 17

Weiter: SQL-Zugriff für CRUD

---

# CRUD -> SQL

* Um CRUD-Operationen umzusetzen wird DB-Zugriff benötigt
* Zwei unterschiedliche Ansätze für Datenzugriff
  * Nativer SQL-Zugriff
    * SQL-Strings werden mit der DB ausgetauscht
    * Typ-Konvertierung (bspw. String -> Int) manuell
  * ORM-Zugriff
* ORM-Zugrff für Beginn
* OOP <-> RDBMS Differenzen

---

# OOP und RDBMS

* Herausforderungen
  * Konvertierung von Datenstrukturen
    * RDBMS kennen Tabellen, kein Hash, Struct,…
  * Typisierung von Daten
  * Identität von Daten
    * Laufzeit: Objekt über Speicheradresse o.ä. adressierbar
    * Persistenz: Identifizierung über Primärschlüssel
  * …

[Object-relational Impedance Mismatch](https://de.wikipedia.org/wiki/Object-relational_impedance_mismatch)

---

# RDBMS Zugriff

## Native SQL

~~~
# Nativer SQL-Zugriff: Pseudocode
db = SQLite3::Database.new("db/sqlite.db")
orders = db.execute("SELECT * FROM orders WHERE id = '1'")
=> [{ 'id' => '1', 'created_at' => '2015-01-05 14:55:05 UTC', … }]
orders[0]['created_at'].class
=> String              # <- String-Objekt
~~~
{: .lang-ruby }

## ORM

~~~
# ORM-Zugriff: Pseudocode
orders = Order.where(id: 1) # Ruby statt SQL-Code
orders[0].created_at.class
=> Time                # <- Time-Objekt, Typ-Konvertierung durch ORM
~~~
{: .lang-ruby }

---

# ORM: Design Pattern

* Abstraktion für OOP-Style Datenzugriff
* ORM: Design Pattern = Object-relational Mapper
  * Erzeugt/Löscht/Modifiziert Daten in Tabellen
* Generiert SQL aus (Ruby-)Code
* Typ-Konvertierung: Konvertiert Daten in Ruby-Objekte
  * Nicht alle Daten sind Strings
  * Mapping zwischen DB-Typ und Ruby-Objekt
* Verwaltete Assoziationen zu Objekten
* …

---

# ORM: Design Pattern

* Zwei alternative Design Patterns
  * [Data Mapper Pattern](http://www.martinfowler.com/eaaCatalog/activeRecord.html)
  * [Active Record Pattern](http://www.martinfowler.com/eaaCatalog/activeRecord.html)
* Fokus: Active Record Pattern
  * Anfängerfreundliches Design Pattern
  * Persistenz und Verhalten in einem Objekt
* Disclaimer: ORMs haben Probleme
  * [Martin Fowler: ORM Hate](http://martinfowler.com/bliki/OrmHate.html)
  * [Jeff Atwood: ORM is the Vietnam of Computing](http://blog.codinghorror.com/object-relational-mapping-is-the-vietnam-of-computer-science/)
  * [Yegor Bugayenko: ORM Is an Offensive Anti-Pattern](http://www.yegor256.com/2014/12/01/orm-offensive-anti-pattern.html)
* Blick auf Active Record Design Pattern

---

# DataMapper: Active Record Pattern

* Eine Zeile pro SQL-Tabelle ist ein Ruby-Objekt (genauer: Record)
* DB-Funktionalität, Daten und sonstige Methoden im Record enkapsuliert
* *[DataMapper](http://datamapper.org/)*: Ruby Implementierung des Active Record Pattern
  * bietet verschiedene Adapater (MySQL, PostgreSQL, …)
  * Entwicklung eingestellt
  * Nachfolger: [Ruby Object Mapper](http://rom-rb.org/), Data Mapper Pattern

---

# DataMapper Beispiel

~~~
# DataMapper Pseudocode
peter = User.new(firstname: 'Peter', lastname: 'Pan')
peter.id         # `.id` ist der Primärschlüssel in der DB-Tabelle
=> nil           # Da dieses Objekt noch nicht gespeichert ist: nil
peter.save       # `.save` erzeugt im Hintergrund das notwendige SQL:
peter.id         # `INSERT INTO users (firstname, lastname) VALUES ('Peter', 'Pan')`
=> 14            # Nach dem `INSERT` setzt die ORM auch die `id` des Records
~~~
{: .lang-ruby }

[DataMapper: Getting started](http://datamapper.org/getting-started.html)

---

# DataMapper: Konzepte

* Models: Mapping-Definition von Tabellenspalten zu Ruby-Objekt
* Associations: Definiton von Objekt-Relationen
* Migrations: Beschreiben Tabellen/Daten-Modifikationen über Zeit
* Wir benötigen vorerst nur Models
* Zunächst Konfiguration f. DB-Zugriff

---

# DataMapper: Konfiguration

~~~
# orm.rb
require 'data_mapper' # Lädt DataMapper ORM Code

DataMapper.setup(:default, 'sqlite::memory:')
# An in-memory Sqlite3 connection
~~~
{: .lang-ruby }

---

# DataMapper: Models

~~~
# blog_post.rb
require 'orm' # Lädt die DataMapper-Konfiguration

class BlogPost # Plural des Klassennamens ist Tabellen-Name
  include DataMapper::Resource    # Lädt ORM-Code

  property :id,         Serial    # An auto-increment integer key
  property :title,      String    # A varchar type string, for short strings
  property :body,       Text      # A text block, for longer string data.
end

DataMapper.auto_migrate! # Erzeugt automatisch die SQL-Tabellen
~~~
{: .lang-ruby }

* Erzeugte SQL-Tabellen

---

# DataMapper: SQL-Tabellen

* `DataMapper.auto_migrate!` erzeugt SQL-Tabelle für `BlogPost`-Records
* Je nach RDBMS wird der passende Spaltentyp konfiguriert
* Beispiel-Tabelle:

|-------------------|
| id | title | body |
|-------------------|
| Typ: Integer | Typ: String | Typ: Text |
|-------------------|

* Weiter: CRUD-Operationen mit DataMapper-Model

---

# DataMapper: Create

~~~
# create.rb
require 'blog_post' # Lädt die DataMapper Model-Definition

new_post = BlogPost.create(title: 'Hello World', body: 'yadda yadda')
# DataMapper erzeugt BlogPost via SQL-INSERT

new_post.id # => Gibt id zurück
=> 1
~~~
{: .lang-ruby }

---

# DataMapper: Read

~~~
# read.rb
require 'blog_post' # Lädt die DataMapper Model-Definition

post = BlogPost.get(1) # Liest BlogPost mit der ID 1
# DataMapper erzeugt SQL-SELECT, lädt Datenbank-Eintrag
# und erzeugt `post`-Objekt mit Datenkbank-Werten

post.id
=> 1
~~~
{: .lang-ruby }

---

# DataMapper: Update

~~~
# update.rb
require 'blog_post' # Lädt die DataMapper Model-Definition

post = BlogPost.get(1) # Liest BlogPost mit der ID 1
post.title # Gibt `title` zurück
=> "Hello World"

post.update(title: 'Bye bye World')
# Überschreibt `title`-Wert für Datenbank-Eintrag mit der ID

post.title # Liest title
=> "Bye bye World"
~~~
{: .lang-ruby }

---

# DataMapper: Delete

~~~
# delete.rb
require 'blog_post' # Lädt die DataMapper Model-Definition

post = BlogPost.get(1) # Liest BlogPost mit der ID 1

post.destroy
# DataMapper erzeugt SQL-DELETE und löscht Datenbank-Eintrag mit der ID

post.id
=> nil # ID exitiert nicht mehr
~~~
{: .lang-ruby }

---

# ORM Vertiefen

* Mehr zu ORMs in der Rails ActiveRecord LF / Übung
* Alternative zu ORM: Object Mapper / Data Mapper Pattern
  * [Ruby Object Mapper](http://rom-rb.org/): Komplexere/Flexiblere Konzepte zur Problemlösung
* Artikel zu ORM-Problemen
  * [Martin Fowler: ORM Hate](http://martinfowler.com/bliki/OrmHate.html)
  * [Jeff Atwood: ORM is the Vietnam of Computing](http://blog.codinghorror.com/object-relational-mapping-is-the-vietnam-of-computer-science/)
  * [Yegor Bugayenko: ORM Is an Offensive Anti-Pattern](http://www.yegor256.com/2014/12/01/orm-offensive-anti-pattern.html)

---

# Links und Resourcen

* http://datamapper.org/getting-started.html
* https://github.com/tomaszj/sinatra-datamapper-sample
* http://code.tutsplus.com/tutorials/ruby-for-newbies-working-with-datamapper--net-19622
* http://recipes.sinatrarb.com/p/models/data_mapper
