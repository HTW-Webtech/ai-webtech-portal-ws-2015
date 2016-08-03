# Ruby

![Ruby Logo](slides/ruby-sinatra/ruby-logo.png)

---

# Agenda

* Ruby?
* Ruby lernen
* Ruby ausführen
* Grundlagen
* Syntax
  * Kontrollstrukturen
  * String, Symbol, Array, Hash
  * Ruby Code Blöcke
  * Klassen und Methoden

---

# Ruby?

* 1993: Yukihiro Matsumoto veröffentlicht Ruby (in Japan)
* 1999: Ruby-talk, erste englisch-sprachige Mailing Liste
* 2000: "Ruby Programming", erstes englischsprachiges Ruby-Buch
* 2003: Ruby 1.8: LTS bis 2013
* 2005: Ruby on Rails veröffentlicht - Aufmerksamkeit für Ruby
* 2014: Ruby 2.2: Generational GC, div. Optimierungen
* 2015: Ruby 2.3: Aktuellste Version

---

# Paradigmen

* Interpretiert
  * CRuby / MRI (Matz Ruby Interpreter, YARV)
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
*[YARV]: Yet another Ruby VM
*[JVM]: Java Virtual Machine

---

# Ruby

für C/C++ Programmierer auf [ruby-lang.org](https://www.ruby-lang.org/en/documentation/ruby-from-other-languages/to-ruby-from-c-and-cpp/)

* Keine Kompilierung
* Keine Macros, Kein Casting, Keine pointer
* Keine header files, Kein #define, Kein assembly
* Argumente *by value* statt *by reference*
* Keine Variablen-Deklaration
* …

---

# Ruby lernen

* Ruby Syntax und APIs lernen
* Offizielle Dokumentation: <http://ruby-doc.org/>
  * Core: <http://ruby-doc.org/core-2.3.1/>
  * Standard Library: <http://ruby-doc.org/stdlib-2.3.1/>
* Style Guide und Best Practices github:
  * [github.com/bbatsov/ruby-style-guide](https://github.com/bbatsov/ruby-style-guide)

---

# Ruby ausführen

* Jede Ruby-Installation liefert mind. drei Programme aus
  * `ruby`: Der Interpreter (für uns Version >= 2.0)
  * `irb`: Eine interaktive Ruby-Shell (REPL)
  * `gem`: Programm zur Paketverwaltung (via rubygems.org)

* Ruby-Skripte ausführen:
  * `ruby`-Interpreter mit Skript-Pfad aufrufen

~~~
# Diese Skript liegt bspw. unter /home/student/ruby/script.rb
puts "Hello World"
~~~
{: .lang-ruby }

~~~
# Und kann jetzt mit ruby-Programm aufgerufen werden
ruby /home/student/ruby/script.rb
# Die Ausgabe ist der Text "Hello World" auf dem Bildschirm
=> "Hello World"
~~~
{: .lang-bash }

---

# IRB: Ruby Shell

* Code-Beispiele aus den Folien austesten
  * Entweder als Skript in Datei speichern
  * Oder kopieren und in IRB einfügen
* `irb`: Interaktiver Ruby Interpreter / Ruby Shell (REPL)
  * Read, evaluate, print loop
  * Code eingeben, ausführen und direkt die Ausgabe sehen

---

# IRB Beispiel

~~~
"Das ist ein String" # => "Das ist ein String"

"Das ist ein String".upcase # => "DAS IST EIN STRING"

"Das ist ein String".reverse # => "gnirtS nie tsi saD"
~~~

---

# Grundlagen

* Kommentare, Variablen und Konstanten
* Objekte und Methoden
* Kontrollstrukturen: If/Else/While
* Ruby Core Klassen & Standard Bibliothek
* Datentypen: String, Integer, Array, Hash
* Klassen

---

# Kommentare, Variablen und Konstanten

~~~
# Text hinter der Raute ignoriert der Interpreter
age  = 35     # Variablen-Namen werden mit Kleinbuchstaben angegeben.
name = "Otto" # Der Variablen-Typ ist implizit. `name` bspw. String
age = "14"    # Variablen-Typ kann dynamisch wechseln. `age`: Typ String.
              # ACHTUNG: In der Praxis bringt ein Typ-Wechsel i.d.R.
              # Nachteile. Übliche Quelle für komplexe Bugs.

puts name     # Schreibt "Hans" auf den Bildschirm => "Hans"
              # `puts` gibt ein Objekt auf dem Bildschirm aus.
puts 14       # => 14
puts "Test"   # => "Test"

# Konstanten (not so constant?)
PI = 3.1415   # Konstanten werden mit Versalien/Großbuchstaben beschrieben.
              # Ruby erlaubt es Konstanten zu ändern! Dabei gibt der
              # Interpeter lediglich eine Warnung auf dem Bildschirm aus.
PI = 3        # => 3
~~~
{: .lang-ruby }

---

# If/Else und boolsche Ausdrücke

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
if 2 > 1
  puts "2 is greater than 1"
end
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

# Ruby Klassen

![Ruby Core und Standard Bibliothek](slides/ruby/ruby-base-classes.png)

---

# Objekte und Methoden

![Ruby Methoden Aufruf](slides/ruby/ruby-method-call.png)

---

# Strings

~~~
name = "Hans"        # Strings können mit '#{variable}' in andere Strings
x = "Hallo #{name}"  # eingebettet werden, wenn Sie mit doppelten
                     # Anführungszeichen umfasst sind.
puts x               # => "Hallo Hans"
puts 'Hallo #{name}' # => "Hallo #{name}" Einfache Anführungszeichen
                     # ignorieren dies.

"Hallo Welt".upcase  # Jeder String ist ein Objekt vom Typ `String` und
=> "HALLO WELT"      # bietet verschiedene Methoden zur Manipulation der
                     # Zeichen. Bspw. `upcase` erzeugt einen neuen String
                     # bei dem alle Zeichen Großbuchstaben sind.

"Hallo".reverse      # `.reverse` erzeugt neuen String mit allen Zeichen
=> "ollaH"           # in umgekehrter Reihenfolge.

"Hallo Welt".downcase
=> "hallo welt"
~~~
{: .lang-ruby }

---

# Strings

* Sequenz von Zeichen/Bytes
* Üblicherweise als *String-Literal* mit Anführungszeichen: "Hallo"
* Sonderzeichen/Steuerzeichen via Escape Sequenz
  * `\n` => newline/Zeilenumbruch
  * `\t` => Tabulator
* Strings mit doppelten Anführungszeichen können interpoliert werden
* Strings mit einfachen Anführungszeichen werden nicht interpoliert

[String: Methoden-Übersicht](http://ruby-doc.org/core-2.3.1/String.html)

---

# Symbol

* Ähnlich wie String, jedoch mit speziellem Verhalten
* Immer mit vorangestelltem Doppelpunkt, bspw. `:name_eines_symbols`
* Wird oft anstatt einer Konstante als Bezeichner für Objekt-Zustände verwendet

~~~
ampel = Ampel.new  # Ampel soll eine Verkehrsampel beschreiben
ample.phase        # `.phase` gibt die aktuelle Ampelhase zurück
# => :rot          # Zu Beginn ist die Ampel rot
ample.wechsel      # Mit `.wechsel` wird die Ampelhase verändert
ample.phase        # Nun ist die Ampel :gelb
# => :gelb
~~~
{: .lang-ruby }

Mehr zu Symbols [hier](http://www.randomhacks.net/2007/01/20/13-ways-of-looking-at-a-ruby-symbol/).

[Symbol: Methoden-Übersicht](http://ruby-doc.org/core-2.3.1/Symbol.html)

---

# Array #1

~~~
numbers = [1, 2,3 ]      # Die einfachste Art ein Array anzulegen
numbers = Array.new      # Alternative Syntax für ein leeres Array

list = [1, "A", :symbol] # Ein Array kann verschiedene Typen halten

run_seconds = [33, 45, 32, 37, 35, 31]
run_seconds.max          # `.max` gibt den größten Wert zurück
# => 45
run_seconds.min          # `.min` gibt den kleinsten Wert zurück
# => 31
run_seconds.sort         # `.sort` sortiert die Ergebnisse nach Größe
# => [31, 32, 33, 35, 37, 45]
run_seconds.sort.reverse # `.reverse` ändert die Reihenfolge
~~~
{: .lang-ruby }

---

# Array #2

~~~
anna = ["Paris", "Berlin"]
hans = ["Berlin", "Hamburg"]
puts "Hans has been to #{hans.length} cities!"
# => "Hans has been to 2 cities!"

hans.push("Edinburgh")     # Fügt ein neues Element am Ende des Arrays hinzu
# => ["Berlin", "Hamburg", "Edinburgh"]

hans.pop                   # Gibt das letzte Element aus dem Array zurück
# => "Edinburgh"

anna & hans                # Die Und-Verknüpfung gibt die Teilmenge von zwei
# => ["Berlin"]            # Arrays zurück. Bspw. Städte in denen Anna und
                           # Hans schon mal waren.

all = anna + hans          # Mit `+` werden Arrays zusammengefasst
# => ["Paris", "Berlin", "Berlin", "Hamburg"]
all.uniq!                   # `.uniq!` löscht Duplikate im Array
# => ["Paris", "Berlin", "Hamburg"]
puts "Hans and Anna have been to #{all.length} different cities!"
# => "Hans and Anna have been to 3 different cities!"
~~~
{: .lang-ruby }

[Array: Methoden-Übersicht](http://ruby-doc.org/core-2.3.1/Array.html)

---

# Array

* Integer-indexierte sortierte Liste von Elementen
  * 1. Element beginnt mit Index 0, danach 1, usw.
* Ähnlich dem Array/Vektor-Konzept anderer Programmiersprachen
* Elemente müssen nicht vom selben Typ sein
* Initialisierung als Literal `[]`, `Array.new` oder Hilfsmethoden
  * bspw. `%w()` erzeugt ein Array von Strings

---

# Hash

~~~
age = {
  "anna" => 27,      # Der Key ist hier der String 'hans' und der Value
  "otto" => 22,      # ein Integer. Der Value kann beliebige Werte enthalten.
  "hans" => 35,
}

age.keys             # `.keys` gibt die Keys als Array zurück
# => ["anna", "otto", "hans"]
age.values           # `.values` gibt die Values als Array zurück
# => [27, 22, 35]

age['harald'] = 42   # Fügt einen neuen Key-Value Eintrag hinzu
puts age
# => {"anna"=>27, "otto"=>22, "hans"=>35, "harald"=>42}

age['anna'] = 12     # Modifizert einen Eintrag mit dem Key 'Anna'
puts age
# => {"anna"=>12, "otto"=>22, "hans"=>35, "harald"=>42}
~~~
{: .lang-ruby }

[Hash: Methoden-Übersicht](http://ruby-doc.org/core-2.3.1/Hash.html)

---

# Hash

* In anderen Sprachen: Assoziatives Array, Dictionary oder HashMap
* Key/Index-Value Datenstruktur mit flexiblen Indizes
  * Key/Index: beliebiges Objekt, aber meist String, Integer oder Symbol
  * Value: beliebiges Objekt
* Instantiierung via Hash-Literal `{ a: "b" }` oder `Hash.new`
* Modifikation über `[]`-Methode auf Hash

---

# Ruby Code Blöcke

* Manche Methoden nehmen als Argument einen Code Block entgegen
* Code Blöcke sind ähnlich wie Methoden
  * Sie nehmen Argument entgegen
  * Und haben einen Rückgabewert
* Code Blöcke können ein oder mehrzeilig dargestellt werden

~~~
                     # Die Methode `.each` führt den folgenden Code für
                     # jedes Element (in dem Fall nur die 1) einmal aus.
[1].each do |i|      # Der Code Block beginnt mit dem `do` keyword und
  puts "Hello #{i}"  # nimmt ein Argument `i` entgegen. Dieses kann in dem
end                  # Block verwendet werden, bspw. zur Bildschirmausgabe
# => "Hello 1"

                     # Dies ist derselbe Code Block in einer Zeile.
                     # `do` und `end` werden durch `{` und `}` ausgetauscht.
[1].each { |i| puts "Hello #{i}" }
# => "Hello 1"
~~~
{: .lang-ruby }
---

# Enumerable

~~~
age = {
  "anna" => 27,
  "otto" => 14,
}

over18 = age.select do |key, value| # `key` ist der Name bspw. 'anna' und der
  value > 18                        # `value` enthält in unserem Fall das Alter
end                                 # `select` sammelt alte Werte aus `age`,
                                    # die die Bedingung erfüllen, dass `value`
                                    # größer 18 ist.
puts over18
# => {'anna' => 27}
~~~
{: .lang-ruby }

[Enumerable: Methoden-Übersicht](http://ruby-doc.org/core-2.3.1/Enumerable.html)

---

# Enumerable

* Ruby Arrays und Hashes erben Methoden vom [`Enumerable`-Modul](http://ruby-doc.org/core-2.3.1/Enumerable.html)
* `Enumerable`-Methoden helfen Sammlungen von Elementen zu verarbeiten
* Bspw. mit folgenden Methoden
  * `.each` führt einen Code Block für jedes Element einmal aus
  * `.select` sammelt alle Elemente die in einem Code Block `true` ergeben
  * `.detect` sammelt nur das 1. Element das in einem Code Block `true` ergibt
  * …

---

# Klassen & Methoden

~~~
class Cat
  def initialize(name)
    @name = name  # Variablen mit einem @-Zeichen sind Instanz-Variablen
  end

  def speak                      # Und können innerhalb eines Objekts mit
    puts "#{@name} says: meow!"  # `@name` adressiert werden.
  end
end

peter = Cat.new("Peter")
manni = Cat.new("Manni")

peter.speak
=> "Peter says: meow!"
mannispeal
=> "Manni says: meow!"
~~~
{: .lang-ruby }

---

# Klassen & Methoden

* Wie Java oder andere OOP unterstützt Ruby Klassen/Methoden/Vererbung
* Klassen helfen Verhalten und Daten zu enkapsulieren
* Mit der Methode `.new` wird eine Instanz einer Klasse erzeugt
* Es gibt Instanz- und Klassenvariablen
* Klassen-Instanzen müssen nicht dereferenziert werden
* Klassen unterstützen Vererbung
* …

---

# Weiter

* Übung zum Erlernen der Ruby-Grundlagen
* Lern-Videos und Tutorials in der Übung

