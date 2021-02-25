defmodule Rocketpay.User do
  # Traz as funcionalidades do Ecto para esse módulo
  use Ecto.Schema
  import Ecto.Changeset

  alias Ecto.Changeset
  alias Rocketpay.Account

  # @primary_key -> variável do módulo para o id do tipo UUID
  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:name, :age, :email, :password, :nickname]

  schema "users" do
    field :name, :string
    field :age, :integer
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :nickname, :string
    has_one :account, Account

    timestamps()
  end

  # Validar e mapear (cast para a tabela) dados
  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:password, min: 6)
    |> validate_number(:age, greater_than_or_equal_to: 18)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:email])
    |> unique_constraint([:nickname])
    |> put_password_hash()
  end

  defp put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    # Func change() -> recebe um changeset e altera
    change(changeset, Bcrypt.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end
