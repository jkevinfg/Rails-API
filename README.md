##  TDD Ruby on Rails

### Iniciar el proyecto
```
- rake db:create
- rake db:migrate
- rake db:seed 
- rails server
```
#### Diagrama relacional
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
* Caching (busqueda de un post)
* ActiveJob (trabajo en segundo plano)
* ActiveMailer (enviar reporte)
```
#prueba 
PostReportMailer.post_report(User.first, Post.first, PostReport.generate(Post.first)).deliver_now
```



