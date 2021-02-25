# Rocketpay

Para iniciar o servidor Phoenix:

  * Instale as dependências com `mix deps.get`
  * Crie e execute as migrations com `mix ecto.setup`
  * Inicie o servidor Phoenix com `mix phx.server`

Agora você pode abrir [`localhost:4000`](http://localhost:4000) no seu navegador.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Aprenda mais

  * Site oficial: https://www.phoenixframework.org/
  * Guias: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix

## Docs

Acesse a pasta [docs] para ver as anotações das aulas.

- [01](docs/01.md)
- [02](docs/02.md)
- [03](docs/03.md)
- [04](docs/04.md)

## Rotas

- `POST api/users` - Criar novo usuário
- `POST api/account/:id/deposit` - Fazer um depósito na conta
- `POST api/account/:id/deposit` - Fazer um depósito na conta
- `POST api/account/transaction` - Fazer uma transferência

## Exemplos

### `POST api/users`

Corpo da requisição: 
``` json
  {
    "name": "Pedro",
    "age": 19,
    "email": "mnopedrodias@outlook.com",
    "password": "123456",
    "nickname": "pedrofigueiredo"
  }
```

Resposta:
``` json
  {
    "message": "User created",
    "user": {
      "account": {
        "balance": "0.00",
        "id": "d5f169f9-0493-46dc-b708-564bdcb1fee5"
      },
      "id": "8ddaea16-c6ca-48f5-bd03-9e96c910f52d",
      "name": "Pedro",
      "nickname": "pedrofigueiredo"
    }
  }
```

### `POST api/account/:id/deposit`

Requisição: `POST api/accounts/d5f169f9-0493-46dc-b708-564bdcb1fee5/deposit`

Corpo da requisição: 
``` json
  {
    "value": "50"
  }
```

Resposta:
``` json
  {
    "account": {
      "balance": "165.00",
      "id": "d5f169f9-0493-46dc-b708-564bdcb1fee5"
    },
    "message": "Ballance changed successfully"
  }
```

### `POST api/account/:id/withdraw`

Requisição: `POST api/accounts/d5f169f9-0493-46dc-b708-564bdcb1fee5/withdraw`

Corpo da requisição: 
``` json
  {
    "value": "1"
  }
```

Resposta:
``` json
  {
    "account": {
      "balance": "177.00",
      "id": "d5f169f9-0493-46dc-b708-564bdcb1fee5"
    },
    "message": "Ballance changed successfully"
  }
```

### `POST api/account/transaction`

Corpo da requisição: 
``` json
  {
    "value": "2",
    "from": "d5f169f9-0493-46dc-b708-564bdcb1fee5",
    "to": "ecd5ba49-1b55-4ad4-9635-7fb62d769633"
  }
```

Resposta:
``` json
  {
    "message": "Transaction done successfully",
    "transaction": {
      "from_account": {
        "balance": "177.00",
        "id": "d5f169f9-0493-46dc-b708-564bdcb1fee5"
      },
      "to_account": {
        "balance": "72.00",
        "id": "ecd5ba49-1b55-4ad4-9635-7fb62d769633"
      }
    }
  }
```