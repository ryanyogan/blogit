defmodule Blogit.UserSocket do
  use Phoenix.Socket

  channel "comments:*", Blogit.CommentChannel

  transport :websocket, Phoenix.Transports.WebSocket

  def connect(%{"token" => token}, socket) do
    case Phoenix.Token.verify(socket, "user", token, max_age: 1209600) do
      {:ok, user_id} ->
        {:ok, assign(socket, :user, user_id)}
      {:error, _reason} ->
        {:ok, socket}
    end
  end

  def id(_socket), do: nil
end
