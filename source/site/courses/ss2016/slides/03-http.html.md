# HTTP

Hypertext Transfer Protocol

---

# Agenda

* HTTP und das Web
* Ein Request <-> Response Beispiel
* URI, DNS, TCP/IP
* HTTP Verben
* Status Codes
* HTTP Header
* Features:
  * Caching
  * Auth
  * Cookies
* Dev Tools
* HTTP Historie

---

# HTTP <-> Web

* HTTP ist Lingua Franca des Webs
* Client/Server Kommunikation
* Request/Response Nachrichtenpaar
* Zustandslos
* Kommunikation über TCP Port 80/443
  * Port 80: HTTP
  * Port 443: HTTPs
* 90% Use Case: Browser fordert Webseite/Dokument an

*[HTTP]: Hypertext Transfer Protocol

---

# Beispiel

![Request Response](slides/http/request-response.png)

---

# Ablauf

* Browser möchte http://google.com laden
* google.com wird via DNS zur IPv4 oder IPv6 aufgelöst
* TCP-Verbindung auf Port 80 wird geöffnet
* Browser sendet ASCII den GET-Request als ASCII Byte-Stream
* Server nimmt GET-Request entgegen und erzeugt Response

---

# GET Request

~~~
GET / HTTP/1.1
Host: google.com
Accept: text/html,application/xml;q=0.9,*/*;q=0.8
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.110 Safari/537.36
Accept-Language: en,de;q=0.8,en-US;q=0.6
~~~
{: .lang-http }

* *GET /* Ich möchte das root-Dokument
* *HTTP/1.1* Ich spreche HTTP 1.1
* *Host google.com* Hiermit können verschiedene Hosts pro IP angesprochen werden
* *Accept* Wenn es mehrere Formate gibt, habe ich diese Prioritäten: HTML > XML > *
* *User-Agent* Verrät Euer OS (+Version), Browser (+Version) und ggf. Tablet/Smartphone
* *Accept-Language* Wenn es verschiedene Sprachen verfügbar sind: En > De

---

# GET Response

~~~
HTTP/1.1 200 OK
Content-Type: text/html; charset=utf-8
Content-Length: 500
Content-Encoding: gzip

<!doctype html>
<html>
…
</html>
~~~
{: .lang-http }

* *HTTP/1.1* Ich spreche HTTP 1.1
* *200* OK - Standard Code wenn Dokument erfolgreich ausgeliefert wird
* *Content-Type* Beschreibt den Typ
* *Content-Length* Größe des Dokuments in Bytes
* *Content-Encoding* Der Dokument-Inhalt ist komprimiert ([GNU zip](https://tools.ietf.org/html/rfc1952))

---

# URL

URLs are used to locate resources, by providing an abstract identification of the resource location.
[RFC 1738](https://www.ietf.org/rfc/rfc1738.txt)

~~~
scheme:[//[user:password@]host[:port]][/]path[?query][#fragment]
~~~
{: .lang-bash }

## Beispiele

* http://www.example.com/
* mailto:alice@foo.com
* https://lsf.htw-berlin.de/qisserver/rds?state=user&type=0

---

# URL Bestandteile

| Teil | Zweck | Beispiele |
|--------------------------|
| Scheme | Protokoll | `https`, `mailto`
| Authority |  Authentifizierung | `user:password`
| Host | Domain/IP | `google.com`
| Port | TCP-Port | `:8080`
| Path | FS Struktur | `/services/seo-consulting.html`
| Query | Key-Value Param | `?session_id=123`
| Fragment | Bereich im Dokument | `#chapter4`

*[FS]: Filesystem oder Dateisystem

---

# DNS

Das Domain Name System ist ein hierarchisches dezentrales Adressbuch.

* Assoziation von verschiedenen Informationen mit Domains
* Bspw. IP-Adressen, aber auch SMTP Server, reverse Domain lookups
* UDP Port 53
* Massive Implikationen auf Security und Performance einer Web-Applikation
* UNIX-Kommando `dig` bietet einfachen Lesezugriff auf DNS-Einträge

---

# DNS Beispiel

~~~
dig +short google.com
216.58.201.206

dig +short amazon.com
54.239.25.208
54.239.26.128
54.239.17.6
54.239.17.7
54.239.25.192
54.239.25.200
~~~
{: .lang-bash }

* Weiter mit HTTP-Operationen (Verben)

---

# HTTP Operationen (Verben)

95%* der HTTP-Operationen sind Lesezugriffe (GET Requests).

| Methode | Bedeutung |
|---------|------------
| GET | Ressource anfragen
| POST | Ressource erstellen/überschreiben
| DELETE | Ressource löschen
| PUT | Ressource erstellen/ändern
| PATCH | Verändert eine Ressource
| HEAD, OPTIONS, … | Weniger von Bedeutung…

---

# HTTP POST Beispiel

Absenden eines HTML-Formulars zur Anmeldung beim LSF.

~~~
POST /qisserver/rds?state=user&type=1 HTTP/1.1
Host: lsf.htw-berlin.de

username=s*****&password=*******&submit=Jetzt+einloggen
~~~
{: .lang-http }

---

# HTTP: POST, PUT, PATCH?

| POST | Ressource erstellen/überschreiben
| PUT | Ressource erstellen/ändern
| PATCH | Verändert eine Ressource

## Unterschiede

* Idempotenz: Mehrfaches Ausführen einer Operation bleibt ohne Effekte
* PUT: Ist idempontent
* PATCH: Partielle Änderungen
* POST: Nicht [idempontent](http://www.infoq.com/news/2013/04/idempotent)
  * Erneutes versenden eines Formulars erzeugt neue Bestellung

---

# HTTP Status Codes

Dreistelliger Code zur Status-Beschreibung eines HTTP Requests.

| Code | Gruppe
|---------|------------
| 1xx | Informational
| 2xx | Success
| 3xx | Redirection
| 4xx | Client Error
| 5xx | Server Error

---

# Gängige Status Codes

| Code | Bedeutung
|------|------------
| 101 | Switching Protocol
| 200 | Ressource gefunden
| 201 | Ressource wurde erstellt
| 301 | Permanente Adressänderung
| 404 | Ressource existiert nicht
| 504 | Gateway timeout

Eine [umfassende Liste](https://httpstatuses.com/) von HTTP Status Codes

---

# HTTP Header

* Request und Response
* Meta-Informationen zur Operation, bspw. Sprache, Format, Auth, Caching
* Format: `name-des-headers: wert`
  * Laut Spezifikation dürfen beliebige Header mit einem `X-` hinzugefügt werden
* Teils komplementär teils substitive Features
* [Liste](https://en.wikipedia.org/wiki/List_of_HTTP_header_fields) von HTTP Headern

---

# HTTP Caching

Client-seitiges Caching via `Last-Modified`- und `If-Modified-Since`-Header.

~~~
GET /website.html HTTP/1.1
Host: developer.mozilla.org
…
~~~
{: .lang-http }

~~~
HTTP/1.1 200 OK

Host: developer.mozilla.org
Last-Modified: Wed, 15 Nov 2015 04:58:08 GMT

<!doctype html>
…
~~~
{: .lang-http }

~~~
GET /website.html HTTP/1.1
Host: developer.mozilla.org
If-Modified-Since: Wed, 15 Nov 2015 04:58:08 GMT
~~~
{: .lang-http }

~~~
HTTP/1.1 304 Not Modified

Host: developer.mozilla.org
Last-Modified: Wed, 15 Nov 2015 04:58:08 GMT
~~~
{: .lang-http }

---

# HTTP Auth

[Basic Authentication](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basic_access_authentication): Simpler *Klartext*-Passwortschutz einer Ressource

~~~
GET /website.html HTTP/1.1
Host: developer.mozilla.org
…
~~~
{: .lang-http }

~~~
HTTP/1.1 401 Unauthorized

Host: developer.mozilla.org
WWW-Authenticate: Basic
~~~
{: .lang-http }

~~~
GET /website.html HTTP/1.1
Host: developer.mozilla.org
Authorization: Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==
~~~
{: .lang-http }

~~~
HTTP/1.1 200 OK

Host: developer.mozilla.org
…

<!doctype html>
…
</html>
~~~
{: .lang-http }

---

# HTTP Cookies

[State](https://developer.mozilla.org/en-US/docs/Web/HTTP/Cookies) für HTTP Requests

* HTTP ist zustandslos => keine Nutzersitzung
* Cookies: Client-seitiger Storage für verschiedene Zwecke
  * Identifizierung von Nutzern (Sessions)
  * Speichern von (sensiblen) Daten beim Nutzer (Personalisierung)
  * Tracking (Beobachtung von Nutzerverhalten)
* Mehrfach überarbeitet aufgrund Sicherheitsrisiken

---

# HTTP Cookies Beispiel

~~~
GET /qisserver/rds?state=user&type=0 HTTP/1.1
Host: lsf.htw-berlin.de
…
~~~
{: .lang-http }

~~~
HTTP/1.1 200 OK
Date: Wed, 20 Apr 2016 11:40:16 GMT
Set-Cookie: JSESSIONID=EC008CA524686D897C0DB00B1C575.ajp13_qis1; Path=/qisserver; HttpOnly; Secure
…

<!doctype html>
…
~~~
{: .lang-http }

~~~
GET /qisserver/rds?state=user&type=0 HTTP/1.1
Host: lsf.htw-berlin.de
Cookie: JSESSIONID=EC008CA524686D897C0DB00B1C575.ajp13_qis1
~~~
{: .lang-http }

---

# HTTP im Browser

* Google: Dev Tools
* Firefox: Dev Tools (ehem. Firebug?)
* Beispiele:
  * Login im LSF
  * Aufruf von

---

# HTTP Historie

* 1996: HTTP/1.0 [RFC 1945](https://tools.ietf.org/html/rfc1945)
* 1997: HTTP/1.1 [RFC 2068](https://tools.ietf.org/html/rfc2068)
* 1999: HTTP/1.1 improvements [RFC 2616](https://tools.ietf.org/html/rfc2616)
* 2007: Update on HTTP/1.1: [RFC 7230](https://tools.ietf.org/html/rfc7230), [RFC 7231](https://tools.ietf.org/html/rfc7231), [RFC 7232](https://tools.ietf.org/html/rfc7232), [RFC 7233](https://tools.ietf.org/html/rfc7233), [RFC 7234](https://tools.ietf.org/html/rfc7234), [RFC 7235](https://tools.ietf.org/html/rfc7235)
* 2015: HTTP/2 [RFC 7540](https://tools.ietf.org/html/rfc7540)

---

# Ressourcen

* http://cursor-education.github.io/web-request-response-webinar/
* https://developer.mozilla.org/en-US/docs/Web/HTTP
* https://beier.f4.htw-berlin.de/presentations/http/
