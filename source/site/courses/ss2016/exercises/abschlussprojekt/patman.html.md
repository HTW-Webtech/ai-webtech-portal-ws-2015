# PatMan

Ein Bekannter von Ihnen hat sich vor kurzem mit einer Praxis für Physiotherapie
niedergelassen und benötigt eine simple Web-Anwendung zur Verwaltung von Patientenakten
sowie von Terminen für die Patienten.

**PatMan** ist eine Web-App zum Patientenmanagement.


# Briefing

## Datenmodell

PatMan soll die folgenden Arten von Daten verwalten:


* **Patient**
  * Name: Name des Patienten (Vorname + Nachname)
  * Adresse: Anschrift des Patienten (bspw. für den Versand von Rechnungen)
  * E-Mail: Zur Kontaktmöglichkeit

* **Note**
  * Beschreibung: Freitext für beliebige Informationen

* **Appointment**
  * Startzeitpunkt: Beginn eines Temrins
  * Beschreibung: Beschreibungstext für den Termin


## Daten-Validierungen

Die Attribute der ActiveRecord-Models sollen die folgenden Validierungen enthalten.

* **Patient**
  * Name: Pflicht
  * Adresse: Pflicht
  * E-Mail: Pflicht

* **Note**
  * Beschreibung: Pflicht

* **Appointment**
  * Startzeitpunkt: Pflicht.
  * Beschreibung: Optional


## Daten-Relationen

Die ActiveRecord-Models für Patient, Note und Appointment stehen in folgender Beziehung zueinander:

* Ein Patient hat viele Notes (1 -> n)
* Eine Note gehört zu einem Patienten (1 -> 1)
* Ein Patient hat viele Appointments (1 -> n)
* Ein Appointment gehört zu einem Patienten (1 -> 1)


# Punkte/Leistungsbewertung

Für die folgenden Funktionalitäten gibt es die entsprechenden Anzahl an Punkten.

* CRUD (10 Punkte):
  * 3 Punkte: Patient
  * 3 Punkte: Note (+ Relation zu Patient)
  * 4 Punkte: Appointment (+ Relation zu Patient)

* Statistiken auf Startseite (2 Punkte):
  * 1 Punkt: Anzahl der erstellten Patienten
  * 1 Punkt: Anzahl der erstellten Appointments

* Zusätzliche Features (4 Punkte):
  * 1 Punkt: Auflistung aller "Upcoming Appointments", die noch in der Zukunft liegen
  * 1 Punkt: Auflistung aller "Past Appointments", die schon in der Vergangenheit liegen
  * 1 Punkt: Auflistung aller Notizen zu einem Patienten auf der Patienten-Seite
  * 1 Punkt: Auflistung aller Appointments zu einem Patienten auf der Patienten-Seite


## Beispiel PatMan-App

Eine beispielhafte PatMan-App ist unter
<https://patman.herokuapp.com/>
zu sehen.

