IOT App
=======

IOT GUIs for Power and GPS.

Framework
---------
Sinatra (module style, with config.ru)

Needs
-----
public directory: public

needs a database  /Uses activerecord and rake/
In production $DATABASE_URL environment variable will be read as the database

Rake tasks
----------
bundle exec rake db:migrate
bundle exec rake db:seed

config.ru
---------
require_relative 'v0/module'  
map('/') { run V0 }  

Environment
-----------
**Required**  
session_secret: ENV['SECRET_KEY_BASE']
user_name: ENV['USER_NAME']
user_password: ENV['USER_PASSWORD']
app_mode: ENV['APP_MODE'] can be 'map' or 'power'
