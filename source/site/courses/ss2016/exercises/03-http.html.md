# HTTP-Übung

In dieser Übung sollen Sie mittels zwei HTTP-Anfragen ein *secret* erfahren,
dieses in einem neuen Git-Repository als `secret.txt` speichern und via `git`
für die 2. Aufgabe zum Aris-Server hochladen.

| Abgabetermin | Punkte |
|-----------------------|
| 2016-04-26 23:59 CEST | 2 |
{: .table.table-bordered }


# Aufgabenstellung

1. Eine zweite App im Aris anlegen.
1. Secret erfahren
1. Secret als `secret.txt` via `git` auf den Aris-Server hochladen


## Secret erfahren

Um ihr persönliches *secret* zu erfahren brauchen Sie zunächst URL unter der dieses versteckt ist.

Das folgende Tutorial zeigt am Beispiel einer fiktiven App mit dem Namen `145-happy-banana`
wie Sie das secret herausfinden können.

Ersetzen Sie `145-happy-banana` durch Ihren eigenen App-Namen für die 2. Übung.


### URL erfahren

Ein GET-Request an die Adresse `http://htw-webtech-secret.herokuapp.com/{id-und-name-der-app}/door_name`. Für 145-happy-banana ergibt das folgenden Aufruf:

~~~
curl http://htw-webtech-secret.herokuapp.com/145-happy-banana/door_name
=> bae7bb
~~~
{: .lang-bash }

Diese Code `bae7bb` wird nun benutzt um mit einem weiteren PUT-Request das eigentliche secret zu erfahren:

~~~
curl -X PUT http://htw-webtech-secret.herokuapp.com/doors/bae7bb -d ''
=> Secret: 'e6f49b'
~~~
{: .lang-bash }


Das secret für die App ist also `e6f49b`.


### Secret auf Aris-Server hochladen

In einem neuen Git-Repistory soll nun für die 2. App im Aris eine `secret.txt`-Datei
mit dem secret als Inhalt hochgeladen werden.

Für das o.g. Beispiel könnte das so aussehen:

~~~
cd Aufgabe2
git init
echo "e6f49b" > secret.txt
…
~~~
{: .lang-bash }

Das wars schon. Um zu prüfen ob die `secret.txt` richtig hochgeladen wurde, kann
die Webseite der App geöffnet und der Dateipfad zur `/secret.txt` angehangen werden.

Für die App `145-happy-banana` ist das die URL <http://145-happy-banana.htw-webtech.com/secret.txt>

