defmodule TasteElixirWeb.GeneralChannel do
  use TasteElixirWeb, :channel

  # to pozwala nam pisać tylko w Communication w reszcie pliku - bierze nazwę po ostatniej kropce
  alias TasteElixir.Communication
  # można też importować, ale to importuje wszystkie publiczne funkcje

  # musimy mieć tą funkcję, bo router jej oczekuje; payload to jak params, a socket to jak con
  def join("general:lobby", payload, socket) do
    if authorized?(payload) do
      # te atomy :ok i :error to konwencja, ale akurat tutaj framework tego oczekuje
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  # moglibyśmy mieć też inne hadle in, ale muszą zaczynać się od :reply i :noreply
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  def handle_in("fetch:all", %{"search" => search}, socket) do
    messages = Communication.list_messages(search)
    {:reply, {:ok, %{messages: messages}}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (general:lobby).
  # broadcast wysyła do wszystkich połączonych z serwerem
  # tym samym chcemy wyciągnąć z payload name i message - payload to obiekt, jaki dostaniemy z JS-a
  # powinny być klucze-atomy, ale idą one z front-end, na którym nie ma siła rzeczy atomów, więc klucze należy podać jako stringi
  def handle_in("shout", %{"name" => name, "message" => message} = payload, socket) do
    # przechowywanie zmiennych pod danymi kluczami
    Communication.create_message(%{author: name, content: message}) |> IO.inspect
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
