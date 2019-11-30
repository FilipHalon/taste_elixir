defmodule TasteElixir.Accounts.User do
  # Ecto = db
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :age, :integer
    field :name, :string
    field :email, :string
    field :hashed_password, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    # niepodane pola nie będą mogły być modyfikowane
    |> cast(attrs, [:name, :age, :email])
    # wymagane - muszą być podane i nie mogą być null
    |> validate_required([:name, :age])
  end
end
