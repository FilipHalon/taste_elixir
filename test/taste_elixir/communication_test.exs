defmodule TasteElixir.CommunicationTest do
  use TasteElixir.DataCase

  alias TasteElixir.Communication

  describe "messagesas" do
    alias TasteElixir.Communication.Message

    @valid_attrs %{author: "some author", content: "some content"}
    @update_attrs %{author: "some updated author", content: "some updated content"}
    @invalid_attrs %{author: nil, content: nil}

    def message_fixture(attrs \\ %{}) do
      {:ok, message} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Communication.create_message()

      message
    end

    test "list_messagesas/0 returns all messagesas" do
      message = message_fixture()
      assert Communication.list_messagesas() == [message]
    end

    test "get_message!/1 returns the message with given id" do
      message = message_fixture()
      assert Communication.get_message!(message.id) == message
    end

    test "create_message/1 with valid data creates a message" do
      assert {:ok, %Message{} = message} = Communication.create_message(@valid_attrs)
      assert message.author == "some author"
      assert message.content == "some content"
    end

    test "create_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Communication.create_message(@invalid_attrs)
    end

    test "update_message/2 with valid data updates the message" do
      message = message_fixture()
      assert {:ok, %Message{} = message} = Communication.update_message(message, @update_attrs)
      assert message.author == "some updated author"
      assert message.content == "some updated content"
    end

    test "update_message/2 with invalid data returns error changeset" do
      message = message_fixture()
      assert {:error, %Ecto.Changeset{}} = Communication.update_message(message, @invalid_attrs)
      assert message == Communication.get_message!(message.id)
    end

    test "delete_message/1 deletes the message" do
      message = message_fixture()
      assert {:ok, %Message{}} = Communication.delete_message(message)
      assert_raise Ecto.NoResultsError, fn -> Communication.get_message!(message.id) end
    end

    test "change_message/1 returns a message changeset" do
      message = message_fixture()
      assert %Ecto.Changeset{} = Communication.change_message(message)
    end
  end
end
