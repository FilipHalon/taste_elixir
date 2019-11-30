defmodule TasteElixir.Repo.Migrations.CreateMessagesas do
  use Ecto.Migration

  def change do
    create table(:messagesas) do
      add :author, :string
      add :content, :string

      timestamps()
    end

  end
end
