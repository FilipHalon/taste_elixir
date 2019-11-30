defmodule TasteElixirWeb.PageController do
  use TasteElixirWeb, :controller

  alias TasteElixir.Communication

  def index(conn, _params) do
    messages = Communication.list_messages
    render(conn, "index.html", messages: messages)
  end
end
