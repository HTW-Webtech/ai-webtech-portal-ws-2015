# HTML 5

HyperText Markup Language

---

# Agenda

* Hypertext?
* Markup Language
* HTML Struktur & Elemente
* Valides HTML
* Historie zu HTML
* Standards: W3C vs WHATWG
* HTML Content Categories
* HTML Beispiele
* Praxis-Tipps

---

# Hypertext?

* Problem: Tim Berners Lee suchte (1980+) nach Lösung Forschungsergebnisse zu teilen
* Idee: Informationen als strukturierte Dokumente referenzierbar/teilbar machen
* Ziel: Austausch dieser Dokumente (via HTTP)
* Hypertext meint Text, der [Links](#) zu anderen Dokumenten enthält
* Damals SGML, Heute Hypertext Markup Language oder "HTML 5"
* Was ist diese Markup Language?

*[SGML]: Standard Generalized Markup Language

---

# Markup Language

* HTML beschreibt die Struktur und Bedeutung von Text
* Struktur und Semantik, nicht die Darstellungsweise/Ästhetik
* Neben den eigentlichen Inhalten auch Metadaten:
  * Zum Dokument (Author, Sprache)
  * Multimediainhalte wie Bilder, Audio und Video
  * Formulare (User-Input, Interaktion)
  * Microdata (Semantic Web, maschinenlesbares Web)
  * Accessibility (Screenreader)

---

# HTML Beispiel

~~~
<html>
  <head>
    <title>Hallo Welt</title>
  </head>
  <body>
    <p>Text</p>
  </body>
</html>
~~~
{: .lang-html }

~~~
Text
~~~

---

# HTML Struktur

* Jedes Dokument beginnt mit einem Doctype und `<html>`-Element: root
* Innerhalb vom root: *Elemente* mit *Attributen*
* Verschachtelung folgt Regeln
* Wie sieht ein HTML-Element aus?

---

# HTML Elemente

![HTML Tags](slides/html/html-element.png)

---

# HTML Grundstruktur

1. HTML-Dokument definiert Doctype: Version der Spezifikation
  * Verschiedene Doctypes. Heute nur der HTML5 Doctype relevant
1. Ein `<head>`-Element definiert Meta-Informationen zum Dokument
  * Titel des Dokuments
  * Author, Erstellungsdatum, Sprache, etc.
  * Skripte und Stylesheets
1. Ein `<body>`-Element für den eigentlichen Inhalt

---

# HTML Grundstruktur Beispiel

~~~
<!DOCTYPE html>
<html>
  <head>
    <meta name="author" content="Gregory Igelmund" />
    <title>Beispiel Dokument zum HTML Boilerplate</title>
  </head>
  <body>
    <p>Das ist der eigentliche Inhalt</p>
  </body>
</html>
~~~
{: .lang-html }

---

# Valides HTML

* Validität von Markup prüfen lassen: [W3C: Nu HTML Checker](https://validator.w3.org/nu/)
* [W3C HTML 5.1 Spezifikation](https://w3c.github.io/html/)
* [WHATWG HTML Spezifikation](https://html.spec.whatwg.org/multipage/)
* Warum zwei Spezifikationen?

---

# Historie zu HTML

* 1996: Standard vom W3C [W3C History](http://www.w3.org/History.html)
* 2004: WHATWG-Gründung [Mailing-Liste](https://whatwg.org/news/start)
* 2008: Einigung zwischen W3C/WHATWG zu HTML5 [W3C-News](http://www.w3.org/QA/2008/01/html5-is-html-and-xml.html)
* 2011: Trennung von W3C/WHATG [W3C/WHATWG Split](http://www.i-programmer.info/news/191-htmlcss/4531-which-html5-whatwg-and-w3c-split.html)
  * W3C: HTML5 + Snapshots
  * WHATWG: "Living Standard"

---

# Zwei parallele Standards

![W3C vs WHATWG Spec](slides/html/w3c-vs-whatwg-spec.png)

* Zum Verhalten von HTML Elementen gibt es verschiedene Definitionen.
* Meist deckungsgleich
* Abweichung definiert durch Browser-Unterstützung
* Mehr dazu sowie Empfehlungen später
* Jetzt: Überblick HTML Elemente

---

# HTML Elemente

* Zweistellige Zahl an HTML-Elementen. [Übersicht auf MDN.](https://developer.mozilla.org/en-US/docs/Web/HTML/Element)
* Organisiert in sogenannten Content Categories
* Jede dieser Kategorie enthält Regeln für die HTML Elemente
* Bspw. über Verschachtelung von Elementen

![Content Categories](slides/html/content-categories.jpg)

---

# HTML Content Categories

| Kategorie | Definition |
|-----------|------------|
| Metadata | Beeinflusst Präsentation oder Verhalten anderer Elemente |
| Section  | Beschreiben den Rahmen für andere Elemente wie Header oder Footer |
| Heading  | Überschrift/Titel einer Sektion/Section |
| Phrasing | Beschreibt den Text und Multimedia-Inhalte |
| Embedded | Bindet zusätzliche oft Multimedia-Ressourcen ein wie Video, Audio |
| Interactive | … |
| Form | … |

---

# HTML Element Beispiele

* Metadaten
* Überschriften
* Text-Auszeichnung bspw. Hervorhebung
* Semantische Erweiterung von Text
* Links und iFrames
* Bilder, Audio und Video
* HTML Formulare

---

# Metadata

* `meta` (author, lang, custom properties)
* `script` (javascript)
* `link` (stylesheets)

~~~
<head>
  <meta charset=UTF-8" />
  <meta name="author" content="Gregory Igelmund" />
  <meta name="generator" content="Foobar" />
  <meta name="keywords" content="webentwicklung, …" />
  <link rel="stylesheet" type="text/css" href="style.css" />
  <script type="text/javascript" src="script.js" />
~~~
{: .lang-html }

---

# Überschriften

* `h1` Wichtigste Überschrift
* `h2` 2. wichtigste Überschrift
* `h3` …

~~~
<h1>Urheberrecht: Die digitale Urheberrechtsreform versackt im Fiasko</h1>
<h2>"20 Krisenjahre" bei den </h2>
~~~
{: .lang-html }

---

# Text-Auszeichnung

* `strong` Wichtigkeit
* `em` Hervorhebung (ähnlich strong, oft differential)
* `small` Das Kleingedruckte
* `blockquote` Zitat
* …

~~~
<p>When doing x it is <strong>imperative</strong> to do y before.</p>
<p>When doing <em>x</em> it is important to do <em>y</em> before.</p>
<small>Legal foo</small>
<blockquote cite="http://zitate.net/albert-einstein-zitate">Phantasie ist wichtiger als Wissen, denn Wissen ist begrenzt.</blockquote>
~~~
{: .lang-html }

---

# Semantische Erweiterung

* `abbr` Abkürzung, bspw.
* `time` maschinenlesbares Datum


~~~
<abbr title="beispielsweise">Bspw.</abbr> vergangenen
<time datetime="2015-04-01 12:44">Sonntag Mittag</time>.
~~~
{: .lang-html }

---

# Links und iFrames

* `a` Anker/Anchor mit Verweis auf anderes Dokument oder andere Stelle in demselben Dokument
* `iframe` Bindet externes Dokument ein

~~~
Auf <a href="https://github.com/" title="Github">github</a>
ist u.a. die W3C Spec zu finden.
~~~
{: .lang-html }

~~~
<iframe src="https://github.com/"></iframe>
~~~
{: .lang-html }

---

# Bilder, Video und Audio

* `img` Externe Bilder einbinden
* `audio` Audiodaten im Browser
* `video` Video-Dateien im Browser
* `canvas` Zeichenfläche

~~~
<img src="http://example.com/logo.png" alt="Firmenlogo von Example" />

<audio src="audio.ogg" autoplay />

<video src="videofile.ogg" autoplay poster="poster.jpg">
  Sorry, your browser doesn't support embedded videos,
  but don't worry, you can <a href="videofile.ogg">download it</a>
  and watch it with your favorite video player!
</video>
~~~
{: .lang-html }

---

# HTML Formulare

* `input` (text, button, color, date, email)
* `label` (bezieht sich auf input)
* `progress` (%-Anzeige)
* `select` (Auswahl von Elementen)

~~~
<form action="" method="post">
  <label for="POST-name">Name:</label>
  <input id="POST-name" type="text" name="name">
  <input type="submit" value="Save">
</form>
~~~
{: .lang-html }

---

# HTML5 nutzen

* Manche Elemente wie canvas sind *relativ neu*
* HTML Spezifikation beschreibt nur Regeln und Verhalten
* reale Browser-Unterstützung muss geprüft werden
* Über Feature-Support informieren, bspw. bei <a href="http://caniuse.com/" target="_blank">caniuse.com</a>
* Feature-Detection mit Hilfe von <a href="https://modernizr.com/" target="_blank">Modernizr</a>

---

# Modernizr

![Feature detection mit Modernizr](slides/html/feature-detection-modernizr.png)

---

# Caniuse.com

![Caniuse Beispiel](slides/html/caniuse.png)


---

# Weitere Links

* [W3C HTML Spec auf github.com](https://github.com/w3c/html)
