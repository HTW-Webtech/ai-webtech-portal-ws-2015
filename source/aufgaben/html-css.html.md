# HTML, CSS

## Beschreibung

Die _Supero Un.Ltd._ vermittelt Superhelden aus der Umgebung, um Menschen bei Aufgaben im Alltag helfen. Das Unternehmen ist an Sie herangetreten, um seinen Webauftritt überarbeiten zu lassen.

Dabei sind folgende Seiten gewünscht:

- Startseite mit kurzer Vorstellung des Unternehmens
- Menü über das alle Seiten erreicht werden können
- Tabelle aller verfügbaren Helden mit Name, Foto und Preis pro Stunde
- Kontaktformular, das folgende Elemente enthält:
  - Dropdown mit Liste aller Helden
  - Eingabefeld für die zu verrichtende Aufgabe
  - Eingabefeld für die E-Mail-Adresse des Kunden
  - Textfeld für etwaige Sonderwünsche
- Impressum
- Steckbriefe von drei Helden (Inhalte können aus der Wikipedia übernommen werden.)
- FAQ – Liste der häufig gestellten Fragen

Eine Starthilfe finden Sie unter [HTML & CSS](/wiki/html-css/) und das entsprechende Bildmaterial unter [Part Time Jobs.zip](/assets/images/Part Time Jobs.zip).
<small>(Quelle: [Flickr - Flying Mouse2007](https://www.flickr.com/photos/65414366@N00/sets/72157636359023846/))</small>


## Aufgabe

Entwickeln Sie besagte Website. Dabei sollen folgende Kriterien erfüllt werden:

- Es werden mindestens 30 unterschiedliche HTML-Elemente verwendet.
- Dokumententyp, Schriftsatz und Titel sind gesetzt.
- Im HTML ist mindestens eine externes Stylesheet korrekt eingebunden.
- Es werden im CSS mindestens 10 Auszeichnungen für Elemente und Klassen und 30 verschiedene Eigenschaften verwendet.

Gewünscht ist letztlich eine wohl ausgezeichnete, optisch ansprechende Website. Das Kontaktformular muss nicht funktionieren. Verwenden Sie bitte keine Frameworks.

Legen Sie die fertige Seite in das Verzeichnis "2. Aufgabe" in Ihrem Git-Repo.


## Optional

Folgende Kriterien können erfüllt werden:

- Einbinden eines Hintergrundbildes.
- Benutzung mehrerer Schriftarten, beispielsweise von [Google Fonts](http://www.google.com/fonts/) ([Better Google Fonts](http://somadesign.ca/demos/better-google-fonts/)) oder ähnlichen Diensten. Oder [Comic Neue](http://comicneue.com/).
- Einbinden einer Karte, beispielsweise über [Google Maps](https://maps.google.com), [OpenStreetMap](http://www.openstreetmap.org/) oder ähnliche Dienste.


## Bewertung

Die Anzahl der HTML-Elemente und CSS-Eigenschaften wird mit folgendem Script geprüft. <small>(Ja, das ist nicht exakt, aber reicht.)</small>

```shell
HTML=$(ack -h --html '<(\w+).*?>' --output '$1' | sort -uf | wc -l)
CSS=$(ack -h --css  '(-(khtml|moz|ms|o|webkit)-)?([\w-]*)\s*:.*?;' --output '$3' | sort -uf | wc -l)
echo "${PWD##*/} $HTML $CSS"
```


## Wer mehr wissen möchte
* [The Absolute Minimum Every Software Developer Absolutely, Positively Must Know About Unicode and Character Sets (No Excuses!)](http://www.joelonsoftware.com/articles/Unicode.html)
* [Funktionsweise von Browsern: Hinter den Kulissen moderner Web-Browser](http://www.html5rocks.com/de/tutorials/internals/howbrowserswork/)
* [Frontend Development Bookmarks](https://github.com/dypsilon/frontend-dev-bookmarks)

