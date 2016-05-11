# Sinatra

# TODO
![Sinatra Logo](slides/ruby-sinatra/sinatra-logo.png)

---

* Sinatra
  * ist ein "gem"
  * ein gem ist eine Ruby-Bibliothek/Code der mit dem "gem"-Command installiert werden kann
* Ruby Bibliotheken
  * Was nicht im Core/Stdlib ist, ist meist als ruby gem verfügbar
  * Bspw. kleine Tools wie ein Slack-Client, alternativer HTTP-Client
  * Aber auch ganze Ruby-Frameworks wie Ruby on Rails oder eben Sinatra
* Das gem-Command
  * Usage: gem install name-des-gems
  * Code wird auf rubygems.org gehostet
  * *.gem-Datei ist eine ZIP-Datei mit einem Manifest *.gemspec
* Rubygem wird im GEM_HOME installiert.
  * Anschließend wird der `lib`-Ordner eines gems in den `LOAD_PATH` eingetragen
  * Ähnlich wie $PATH in UNIX-System oder Windows-System
  * mit `require` kann Code nachgeladen werden
* Seitdem es viele gems gibt, gibt es ein neues Problem
  * Viele Projekte nutzen nun den Code anderer Leute
  * Diese Abhängigkeiten müssen aktuell gehalten werden
  * Außerdem haben Bibliotheken oft untereinander Abhängigkeiten
  * Problem: Welche Version von welchen Bibliotheken brauche ich für mein Projekt?
  * Bild: Dependency-Graph
* Lösung: Bundler
  * Implementiert einen Algorithmus der es erlaubt azyklische gerichtete Graphen effizient aufzulösen
  * Wenn die Abhängigkeiten eines Projekts mal definiert sind, werden Sie *eingefroren*
  * Gemfile: Abhängigkeiten
  * Gemfile.lock: Konkrete Versionen die mit der aktuellen Applikation installiert werden müssen
* Die meisten ruby-Projekte haben solche Gemfiles
* Bspw. Sinatra hat auch so ein Gemfile

# Bundler

