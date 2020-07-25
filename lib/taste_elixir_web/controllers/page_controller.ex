defmodule TasteElixirWeb.PageController do
  use TasteElixirWeb, :controller

  alias TasteElixir.Communication

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
