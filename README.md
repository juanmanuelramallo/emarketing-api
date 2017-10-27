# eMarketing - API

### Primeros pasos 🐾

Para correr esta app se requiere:

- Tener instalado Ruby y Rails
- Ejecutar `bundle install`
- Correr aplicación con `rails s`

O bien se puede correr con **docker**:

- Ejecutar `docker-compose up`
- Luego para crear la base de datos y cargarle datos de prueba ejecutar `docker-compose run web rails db:create db:migrate db:seed`

Dependencias:

- PostgreSQL
- Ruby 2.3.1
- Rails 5.1.4

### Acerca de la autenticación

* Cada usuario tiene un contraseña
* Cuando el usuario inicia sesión con su email y contraseña, lo que hace es pedir un token a la aplicación
* Luego cada pedido que el usuario haga deberá hacerlo con su token
* El token es válido durante una hora desde que se asignó

### Rutas 🛣
Verbo  |URL
-------|------------------------------
POST   |/user_token(.:format)
GET    |/v1/campaigns(.:format)
POST   |/v1/campaigns(.:format)
GET    |/v1/campaigns/:id(.:format)
PATCH  |/v1/campaigns/:id(.:format)
PUT    |/v1/campaigns/:id(.:format)
DELETE |/v1/campaigns/:id(.:format)
GET    |/v1/contacts/search(.:format)
GET    |/v1/contacts(.:format)
POST   |/v1/contacts(.:format)
GET    |/v1/contacts/:id(.:format)
PATCH  |/v1/contacts/:id(.:format)
PUT    |/v1/contacts/:id(.:format)
DELETE |/v1/contacts/:id(.:format)
GET    |/v1/tags(.:format)
POST   |/v1/tags(.:format)
GET    |/v1/tags/:id(.:format)
PATCH  |/v1/tags/:id(.:format)
PUT    |/v1/tags/:id(.:format)
DELETE |/v1/tags/:id(.:format)

----
Juan Manuel Ramallo
