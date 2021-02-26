defmodule RocketpayWeb.AccountsControllerTest do
  use RocketpayWeb.ConnCase, async: true

  alias Rocketpay.{Account, User}

  describe "deposit/2" do
    # Usuario existente no banco (criar usuario)
    setup %{conn: conn} do
      params = %{
        name: "Test",
        age: 19,
        email: "email@test.com",
        password: "123456",
        nickname: "testUser"
      }

      {:ok, %User{account: %Account{id: account_id}}} = Rocketpay.create_user(params)

      conn = put_req_header(conn, "authorization", "Basic dXNlcjp1c2Vy")

      # Tupla para devolver os valores (:ok obrigatirio), via chave valor
      {:ok, conn: conn, account_id: account_id}
    end

    test "when all params are valid, make a deposit", %{conn: conn, account_id: account_id} do
      params = %{"value" => "50.00"}

      response =
        conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, params)) # Monta a rota com parâmetros
        |> json_response(:ok)

      assert %{
                "account" => %{"balance" => "50.00", "id" => _id},
                "message" => "Ballance changed successfully"
              } = response
    end

    test "when there are invalid params, returns an error", %{conn: conn, account_id: account_id} do
      params = %{"value" => "invalid"}

      response =
        conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, params)) # Monta a rota com parâmetros
        |> json_response(:bad_request)

      expected_response = %{"message" => "Invalid deposit value"}

      assert response == expected_response
    end

    test "when all params are valid, make a withdraw", %{conn: conn, account_id: account_id} do
      params = %{"value" => "50.00"}

      response =
        conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, params))
        |> post(Routes.accounts_path(conn, :withdraw, account_id, params))
        |> json_response(:ok)

      assert %{
                "account" => %{"balance" => "0.00", "id" => _id},
                "message" => "Ballance changed successfully"
              } = response
    end
  end
end
