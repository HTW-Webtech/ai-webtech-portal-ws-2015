# Invoicr

Sie möchten sich nach dem Studium selbstständig machen und haben auch bereits einen ersten Kunden.
Um diesem auch nach Monatsende eine Rechnung stellen zu können möchten Sie Ihre Arbeitszeiten
erfassen und verwalten können.

Statt hierfür eine Excel-Liste zu pflegen, soll eine Web-Applikation gebaut werden die das erfassen der Zeiten und
Erstellen von Rechnungen übernimmt. Der InvoicR.

# Briefing

## Datenmodell

Die InvoicR-App soll die folgenden Arten von Daten verwalten können:


* **Projekt**
  * Titel: Name des Kunden/Projektbezeichnung die auf der Rechnung verwendet wird)
  * Beschreibung: Freitext für Notizen
  * Stundensatz in Euro: Stundensatz der mit dem Kunden/für das Projekt vereinbar wurde
  * Adressdaten: Angabe Kunden-Adresse zur Anzeige auf den Rechnungen

* **Arbeitszeit**
  * Titel: Aufgabe/Tätigkeit die geleistet wurde
  * Beschreibung: Freitext für beliebige Informationen
  * Minuten: Der Zeitaufwand der in die Aufgabe/Tätigkeit investiert wurde

* **Rechnung**
  * Titel: Titel/Betreff der Rechnung. Wird auf der Rechnung angezeigt
  * Beschreibung: Beschreibungstext für Rechnung
  * Rechnungshöhe: Der Rechungsbetrag soll immer ein rundeter Euro-Betrag sein
  * Umsatzsteuer-Betrag: Rechnungsbetrag * 19% Umsatzsteuer. Soll auf der Rechnung dargestellt werden.


## Daten-Validierungen

Die Attribute der ActiveRecord-Models sollen die folgenden Validierungen enthalten.

* **Projekt**
  * Titel: Pflicht
  * Beschreibung: Optional
  * Stundensatz: Pflicht. Ganzzahl größer 0

* **Arbeitszeit**
  * Titel: Pflicht
  * Beschreibung: Optional
  * Minuten: Pflicht

* **Rechnung**
  * Titel: Pflicht
  * Beschreibung: Optional
  * Rechnungshöhe: Pflicht. Dezimalzahl größer 0


## Daten-Relationen

Die ActiveRecord-Models für Projekt, Arbeitszeit und Rechnung stehen in folgender Beziehung zueinander:

* Ein Projekt hat viele Arbeitszeiten (One to many)
* Eine Arbeitszeit gehört zu einem Projekt und zu einer Rechnung
* Ein Projekt hat viele Rechnungen
* Eine Rechnung gehört zu einem Projekt
* Eine Rechnung hat viele Arbeitszeiten


# Punkte/Leistungsbewertung

Für die folgenden Funktionalitäten gibt es die entsprechenden Anzahl an Punkten.

* CRUD (10 Punkte):
  * 3 Punkte: Für Projekte
  * 3 Punkte: Für Arbeitszeiten (inkl. Relation zu Projekt)
  * 4 Punkte: Für Rechnungen (inkl. Assoziation/Relation zu Arbeitszeiten)

* Statistiken auf Startseite (3 Punkte):
  * 1 Punkt: Anzahl der insgesamt erfassten Arbeitszeiten (in Minuten oder wahlweise Stunden)
  * 1 Punkt: Summer der in Rechnung gestellten Arbeitszeiten (in Minuten oder wahlweise Stunden)
  * 1 Punkt: Statistik über die in Rechnung gestellten Arbeitszeiten (Summer aller in Rechnung gestellten Minuten)

* Zusätzliche Features (3 Punkte):
  * 1 Punkt: Druck-Vorschau für Rechnung (Einfache HTML-Seite mit allen Rechnungsdaten wie in der Beispiel-App s.u.)
  * 1 Punkt: Automatische Berechnung des Rechnungsbetrags (Netto) auf Basis der verknüpften Arbeitszeiten
  * 1 Punkt: Automatische Berechnung des Umsatzsteueranteils einer Rechnung


## Beispiel InvoicR-App

Die InvoicR-App wurde exemplarisch implementiert und ist unter der Adresse <http://admin:nmToMoFlnmToMoFlnmToMoFl@invoicrrr.herokuapp.com/>
zu finden. Diese Implementierung umfangreicher als Ihre Lösung sein soll/muss. Sie sollten ihr eigenes sehr einfaches
System finden die o.g. Anforderungen zu erfüllen. Wenn Sie Fragen dazu haben bitte ich Sie diese in der Übung
zu klären.

