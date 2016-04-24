# HTML 5

HyperText Markup Language

---

# Agenda

* Hypertext
* DOM Tree

---

![HTML Structure](slides/html/html-structure.png)

---

# Hypertext

* Hypertext ist Text, der mit anderen Texten über einen [Link](#) verknüpft ist
* Dank dem Web (DNS, URI, etc.) können Dokumente global eindeutig referenziert werden
* und noch wichtiger: *geteilt* werden

---

# Markup Language

* HTML beschreibt komplexe Dokumente
* Dazu gehören neben Darstellung von Text:
  * Meta-Informationen zum Dokument (Author, Sprache)
  * Bilder, Videos, Ton (Multimedia)
  * Formulare (User-Input/Interaktion)
  * Microdata (Semantic Web, maschinenlesbares Web)
  * Accessibility (Screenreader)

---

# HTML Tags

![HTML Tags](slides/html/html-element.png)

---

# DOM Tree

![DOM Tree](slides/html/html-dom-tree.png)

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

---

# Beispiel

~~~
<!doctype html>
<html lang="de">
  <head>
    <meta charset="utf-8">
    <title>Der Waschbär</title>
    <meta name="description" content="Alles wichtige über den Waschbären">
  </head>
  <body>
    <h1>Der Waschbär</h1>
    <p>
      Der <b>Waschbär</b> (<i>Procyon lotor</i>), auch als <b>Nordamerikanischer
      Waschbär</b> oder altertümlich als <b>Schupp</b> bezeichnet, ist ein in
      Nordamerika heimisches mittelgroßes <a href="/wiki/S%C3%A4ugetiere"
      title="Säugetiere">Säugetier</a>. Seit Mitte des 20. Jahrhunderts ist er
      als <a href="/wiki/Neozoon" title="Neozoon" class="mw-redirect">Neozoon</a>
      …
      und <a href="/wiki/Mischwald" title="Mischwald">Mischwäldern</a>.
    </p>
  </body>
</html>
~~~
{: .lang-html }

---

# Geschichte von HTML

* 1996: Standard vom W3C [W3C History](http://www.w3.org/History.html)
* 2004: WHATWG-Gründung [Mailing-Liste](https://whatwg.org/news/start)
* 2008: Einigung zwischen W3C/WHATWG zu HTML5 [W3C-News](http://www.w3.org/QA/2008/01/html5-is-html-and-xml.html)
* 2011: Trennung von W3C/WHATG [W3C/WHATWG Split](http://www.i-programmer.info/news/191-htmlcss/4531-which-html5-whatwg-and-w3c-split.html)
  * W3C: HTML5 + Snapshots
  * WHATWG: "Living Standard"

---

# Zwei Standards ⚡

![W3C vs WHATWG Spec](slides/html/w3c-vs-whatwg-spec.png)

---

# Markup validieren

W3C bietet Dienst zum validieren von HTML5 https://validator.w3.org/

![W3C Validator](slides/html/w3c-validator.png)

---

# Konsequenzen

* Browser-Hersteller definieren die Wirklichkeit
* Über Feature-Support informieren, bspw. bei <a href="http://caniuse.com/" target="_blank">caniuse.com</a>
* Feature-Detection mit Hilfe von <a href="https://modernizr.com/" target="_blank">Modernizr</a>

---

# Modernizr

![Feature detection mit Modernizr](slides/html/feature-detection-modernizr.png)

---

# Caniuse.com

![Caniuse Beispiel](slides/html/caniuse.png)

---

# HTML Content categories

* Metadata
* Flow content
* Sectioning content
* Heading content
* Phrasing content
* Embedded content
* Interactive content
* Form-associated content

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

# Embedded

* `audio`
* `video`
* `canvas`
* `iframe`

~~~
<video src="videofile.ogg" autoplay poster="poster.jpg">
  Sorry, your browser doesn't support embedded videos,
  but don't worry, you can <a href="videofile.ogg">download it</a>
  and watch it with your favorite video player!
</video>
~~~
{: .lang-html }

---

# Form

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

# Semantic Web

HTML maschinenlesbar, aber viele Informationen im Fließtext *versteckt*

> Am 25. Februar hat ein Waschbär in der Nähe von Cochem…

~~~
Am <abbrev title="2015-02-25 12:00">25. Februar</abbrev> hat …
~~~
{: .lang-html }
