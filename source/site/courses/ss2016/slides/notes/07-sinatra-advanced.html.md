---

# Sinatra Status Codes

~~~
# myapp.rb
require 'sinatra/base' # Lädt den sinatra ruby code

class MyApp < Sinatra::Base
  get '/' do             # Definiert ein GET an `/`, also root
    'Hello world!'       # => Gibt als String 'Hello World' zurück.
  end                    # Der Status-Code ist implizit 200

  get '/secret' do       # Definiert ein GET an `/secret`
    status 403           # [HTTP Status Code 403: Forbidden](http://httpstatuses.com/403)
  end                    # Der Response-Body bleibt leer, da der Zugriff verboten wurde: 403

  get '/google' do                    # Definiert ein GET an `/google`
    redirect 'http://www.google.com/' # Erzeugt einen 302 Redirect zur Google-Startseite
  end
  run! if app_file == $0 # Startet die App, wenn das Skript direkt aufgerufen wurde
end
~~~
{: .lang-ruby }


# ERB: Schleifen

~~~
# Sinatra Code
get '/tasks.html' do
  @tasks = ["Clean dishes", "Take trash out", "Relax"]
  erb :tasks
end
~~~
{: .lang-ruby }

~~~
<!-- Template: views/tasks.erb -->
<body>
  <ol>
    <%- @tasks.each do |task| %>
      <li><%= task %></li>
    <%- end %>
  </ol>
</body>
~~~
{: .lang-html }

~~~
<!-- Ergebnis im Browser -->
<body>
  <ol>
    <li>Clean dishes</li>
    <li>Take trash out</li>
    <li>Relax</li>
  </ol>
</body>
~~~
{: .lang-html }

