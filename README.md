# Basic Python/Django App

Faaala, velhinho, segue aqui um guia rápido sobre como configurar e rodar essa app:

### Setup

1. Baixe o [Docker](https://www.docker.com/get-started/) e instale
2. Execute o Docker build:
  ```bash
  docker-compose build
  ```
1. inicie o container:
  ```bash
  docker-compose up -d
  ```
1. Execute esse comando pra fazer o setup do Django com as migrations do BD e pra criar um usuário root pro  Django admin
  ```bash
  docker exec -it shell_app_django-app_1 ./bin/container_setup.sh
  ```
1. Agora já pode acessar a app em http://localhost:8000/
2. Pra acessar o admin vc vai em http://localhost:8000/admin/ e use essas credenciais:
    * User: root
    * Pass: admin


### Utilização
Se você quiser executar algum comando dentro do container:
```
docker exec -it shell_app_django-app_1 <comando-linux-aqui>
```

# Serviços neste projeto
| Service        | Port  | Name         | 
|-----------------|------|--------------|
| Django App      | 8000 | django-app   |
| Postgres Server | 5432 | postgres-app |

Caso você queira conectar aplicativos externos pra acessar o DB tipo o HeidiSQL por exemplo, vc pode usar as info:
```
host: localhost
port: 5432
user: postgres
pass: postgres
DB: app_db
```
