# Ruby

![Ruby Logo](slides/ruby-sinatra/ruby-logo.png)

---

# Agenda

* Ruby?
* Syntax und Style Guide
* Kontrollstrukturen
* Datenstrukturen/Klassen
* Standard-Bibliothek
* IRB: Interactive Ruby
* gem-Kommando und rubygems.org
* Übungsaufgabe

---

# Ruby?

* 1993: Yukihiro Matsumoto veröffentlicht Ruby (in Japan)
* 1999: Ruby-talk, erste englisch-sprachige Mailing Liste
* 2000: "Ruby Programming", erstes englischsprachiges Ruby-Buch
* 2003: Ruby 1.8: LTS bis 2013
* 2005: Ruby on Rails veröffentlicht - Aufmerksamkeit für Ruby
* 2014: Ruby 2.2: Generational GC, div. Optimierungen
* 2015: Ruby 2.3: Frozen Strings, div. Optimierungen

---

# Paradigmen

* Interpretiert
  * CRuby / MRI (Matz Ruby Interpreter)
  * JRuby (JVM)
  * Rubinius (LLVM, Ruby)
  * …
* OOP, funktional, imperativ
* Dynamisch typisiert
* Flexible Syntax, Grundlage für DSL
  * Chef, Puppet, Capistrano, …
  * U.a. Inspiration für CoffeeScript
* Metaprogrammierung
  * Code-Modifikation zur Laufzeit

*[DSL]: Domain-specific languages

---

# Ruby

