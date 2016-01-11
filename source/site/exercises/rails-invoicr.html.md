# Invoicr

Sie möchten sich nach dem Studium selbstständig machen und haben auch bereits einen ersten Kunden.
Um diesem auch nach Monatsende eine Rechnung stellen zu können möchten Sie Ihre Arbeitszeiten
erfassen und verwalten können.

Statt hierfür eine Excel-Liste zu pflegen, soll eine Web-Applikation gebaut werden die das erfassen der Zeiten und
Erstellen von Rechnungen übernimmt. Der InvoicR.


## Abgabe / CodeReview

CodeReview bis spätestens zur Übung am 8. Februar. Optional gibt es die Möglichkeit einen Ausweichtermin zum CodeReview
für den 9. Februar (15-19 Uhr) zu vereinbaren. Der Review wird 20 Minuten in Anspruch nehmen.

* 1-3 Min. Vorstellung des Konzepts
* 7-9 Min. Vorstellung der technischen Lösungen
* 10 Min. CodeReview mit Fragen von mir


## Briefing

Tipp zur Vorgehensweise beim Bau der InvoicR-App. Die nächsten 3 Wochen wird es Lehrveranstaltungen zu
den Themen Rails-Models, Controller/Routing und Views geben. Die InvoicR-App kann entsprechend dieser
Veranstaltungen iterativ entwickelt werden. D.h. man beginnt mit den Rails-Models, baut dann die Controller/das Routing
und zum Schluss erst die Views.

Die Übungsstunden sollten dazu genutzt werden um Rückfragen zu klären.


### Daten-Modelle

Die InvoicR-App soll die folgenden Daten verwalten können:

* Projekte:
  * Titel: Name des Kunden/Projektbezeichnung die auf der Rechnung verwendet wird)
  * Beschreibung: Freitext für Notizen
  * Stundensatz in Euro: Stundensatz der mit dem Kunden/für das Projekt vereinbar wurde
  * Adressdaten: Angabe Kunden-Adresse zur Anzeige auf den Rechnungen
* Arbeitszeiten/Aufwände:
  * Titel: Aufgabe/Tätigkeit die geleistet wurde
  * Beschreibung: Freitext für beliebige Informationen
  * Minuten: Der Zeitaufwand der in die Aufgabe/Tätigkeit investiert wurde
* Rechnungen:
  * Titel: Titel/Betreff der Rechnung. Wird auf der Rechnung angezeigt
  * Beschreibung: Beschreibungstext für Rechnung
  * Rechnungshöhe: Der Rechungsbetrag soll immer ein rundeter Euro-Betrag sein
  * Umsatzsteuer-Betrag: Rechnungsbetrag * 19% Umsatzsteuer. Soll auf der Rechnung dargestellt werden.


### Daten-Validierungen

Die Attribute der ActiveRecord-Models sollen die folgenden Validierungen enthalten.

* Projekt
  * Titel: Pflicht
  * Beschreibung: Optional
  * Stundensatz: Pflicht. Ganzzahl größer 0
* Arbeitszeit:
  * Titel: Pflicht
  * Beschreibung: Optional
  * Minuten: Pflicht
* Rechnung:
  * Titel: Pflicht
  * Beschreibung: Optional
  * Rechnungshöhe: Pflicht. Dezimalzahl größer 0


### Daten-Relationen

Die App-Daten (Projekt, Arbeitszeit und Rechnung) stehen in folgender Beziehung zueinander:

* Ein Projekt hat viele Arbeitszeiten (One to many)
* Eine Arbeitszeit gehört zu einem Projekt und zu einer Rechnung
* Ein Projekt hat viele Rechnungen
* Eine Rechnung gehört zu einem Projekt
* Eine Rechung hat viele Arbeitszeiten


### Features + Punkte

Für die folgenden Funktionalitäten gibt es die entsprechenden Anzahl an Punkten.

* 3 Punkte: CRUD-Operationen für Projekte
* 3 Punkte: CRUD-Operationen für Arbeitszeiten (mit Relation zu einem Projekt)
* 4 Punkte: CRUD-Operationen für Rechnungen (mit Relation zu N Arbeitszeiten)
* 2 Punkte: Druck-Vorschau für Rechnung (Einfache HTML-Seite mit allen Rechnungsdaten wie in der Beispiel-App s.u.)
* 2 Punkt: Dynamisches Berechnen der Umsatzsteuer einer Rechnung
* 2 Punkt: Vorberechnen des Rechnungsbetrags aus der Summe der Beträge der verknüpften Arbeitszeiten


### Beispiel InvoicR-App

Die InvoicR-App wurde exemplarisch implementiert und ist unter der Adresse <http://327-kinky-castle.htw-webtech.com/>
zu finden. Diese Implementierung umfangreicher als Ihre Lösung sein soll/muss. Sie sollten ihr eigenes sehr einfaches
System finden die o.g. Anforderungen zu erfüllen. Wenn Sie Fragen dazu haben bitte ich Sie diese in der Übung
zu klären.


### Technische Anforderungen

Die Rails-Applikation wird auf dem Aris Server deployed. Das folgende Video fasst die einzelnen Schritte zusammen:

<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/uMpOxGj8EGs?rel=0" frameborder="0" allowfullscreen></iframe>

