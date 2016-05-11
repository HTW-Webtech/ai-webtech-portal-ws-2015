# Sinatra-Übung

Nachdem du nun die ersten Gehversuche mit der Ruby-Syntax erfolgreich absolviert hast,
wirst du gleich ins kalte Wasser geworfen. Die Bazinga-Produktseite soll mit Hilfe
des Web-Frameworks Sinatra einige dynamische Features bekommen.


## Allgemeines

| Git Abgabe bis    | Punkte (Jenkins) | CodeReview ab | Punkte (CodeReview) |
|----------------------------------------------------------------------------|
| 29. Mai, 23:59 Uhr | 6 Punkte         | 1. Juni       | 2 Punkte |
{: .table.table-bordered }


## Briefing

Die Produkt-Webseite soll drei neue Features bekommen:

* Es soll ein rudimentärer Besuchszähler gebaut werden, der einem Besucher anzeigt wie häufig Er/Sie die Seite aufgerufen wurde.
* Das Kontaktformular soll die abgesendeten Formularinhalte nach dem Verschicken noch mal anzeigen.
* Es soll einen Adminbereich geben. Dieser ist via [HTTP Basic Auth](https://en.wikipedia.org/wiki/Basic_access_authentication) geschützt.

Die Details zu den neuen Features und Tipps zur Herangehensweise werden in folgenden Abschnitten beschrieben.

*[B!gUG]: Bazinga! Gemeinnützige Unternehmergesellschaft


### Sinatra Template

Obwohl Sinatra schon mit wenig Code ermöglicht eine dynamische Webseite zu bauen, muss zunächst
ein wenig [Boilerplate-Code](https://en.wikipedia.org/wiki/Boilerplate_code) angelegt werden.

Damit dies keinen von der eigentlichen Arbeit abhält, kann ein github-Repository als Grundlage
für das eigene Sinatra-Projekt genutzt werden.

~~~
cd ~/Workspace
git clone https://github.com/HTW-Webtech/ai-sinatra-base aufgabe6
cd aufgabe6
bundle install
ruby app.rb  # Startet die Sinatra-App
~~~


## Anforderungen

Die Grundstruktur der Produktwebseite bleibt erhalten. Nutze ruhig deinen existierenden
Quelltext aus der HTML-Übung.


### Exemplarische Implementierung

Unter <https://htw-sinatra-hello-world.herokuapp.com/> siehst du eine exemplarische Implementierung
der beschriebenen Features.


### Besucherzähler auf jeder Seite

Um der Seite ohne viel Aufwand das Gefühl von Dynamik zu verleihen soll ein sehr rudimentärer
Besucherzähler gebaut werden, der auf jeder Seite angezeigt wird und sich folgendermaßen verhält.

* Beim allerersten Aufruf wird der Zähler auf 1 gesetzt und zeigt unten am Ende der Seite den Text: `Das ist ihr 1. Seitenaufruf.`
* Beim Laden einer beliebigen anderen Seite wird der Zähler inkrementiert: `Das ist ihr 2. Seitenaufruf.`
* Der Zähler wird in einer `session` verwaltet. Der eigentliche Wert wird somit in einem Cookie im
  Browser eines Besuchers gespeichert.
  * D.h. der Besucherzähler zählt nicht ALLE Seitenaufrufe, sondern die eines Browsers


#### Tipps zur Umsetzung

* Um vor jedem Seitenaufruf den Zähler zu inkrementieren, eignet sich das Konzept von [Filtern](http://www.sinatrarb.com/intro.html#Filters)
  in Sinatra.
* Um den Zähler im Cookie eines Browsers zu speichern, bietet Sinatra ein [Session](http://www.sinatrarb.com/intro.html#Using%20Sessions)-Objekt.
* Beim 1. Zugriff auf einen Wert in der Session ist dieser noch `nil`. In Ruby gibt es ein
  Pattern dafür Werte die initial `nil` sind zu setzen und gleichzeitig sicherzustellen, dass
  ein gesetzter Wert nicht überschrieben wird:

~~~
session['counter'] ||= 0 # Setzt den Session-Counter auf 0, wenn er `nil` war
session['counter'] += 1  # Inkrementiert den Counter um 1
~~~
{: .lang-ruby }


### Kontaktformular: Anzeigen von Formularinhalten

Nachdem ein Formular an die Adresse `/contact` abgesendet wurde, soll der Nutzer auf der
`/contact`-Seite noch mal seine Formulareingaben sehen können.

![Kontaktformular vor dem Absenden](exercises/sinatra/contact-before.png)

![Kontaktformular nach dem Absenden](exercises/sinatra/contact-after.png)



### Admin-Seite: admin.html

Im Footer jeder Seite soll der Link zum Admin-Bereich `admin.html` prominent platziert sein.

![Link zur Admin Seite](exercises/sinatra/admin-link.png)


#### Passwortschutz

Der Zugang zur Admin-Seite `admin.html` soll mit einem Passwort geschützt sein. Ein Aufruf
von <https://htw-sinatra-hello-world.herokuapp.com/admin.html> öffnet den folgenden Dialog.

![Passwortschutz für die Admin Seite: admin.html](exercises/sinatra/admin-auth.png)

Damit nur die richtigen Personen Zugriff haben, soll hier eine richtig sichere Nutzer/Passwort-Kombination
verwendet werden:

* **Nutzer:** admin
* **Passwort:** admin

Wenn das Passwort richtig angegeben wurde, sieht der Nutzer nun die vorerst noch leere Admin-Seite.

![Die Admin Seite: admin.html](exercises/sinatra/admin.png)


#### Tipps zur Umsetzung

* TODO: Folgen noch. Besonders der Teil für den Passwort-Schutz


## Hosting der Sinatra-App auf Heroku

Im Gegensatz zu den vorherigen Lösungen, soll die Sinatra-App nicht auf den Aris-Server, sondern auf
einen externen Hoster hochgeladen werden. Für Ruby-Webapplikationen gibt es verschiedene Anbieter, jedoch
empfehle ich den kostenlosten Dienst von [Heroku](https://www.heroku.com/).

Um die Sinatra-App bei Heroku hochladen zu können:

* Registrierst du dir einen kostenlosen Heroku-Account: <https://signup.heroku.com/dc>
* Installierst das `heroku`-Kommando (oder auch Heroku Toolbel genannt): [Set up: Heroku Toolbelt](https://devcenter.heroku.com/articles/getting-started-with-ruby#set-up)

Und folgst dann dieser Anleitung:

~~~
cd ~/Workspace/aufgabe6 # Wechsel in dein Projekt git-Repository
heroku create           # Erzeugt eine neue Heroku-App.
                        # Beim 1. Aufruf fragt das Programm nach Nutzer/Passwort
                        # Wenn alles funktioniert hat, hat das heroku-Kommando in
                        # deinem git-Repository einen neuen `remote` mit dem Namen
                        # Heroku eingetragen.
git remote -v           # Listet der alle remotes zu deinem git-Repository auf
git push heroku master  # Mit einem git push nach `heroku` wird die Sinatra-App
                        # auf einen Heroku-Server hochgeladen und gestartet.
heroku open             # Öffnet die Root-URL deiner App in einem Browser
~~~
{: .lang-ruby }

Jetzt sollte deine App auch schon auf Heroku öffentlich erreichbar sein. Als nächstes musst du noch
im Aris die URL zu deiner Heroku-App hinterlegen.

Wenn du deine App bei einem anderen Hoster betreiben möchtest, ist das kein Problem.


## Heroku-App im Aris eintragen

Um dem Aris-Server nun deine Heroku-App bekannt zu machen, kannst du im Aris folgende Einstellung
an deiner App vornehmen:

![Heroku-App im Aris eintragen](exercises/sinatra/heroku-aris-app.png)

Nach dem Speichern verlinkt der "View Online"-Button nun auf deine Heroku-App und die Jenkins-Tests
werden in wenigen Minuten auch gegen die Heroku-App ausgeführt.
