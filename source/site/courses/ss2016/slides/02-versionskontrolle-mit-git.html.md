# Versionskontrolle

* Software-Entwickler produzieren (u.a.) Quelltext
* Fragestellungen:
  * Versionierung: Definition einer bestimmten Version von Software?
  * Exploration: Experimentelle Änderungen ohne Copy/Paste?
  * Kollaboration: Lese/Schreibzugriff für andere Entwickler?
  * Retrospektive: Umfassendes Protokoll über Änderungen?
* Dezentrale Versionskontrolle (DVCS) wie [git](https://git-scm.com/),
  [Mercurial](https://www.mercurial-scm.org/), [Bazaar](http://bazaar.canonical.com/en/)

---

# git - Vorteile

* Speichereffizient: Lediglich Änderungen belegen Speicher
* Offline-Modus: Änderungen lokal offline durchführen und bei Bedarf mit Server synchronisieren
* Unterstützung nicht-linearer Software-Entwicklung
* Kryptographische (SHA256) Versionierung von Änderungen
* Dezentral: Jeder ist Server

Aktuelle Version: 2.8.0 (Stand: 28. März 2016)

---

# git - Basics

* .git-Verzeichnis (Repository) verwaltet alle Projektdateien
* Der Befehl `git init` erzeugt neues *git-Repository*
* Der Ordner mit einem .git-Verzeichnis ist das *Working Directory*
* Zusätzlich kennt git eine *Staging-Area* um Änderungen vorzubereiten

---

# git - areas

![alt text](/images/courses/ss2016/slides/git/areas.png "git Areas")

---

# git - Kommandos

* `git init` - Create a new git repository
* `git add [file]` - Add a file to the staging area
* `git commit -m "Explanation of a change"` - Commit a change
* `git log` - List latest changes
* `git checkout -b [name]` - Create and switch to new branch

---

# git - Lernen

Die git-Übung enthält Links zu interaktiven Tutorials und Literatur für Einsteiger
