# Ruby-Übung

Deine Arbeit an der Produktwebseite der B!gUG hat überzeugt. Jedoch soll demnächst
eine Web-Applikation mit einem Ruby Back End weiterentwickelt werden und deine
Ruby-Kenntnisse sind noch sehr rudimentär. Das soll sich ändern.

*[B!gUG]: Bazinga! Gemeinnützige Unternehmergesellschaft


## Allgemeines

| Git Abgabe bis     | Punkte (Jenkins) | CodeReview      |
|---------------------------------------------------------|
| 15. Mai, 23:59 Uhr | 2 Punkte         | kein CodeReview |
{: .table.table-bordered }


## Briefing

Um die Sprache besser zu verstehen sollen eine Reihe von Coding-Aufgaben in Ruby
erledigt werden.

Diese Aufgaben in Form von Software-Tests geschrieben und als [Ruby Koans](http://rubykoans.com/)
bekannt.

Jede Übungsaufgabe ist ein Test zu einem bestimmten Feature der Programmiersprache.
Diese Tests sind Ruby-Code der sich selber inspiziert und sicherstellen soll, dass
die im Code formulierten Aussagen **wahr** sind.

Eine **wahre Aussage** wird nach dem Ausführen des Ruby Codes als *grüner Test*
dargestellt. Eine **unwahre Aussage** als *roter test*.

Zu Beginn sind alle Aussagen unwahr und es ist nun deine Aufgabe diese Aussagen
zu korrigieren, indem du den Ruby Code modifizierst.


## Ruby Koans lösen

1. Das ruby-koans Projekt von github clonen und mit dem Terminal in das ruby-koans Projekt wechseln
1. Mit dem `rake`-Befehl die Tests starten
1. Beginne die unwahren Aussagen zu korrigieren
1. Zurück zu Schritt 2, bis alle unwahren Aussagen korrigiert wurden
1. Alle Änderungen mit git speichern und deinen Code in eine neue App zum Aris-Server hochladen


### Schritt 1: git-repository clonen

~~~
git clone https://github.com/HTW-Webtech/ai-ruby-koans /home/student/Workspace/aufgabe-ruby
cd aufgabe-ruby
~~~
{: .lang-bash }


### Schritt 2: ruby-koans Code ausführen mit `rake`

~~~
rake
~~~
{: .lang-bash }

Als Ergebnis nach dem 1. `rake`-Befehl wird im Terminal die 1. unwahre Aussage angezeigt:

![1. Ruby Koans Aufgabe](exercises/ruby/ruby-step1.png)


Der Code in Zeile 10 der Datei `/home/student/Workspace/aufgabe-ruby/about_asserts.rb` sieht so aus:

~~~
def test_assert_truth
  assert false                # This should be true
end
~~~
{: .lang-ruby }


Die `assert`-Methode verlangt immer eine *wahre Aussage* oder den boolschen Ausdruck `true`. Um diesen
Test zu korrigieren genügt es also `false` durch `true` zu ersetzen.

~~~
def test_assert_truth
  assert true                # This should be true
end
~~~
{: .lang-ruby }

Ein erneuter Aufruf von `rake` erzeugt nun eine neue Ausgabe. Der nächste Test mit einer
unwahren Aussage soll korrigiert werden.


### Schritt 3:

Nachdem alle unwahren Aussagen korrigiert wurden, sollen alle Änderungen mit git gespeichert
und in einer neuen App auf den Aris-Server hochgeladen werden.

Achtung: Der git remote `origin` ist bereits an github vergeben. D.h. wenn ihr den Aris-Server
als neuen remote hinzufügt, müsst ihr einen anderen Namen vergeben. Bspw. aris.

Im Folgenden ein paar Beispiele als Hilfestellung zur Lösung der Aufgaben.


### Weitere Beispiele

Problem:

~~~
def test_assert_equality
  expected_value = __
  actual_value = 1 + 1

  assert expected_value == actual_value
end
~~~
{: .lang-ruby }


Lösung:

~~~
def test_assert_equality
  expected_value = 2 # 2 == (1+1) => true
  actual_value = 1 + 1

  assert expected_value == actual_value
end
~~~
{: .lang-ruby }


## Ruby-Code korrigieren

Die Aufgaben werden sukzessiv herausfordernder. Um ein besseres Verständnis für die
Syntax von Ruby und die grundlegenden Datenstrukturen bzw. Ruby-Klassen (Array, Object, Hash, String,…)
zu bekommen, sollten die Lern-Inhalte im [Lern-Bereich](#lern-bereich) genutzt werden.


# Lern-Bereich

Für den Anfang sollten alle die TryRuby.org Seite nutzen. Die *Ruby Essential Training*-Videos
auf Lynda sind zwar zeitintensiv, bieten aber eine wichtige Grundlage für die nächsten Übungen.


## Einstieg

* [TryRuby.org](http://tryruby.org/)
  Browser-basiertes interaktives Einsteiger-Tutorial. Man lernt Syntax und die grundlegenden
  Klassen wie String, Array und Hashes kennen.

* [codeacademy: Ruby](https://www.codecademy.com/learn/ruby)
  Interaktives Beginner-Tutorial von Code Academy. Gute Grundlage um die Datentypen und
  Kontrollstrukturen von Ruby zu lernen.

## Lynda-Videos

* [Ruby Essential Training: Kevin Skoglund](http://www.lynda.com/Ruby-tutorials/Welcome/47905/57934-4.html)
  Sehr umfangreiche Video-Lektionen zu den Grundlagen der Ruby-Programmierspache. Mit 7 Stunden Laufzeit
  auch entsprechend zeitintensiv. Kapitel 2-6 sind zu empfehlen um die Grundlagen zu vertiefen.


## Bücher

* [Humble little ruby Book](http://www.humblelittlerubybook.com/)
  Ggf. ein bisschen out of date, aber gute Grundlage und kostenlos
