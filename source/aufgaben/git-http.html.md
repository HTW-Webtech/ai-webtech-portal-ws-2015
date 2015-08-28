# Git, HTTP

## Git

Richten Sie sich ein Git-Repo ein. Lesen Sie dazu die Seite [Git](/wiki/git).


## HTTP

Das _Hypertext Transfer Protocol_ ist eine der grundlegenden Technologien des Webs und dient zur Übertragung von Inhalten.

Die erste Aufgabe besteht darin, HTTP mit einem Server zu sprechen, von ihm einen Token generieren zu lassen und diesen in Ihr Git-Repo zu committen.

Öffnen Sie dazu zuerst Ihre Shell.[^shell]

Verbinden Sie sich nun per [Telnet](http://de.wikipedia.org/wiki/Telnet) mit dem Host dieser Seite <small>(Achtung: Port 8080)</small> und fragen Sie nach dem Inhalt im Root-Verzeichnis. Wird kein konkreter Dateiname angegeben, ist es unter Webservern üblich, eine Index-Datei auszuliefern (sofern vorhanden), beispielsweise `index.html`. Sie können zweimal Enter drücken, um die Anfrage zu senden.

```shell
telnet beier.f4.htw-berlin.de 8080
GET / HTTP/1.0
```

{% asciicast 18877 %}

Der Server teilt Ihnen in seiner Antwort zuerst im "Response-Header" einige Informationen über die gewünschte Datei mit und schickt Ihnen dann im "Response-Body" deren Inhalt. Diese enthält den Namen der nächsten Datei.

Dazu benutzen wir allerdings nicht mehr Telnet. Denn das tut zwar seinen Job, wurde aber nicht für das gemacht, wofür wir es verwenden. Das Mittel unserer Wahl ist das TCP-IP-Allzweckwerkzeug [Netcat](http://de.wikipedia.org/wiki/Netcat), das über `nc` aufgerufen werden kann.[^netcat]

Bevor wir die nächste Anfrage absetzen, müssen wir diese noch erweitern. In HTTP 1.0 war es nicht nötig, Header in der Anfrage mitzuschicken. Allerdings ist es möglich, dass ein Server für mehrere Domains zuständig ist und daher weitere Informationen benötigt, um zu wissen, welche Seite gemeint ist.[^wikipedia]

Mit HTTP 1.1 wurde darum der [Host-Header](http://de.wikipedia.org/wiki/Host_Header) eingeführt, der jeder Anfrage beiliegen muss und anhand dessen der Server eine namensbasierte Unterscheidung treffen kann. (Nach [RFC 2616](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.23) muss der Port angegeben werden, wenn es sich nicht um den Standardport 80 handelt.)

Steuern wir nun die in der Antwort der ersten Anfrage enthaltene Website an <small>(und achten Sie auf den Slash vor dem Dateinamen)</small>:

```
nc beier.f4.htw-berlin.de 8080
GET /<datei> HTTP/1.1
Host: beier.f4.htw-berlin.de:8080
```

<blockquote class="twitter-tweet" lang="en"><p>HTTP status ranges in a nutshell: 1xx: hold on, 2xx: here you go, 3xx: go away, 4xx: you fucked up, 5xx: I fucked up</p><cite>— Steve Losh (@stevelosh) <a href="https://twitter.com/stevelosh/statuses/372740571749572610">August 28, 2013</a></cite></blockquote>

Der Server antwortet mit `HTTP/1.1 301 Moved Permanently`. [Statuscode 301](http://de.wikipedia.org/wiki/HTTP-Statuscode#3xx_.E2.80.93_Umleitung) bedeutet, dass die gesuchte Seite dauerhaft nicht mehr unter dieser URL zu finden ist. Im `Location`-Header finden Sie die neue URL der Seite.

Steuern Sie diese an. (Sollte die alte Verbindung noch offen sein, können Sie diese einfach weiterverwenden.)

Hat alles geklappt, sehen Sie HTML. Ein Browser würde dieses parsen und entsprechend darstellen. Sie müssen diesen Teil Ihrer Vorstellungskraft überlassen. Im Code ist ein Link enthalten, unter dem Sie Ihren Token bekommen.

Um den Link anzusteuern, benutzen wir wieder ein neues Werkzeug: [cURL](http://de.wikipedia.org/wiki/CURL). Dieses spricht von Hause aus HTTP und bekommt in seiner einfachsten Form als Parameter nur eine URL und gibt den HTTP-Body der Antwort aus. Mit `-I` bekommen Sie alternativ den Header angezeigt.

```shell
curl wtfismyip.com/json
curl -I www.htw-berlin.de
```

{% asciicast 18874 %}

Auf den Rechnern der HTW ist teilweise [Wget](https://www.gnu.org/software/wget/) statt cURL installiert. Die Syntax ist ähnlich, cURL schreibt das Ergebnis einer Anfrage jedoch in die Standardausgabe, wohingegen Wget sie unter dem angefragten Dateinamen speichert. Mit `-qO-` können Sie den Datenstrom zur Standardausgabe umlenken.[^wget]

```shell
wget beier.f4.htw-berlin.de/icon.png
ls -hl | grep icon
wget -qO- wtfismyip.com/json
```

{% asciicast 18875 %}

Alternativ können Sie auch das hübschere [HTTPie](https://github.com/jkbr/httpie) verwenden.

Steuern Sie mit einem der Tools die im Link enthaltene URL an.

Um den gewünschten Token zu erhalten, sollen zwei Parameter übergeben werden. Für HTTP-GET können diese einfach als Key-Value-Paar der URL angehängt werden. Versuchen Sie es.
<small>("file.php", "param1" etc sind Beispiele, nicht die Lösung.)</small>

```shell
# Wget
wget -qO- "file.php?param1=value&param2=value"
# cURL
curl "file.php?param1=value&param2=value"
# HTTPie
http file.php param1==value param2==value
```

Der Token-Generator möchte mit `POST` angesprochen werden. Anders als bei `GET` werden die Daten hier im HTTP-Body mitgeschickt (statt als Teil der URL). Die Struktur der Befehle sieht wie folgt aus:

```shell
# Wget
wget -qO- --post-data "param1=value&param2=value" file.php
# cURL
curl --data "param1=value&param2=value" file.php
# HTTPie
http -f POST file.php param1=value param2=value
```

Die Antwort wird den Token enthalten, der aus Ihrer Matrikelnummer (_s0543210_) und dem Namen Ihres Repos (_Webtech_ o.ä.) erzeugt wurde.

Speichern Sie diesen in der Datei "token.txt", legen Sie diese in das Verzeichnis "1. Aufgabe" in Ihrem Repo und committen (und pushen) Sie alles.

Das war's.


## Bewertung

Zum Abgabetermin werde ich alle Repos clonen, auf die ich Zugriff habe, nach der Token-Datei suchen und den Inhalt mit dem Soll-Token vergleichen. Klappt und stimmt alles, ist die Aufgabe bestanden.


## Wer mehr wissen möchte

* [Die Sendung mit der Maus - Wie funktioniert das Internet](https://www.youtube.com/watch?v=8PNRrOGJqUI)
* [YouTube: The Web Is Not The Net](https://www.youtube.com/watch?v=scWj1BMRHUA)
* [What every web developer must know about URL encoding](http://blog.lunatech.com/2009/02/03/what-every-web-developer-must-know-about-url-encoding)
* [IP, TCP, and HTTP](http://www.objc.io/issue-10/ip-tcp-http.html)
* [HTTP 2.0](http://en.wikipedia.org/wiki/HTTP_2.0) / [SPDY](http://en.wikipedia.org/wiki/SPDY)


---

[^shell]: Windowsnutzer können [cygwin](http://cygwin.com/) verwenden und finden alle weiteren Tools im Package Manager.

[^netcat]: Unabhängig von dieser Aufgabe können Sie netcat auch als sehr einfachen Webserver benutzen:

```shell
while true; do { echo -e "HTTP/1.1 200 OK\r\n"; cat index.html; } | nc -l 8080; done
```

Mit `-e` interpretiert `echo` Zeilenumbrüche und `-l` versetzt netcat in den "Listen"-Mode; die Zahl dahinter gibt den Port an.

Wenn Sie [`localhost:8080`](http://localhost:8080) mit einem beliebigen Browser ansteuern, sehen Sie in der Shell, wie dieser HTTP spricht.

Genauso leicht lassen sich auch Dateien zwischen zwei Rechnern austauschen:

```shell
# Sender
cat klausur.pdf | nc ip.des.empfängers 1234
# Empfänger
nc -l 1234 > klausur.pdf
```

[^wikipedia]:
Beispiel Wikipedia:

```shell
dig +short en.wikipedia.org
dig +short de.wikipedia.org
```

Beide haben die IP `91.198.174.192`.

```shell
nc 91.198.174.192 80

GET / HTTP/1.1
Host: en.wikipedia.org
# HTTP/1.1 301 Moved Permanently
# Location: http://en.wikipedia.org/wiki/Main_Page

GET / HTTP/1.1
Host: de.wikipedia.org
# HTTP/1.1 301 Moved Permanently
# Location: http://de.wikipedia.org/wiki/Wikipedia:Hauptseite
```

[^wget]: Wget kann noch ganz andere tolle Sachen – Sie mögen beispielsweise diese Seite und hätten sie gern offline verfügbar? Lade Sie sie komplett herunter per:

```shell
wget \
     --recursive \
     --no-clobber \
     --no-parent \
     --convert-links \
     --html-extension \
     --page-requisites \
     --restrict-file-names=windows \
     --domains beier.f4.htw-berlin.de \
       https://beier.f4.htw-berlin.de
```

Quelle: [Linux Journal](http://www.linuxjournal.com/content/downloading-entire-web-site-wget)
