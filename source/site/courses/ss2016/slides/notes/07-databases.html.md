# Ruby -> RDBMS

---

# Agenda

* Data driven web applications
* RDBMS vs. NoSQL
* OOP und RDBMS
* RDBMS Zugriff
* ORM: Design Pattern
* ActiveRecord Beispiel-Code
* Ruby ORMs

---

# Data driven web applications

![Ruby App und Datenbank](slides/database/ruby-database-sketch.png)

* Web-Applikationen bieten Nutzern Lese-/Schreibzugriff
  * Kurzlebig: Sessions, Warenkorb? (E-Commerce)
  * Langlebig: Nutzerkonto, Bestellungen (E-Commerce)
* Langlebige Daten meist in RDBMS
* Unterscheidung RDBMS und NoSQL

---

# RDBMS vs. NoSQL

* Klassen von Systemen zum Speichern meist langlebiger Daten
* RDBMS: Relationale Datenbanksysteme
  * Daten in Tabellen organisiert
  * Datenrelationen über Fremdschlüssel
  * Normalisierung von Daten
  * Transaktionssicherheit
  * …
* NoSQL: Nicht-relationale Systeme
  * Bspw. Dokumentenbasiert wie MongoDB
  * Oder Key-Value Speicher wie Redis
* Fokus: RDBMS

*[SQL]: Structured Query Language
*[RDBMS]: Relational Database Management Systems

---

# OOP und RDBMS

* Herausforderungen/Unterschiede
  * Keine komplexen Datenstrukturen in RDBMS
  * Typisierung von Daten
  * Identität von Daten (Mapping von Objekt <-> Tabellen)
  * …
  * [Object-relational Impedance Mismatch](https://de.wikipedia.org/wiki/Object-relational_impedance_mismatch)
* Zwei unterschiedliche Ansätze für Datenzugriff

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

* Design Pattern: Object-relational Mapper
* Verbindet RDBMS und OOP
  * Erzeugt/Löscht/Modifiziert Daten in Tabellen
* Generiert SQL aus Ruby-Code
* Typ-Konvertierung: Konvertiert Daten in Ruby-Objekte
  * Nicht alle Daten sind Strings
  * Mapping zwischen DB-Typ und Ruby-Objekt
* Verwaltete Assoziationen zu Objekten
* …

---

# ORM: Design Pattern

* Zwei alternative Design Patterns
  * [Data Mapper](http://www.martinfowler.com/eaaCatalog/activeRecord.html)
  * [Active Record](http://www.martinfowler.com/eaaCatalog/activeRecord.html)
* Fokus: Active Record
  * Anfängerfreundliches Design Pattern
  * Persistenz und Verhalten in einem Objekt
* Disclaimer: ORMs haben Probleme
  * [Martin Fowler: ORM Hate](http://martinfowler.com/bliki/OrmHate.html)
  * [Jeff Atwood: ORM is the Vietnam of Computing](http://blog.codinghorror.com/object-relational-mapping-is-the-vietnam-of-computer-science/)
  * [Yegor Bugayenko: ORM Is an Offensive Anti-Pattern](http://www.yegor256.com/2014/12/01/orm-offensive-anti-pattern.html)
* Blick auf Active Record Design Pattern

---

# Active Record Design Pattern

* Eine Zeile pro SQL-Tabelle ist ein Ruby-Objekt (genauer: Record)
* DB-Funktionalität, Daten und sonstige Methoden im Record enkapsuliert
* ActiveRecord: Ruby Implementierung des Active Record Pattern

~~~
# ActiveRecord Pseudocode
peter = User.new(firstname: 'Peter', lastname: 'Pan')
peter.id         # `.id` ist der Primärschlüssel in der DB-Tabelle
=> nil           # Da dieses Objekt noch nicht gespeichert ist: nil
peter.save       # `.save` erzeugt im Hintergrund das notwendige SQL:
peter.id         # `INSERT INTO users (firstname, lastname) VALUES ('Peter', 'Pan')`
=> 14            # Nach dem `INSERT` setzt die ORM auch die `id` des Records
~~~
{: .lang-ruby }

Weitere Beispiele für Datenzugiff und -modifikation, Typkonvertierung und Assoziationen

---

# ActiveRecord: Datenzugriff

---

# Ruby ORMs

* Ruby ORM Implementierungen
  * ActiveRecord (Standard ORM in Rails)
  * DataMapper (Alternative zu ActiveRecord)
* ActiveRecord:
  * Leichter Einstieg, wenig Konfiguration
  * Basis für die Rails-Applikationen
  * RDBMS-Support/Adapter: MySQL, PostgreSQL, MSSQL

---


---

# Links und Resourcen

* http://datamapper.org/getting-started.html
* https://github.com/tomaszj/sinatra-datamapper-sample
* http://code.tutsplus.com/tutorials/ruby-for-newbies-working-with-datamapper--net-19622
* http://recipes.sinatrarb.com/p/models/data_mapper