für C/C++ Programmierer auf [ruby-lang.org](https://www.ruby-lang.org/en/documentation/ruby-from-other-languages/to-ruby-from-c-and-cpp/)

* No Compilation
* No Macros, No Casting, No pointers
* No header files, No #define, No assembly
* Arguments by value, not reference
* No variable declaration
* …

---

# Syntax und Style Guide

Community-driven style guide auf github:
[github.com/bbatsov/ruby-style-guide](https://github.com/bbatsov/ruby-style-guide)

---

# Ruby ausführen

* Jede Ruby-Installation bringt drei ausführebare Programme mit
  * `ruby`: Der Interpreter (für uns Version >= 2.0)
  * `irb`: Eine interaktiver Interpreter (REPL)
  * `gem`: Ein Programm zur Paketverwaltung (via rubygems.org)
* Ruby-Skripte ausführen:
  * `ruby`-Interpreter mit Skript-Pfad aufrufen

~~~
puts "Hello World"
~~~
{: .lang-ruby }
Die Datei liegt bspw. unter /home/student/ruby/script.rb

~~~
ruby /home/student/ruby/script.rb
=> "Hello World"
~~~
{: .lang-bash }

---

# Ruby lernen

* Dokumentation: <http://ruby-doc.org/>
  * Core: <http://ruby-doc.org/core-2.3.1/>
  * Standard Library: <http://ruby-doc.org/stdlib-2.3.1/>
* `irb`: Interaktiver Ruby Interpreter / REPL
  * Read, evaluate, print loop
  * Code reinkopieren und ausführen

---

# IRB Beispiel

~~~
"Das ist ein String".class
# => String

[1, 2, 3].class
# => Array

# usw.
~~~

---

# Ruby Grundlagen

* Alles ist ein `BasicObject`
  * Alle Ruby-Typen erben von `BasicObject`
  * Und erben damit das Verhalten (Methoden)
* Lokale Variablen und Konstanten
* Datentypen: String, Integer, Fixnum, Array, Hash
* Kontrollstrukturen
* Klassen & Methoden

---

# Alles ist ein Object

* Jedes Objekt in Ruby hat eine Klasse
* Alle Klassen erben von `BasicObject`
* Jedes Objekt implementiert `.class` und gibt die Klasse zurück

![Ruby Klassenbaum](slides/ruby/classtree.png)

---

# Lokale Variablen und Konstanten

~~~
# Lokale Variablen.
name = 1      # Typ wird nicht explizit angegeben
name = "Hans" # Typ wechselt dynamisch
puts name     # gibt "Hans" aus
              # `puts` schreibt einen Wert als String nach stdout.
              # Dazu ruft `puts` auf dem Objekt die `to_s`-Methode auf,
              # welche eine String-Repräsentation des Objekts erzeugt.
puts 14       # Gibt bspw. 14.to_s => "14" aus.

# Konstanten (not so constant?)
PI = 3.1415
PI = 3        # Wirft eine Warnung, akzeptiert Änderung aber
puts PI       # gibt "3" aus
~~~
{: .lang-ruby }

---

# String

* Sequenz von Zeichen/Bytes
* Üblicherweise als String-Literal mit Anführungszeichen: "Hallo"
* Sonderzeichen/Steuerzeichen via Escape Sequenz
  * `\n` => newline/Zeilenumbruch
  * `\t` => Tabulator
* Doppelte Anführungszeichen erlauben Interpolation

---

# String Beispiel

~~~
name = "Hans"
greeting = "Hallo #{name}"
puts greeting    # Gibt "Hallo Hans" aus. Strings mit doppelten
                 # Anführungszeichen können andere Ruby-Strings
                 # enthalten, wenn umgeben mit '#{' und '}'.

"Hallo Hans".split   # Trennt einen String anhand von Leerzeichen
=> ["Hallo", "Hans"] # Rüchgabewert ist ein Array mit mehreren Strings

"Hallo".reverse
=> "ollaH"

"Hallo Welt".downcase
=> "hallo welt"

"Hallo Welt".upcase
=> "HALLO WELT"
~~~
{: .lang-ruby }

[Methoden-Übersicht](http://ruby-doc.org/core-2.3.1/String.html)

---

# Symbol

* Ähnlich wie String, jedoch mit speziellem Verhalten
* Immer mit vorangestelltem `:`, bspw. `:foo`
* Wird oft als Bezeichner anstelle von Konstanten verwendet
* Oder als Schlüssel für Hash (später mehr)

~~~
color = :red
weekday = :wednesday
~~~
{: .lang-ruby }

Mehr zu Symbols  [hier](http://www.randomhacks.net/2007/01/20/13-ways-of-looking-at-a-ruby-symbol/).

---

# If/Else und Boolsche Ausdrücke

~~~
# Einfache boolsche Ausdrücke müssen nicht geklammert `()` werden
if 2 > 1
  puts "2 is greater than 1"
else
  puts "Hier stimmt was nicht"
end

# Mehrere Vergleiche können mit && oder || logisch verknüpft werden
# Klammern helfen die Präzedenz/Precedence klar zu definieren.
if ((2 > 1) && (1 > 0)) || 1 == 1
  puts "Alles ok soweit"
end

# Das `if` kann bei einem Einzeiler auch hinten angestellt werden
puts "2 is greater than 1" if 2 > 1
~~~
{: .lang-ruby }

---

# While/Loop

~~~
# Gibt die Zahlen von 1 bis 99 auf der Konsole aus
count = 1
while count < 100
  puts "#{count} is greater than 1"
  count += 1
end
~~~
{: .lang-ruby }

---

# Array

* Integer-indexierte sortierte Liste von Elementen
  * 1. Element beginnt mit Index 0, danach 1, usw.
* Ähnlich dem Array/Vektor-Konzept anderer Programmiersprachen
* Elemente müssen nicht vom selben Typ sein
* Initialisierung als Literal `[]`, `Array.new` oder Hilfsmethoden
  * bspw. `%w()` erzeugt ein Array von Strings

---

# Array Beispiele

~~~
list = Array.new(1, "test", :symbol)
=> [1, "test", :symbol]

cities = ["Paris", "Cologne", "Berlin"]
# ist dasselbe wie
cities = %w(Paris Cologne Berlin)

cities.length
=> 3 # Alternativ cities.size oder cities.count

cities.push("Edinburgh") # Fügt ein neues Element am Ende des Arrays hinzu
=> ["Paris", "Cologne", "Berlin", "Edinburgh"]

cities.pop # Gibt das letzte Element aus dem Array zurück
=> "Edinburgh"

cities.sort # Returns a sorted Array (comparing objects)
=> ["Berlin", "Cologne", "Paris"]
~~~
{: .lang-ruby }

[Methoden-Übersicht](http://ruby-doc.org/core-2.3.1/Array.html)

---

# Hash

* In anderen Sprachen: Assoziatives Array, Dictionary oder HashMap
* Key/Index-Value Datenstruktur mit flexiblen Indizes
  * Key/Index bspw. String, Integer oder auch Symbol
  * Value: beliebiges Objekt
* Erstellung via Hash-Literal oder `Hash.new`
* Modifikation über `[]`-Methode auf Hash

---

# Hash Beispiele

~~~
age = Hash.new
age['timmey'] = 10
age['hans'] = 14
puts data # Gibt `{"timmey"=>10, "hans"=>14}` aus

# Andere Syntax, aber identisches Objekt
data = {
  'anna' => 30,
  'bob' => 35,
}

data[0] = 'Test' # Keys/Indizes und Values können gemischt werden
data[:color] = :red
puts data # Gibt `{"anna"=>30, "bob"=>35, 0=>"Test", :color=>:red}` aus

data.keys   # Gibt die Keys/Indizes als Array zurück
# => ["anna", "bob", 0, :color]

data.values # Gibt die Keys/Indizes als Array zurück
# => [30, 35, "Test", :red]
~~~
{: .lang-ruby }

[Methoden-Übersicht](http://ruby-doc.org/core-2.3.1/Hash.html)

---

# Klassen & Methoden

* Wie Java oder andere OOP unterstützt Ruby Klassen/Methoden/Vererbung
* Klassen helfen Verhalten/Daten zu enkapsulieren

---

# Klassen & Methoden Beispiele

~~~
class Cat
  def initialize(name)
    @name = name  # Variablen mit einem @-Zeichen sind Instanz-Variablen
  end

  def speak
    puts "#{@name} says: meow!" # Und können innerhalb eines Objekts von
                                # allen Methoden mit @name adressiert werden
  end
end

peter = Cat.new("Peter")
peter.speak
=> "Peter says meow!"
~~~
{: .lang-ruby }

---

# Weiter

* Übung zum Erlernen der Ruby-Grundlagen
* Lern-Videos und Tutorials

