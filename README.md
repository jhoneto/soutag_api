# README

## Getting Started

Install Ruby 3.4.1 and Bundler.

Create database and run migrations.

```
bundle install
bundle exec rails db:create
bundle exec rails db:migrate
```

Create a environment file. Copy the `.env.example` file and rename it to `.env`.

Generate a secret key.

```
bundle exec rails secret
```

Change the `DEVISE_JWT_SECRET_KEY` value in the `.env` file to the generated secret key.

Run the server.

```
bundle exec rails server
```

## Seeding

Create a user and a gas station.

```
bin/rails db:seed
```

## Testing

Run tests.

```
bundle exec rspec
```

## API Documentation

### Users

LOGIN

```
curl --location 'http://localhost:3000/auth/sign_in' \
--header 'Content-Type: application/json' \
--data-raw '{
    "user": {
        "email": "john@example.com",
        "password": "password"
    }
}'
```

GET

```
curl --location 'http://localhost:3000/users/1' \
--header 'authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiIzN2E5ZjgwZi04ZTU4LTRiZGMtOWYzMC0wNDlhOWFjY2M0ZTUiLCJzdWIiOiIxIiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNzQ2NzM0NzU1LCJleHAiOjE3NDY4MjExNTV9.NZqRfTRTHjH9TXZRujWBbnmI_WLywxApgbrVr5yDF6k'
```

### Gas Stations

GET ALL

```
curl --location 'http://localhost:3000/gas_stations' \
--header 'authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiIzN2E5ZjgwZi04ZTU4LTRiZGMtOWYzMC0wNDlhOWFjY2M0ZTUiLCJzdWIiOiIxIiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNzQ2NzM0NzU1LCJleHAiOjE3NDY4MjExNTV9.NZqRfTRTHjH9TXZRujWBbnmI_WLywxApgbrVr5yDF6k'
```

### Refuelings

CREATE

```
curl --location 'http://localhost:3000/refuelings' \
--header 'Content-Type: application/json' \
--header 'authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiIzN2E5ZjgwZi04ZTU4LTRiZGMtOWYzMC0wNDlhOWFjY2M0ZTUiLCJzdWIiOiIxIiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNzQ2NzM0NzU1LCJleHAiOjE3NDY4MjExNTV9.NZqRfTRTHjH9TXZRujWBbnmI_WLywxApgbrVr5yDF6k' \
--data '{
    "refueling": {
        "user_id": 1,
        "gas_station_id": 1,
        "liters": 10
    }
}'
```

## TODO

- Use Pagy to paginate Gas Stations and Refuelings

## Considerações

Fiz a API com autenticação JWT usando o Devise. Caso não seja necessário precisa apenas remover o before_action :authenticate_user! do application_controller.rb.

O cadastro de usuário está completo, a rota para criação de um novo usuário não precisa de autenticação. As demais rotas sim.

Documentei, com exemplos, apenas as rotas sugeridas na documentação.

Sobre a pasta `services`, criei um service result para padronizar a resposta de todos os services. O service result possui um método `success?` que retorna true se o service for bem sucedido, e um método `failure?` que retorna true se o service falhar. Além disso, o service result possui um método `error` que retorna a mensagem de erro caso o service falhe.
