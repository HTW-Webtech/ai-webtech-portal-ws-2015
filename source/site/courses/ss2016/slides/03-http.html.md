<!---
Notes:
https://developer.mozilla.org/en-US/docs/Web/HTTP
http://cursor-education.github.io/web-request-response-webinar/
https://beier.f4.htw-berlin.de/presentations/http/
-->

# HTTP

Hypertext Transfer Protocol

---

# Agenda

* HTTP und das Web
* Ein Request <-> Response Beispiel
* HTTP, DNS, TCP/IP
* HTTP Verben
* Status Codes
* HTTP Header
* Features:
  * Auth
  * Cookies
  * Caching
  * Pipelining
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

*[HTTP]: Hypertext Transfer Protocol

---

# Beispiel

![Request Response](slides/http/request-response.png)

<!--- ~~~ --->
<!--- GET / HTTP/1.1 --->
<!--- Host: google.com --->
<!--- Accept: text/html --->
<!--- ~~~ --->
<!--- {: .lang-http } --->
<!---  --->
<!---  --->
<!--- ~~~ --->
<!--- HTTP/1.1 200 OK --->
<!--- Content-Type: text/html; charset=utf-8 --->
<!--- Content-Length: 500 --->
<!--- Content-Encoding: gzip --->
<!--- Host: google.com --->
<!--- Accept: text/html --->
<!---  --->
<!--- <!doctype html> --->
<!--- <body> --->
<!--- … --->
<!--- </html> --->
<!--- ~~~ --->
<!--- {: .lang-http } --->

---

# HTTP Historie

* 1996: HTTP/1.0 [RFC 1945](https://tools.ietf.org/html/rfc1945)
* 1997: HTTP/1.1 [RFC 2068](https://tools.ietf.org/html/rfc2068)
* 1999: HTTP/1.1 improvements [RFC 2616](https://tools.ietf.org/html/rfc2616)
* 2007: Update on HTTP/1.1: [RFC 7230](https://tools.ietf.org/html/rfc7230), [RFC 7231](https://tools.ietf.org/html/rfc7231), [RFC 7232](https://tools.ietf.org/html/rfc7232), [RFC 7233](https://tools.ietf.org/html/rfc7233), [RFC 7234](https://tools.ietf.org/html/rfc7234), [RFC 7235](https://tools.ietf.org/html/rfc7235)
* 2015: HTTP/2 [RFC 7540](https://tools.ietf.org/html/rfc7540)

---

# GET Request

~~~
GET / HTTP/1.1
Host: example.com
Connection: keep-alive
~~~
{: .lang-http }
