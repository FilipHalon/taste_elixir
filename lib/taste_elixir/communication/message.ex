defmodule TasteElixir.Communication.Message do
  use Ecto.Schema
  import Ecto.Changeset

  # Jason - nazwa biblioteki
  @derive {Jason.Encoder, only: [:author, :content]}
  schema "messagesas" do
    field :author, :string
    field :content, :string

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:author, :content])
    |> validate_required([:author, :content])
  end
end
