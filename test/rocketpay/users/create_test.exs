defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase, async: true

  alias Rocketpay.User
  alias Rocketpay.Users.Create

  describe "call/1" do
    test "when all params are valid, return an user" do
      params = %{
        name: "Test",
        age: 19,
        email: "email@test.com",
        password: "123456",
        nickname: "testUser"
      }

      # Executa a função criar e, por pattern matchin recebe o id desse usuário (chamando de user_id)
      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)

      assert %User{
        name: "Test",
        age: 19,
        id: ^user_id
      } = user
    end

    test "when there are invalid params, return an error" do
      params = %{
        name: "Test",
        age: 15,
        email: "email@test.com",
        nickname: "testUser"
      }

      # Executa a função criar e, por pattern matchin recebe o id desse usuário (chamando de user_id)
      {:error, changeset} = Create.call(params)

      assert %{
        age: ["must be greater than or equal to 18"],
        password: ["can't be blank"]
      }
      == errors_on(changeset)
    end
  end
end
