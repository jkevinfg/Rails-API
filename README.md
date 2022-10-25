##  TDD Ruby on Rails

API siguiendo el desarrollo guiado por pruebas (TDD).

### Diagrama relacional
![tdd-ruby](https://jkevinfg.com/img/projects/diagramabd.png)

#### Endpoints
```
GET /posts?search=title (optional query)
```
```
GET /posts/{id}
```
```
GET /posts/unpublished
```
```
POST /posts
```
```
PUT /posts/{id}
```
Gemas utilizadas:
* rspec (gem testing)
* factory bot (crear modelos falsos)
* faker (generar datos fake)
* letter_opener (visualizar mailer)

Adicionalmente implementé:
* ActiveJob (trabajo en segundo plano)
* ActiveMailer (enviar reporte)
* Caching (busqueda de un post)



