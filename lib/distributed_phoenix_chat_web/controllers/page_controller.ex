defmodule DistributedPhoenixChatWeb.PageController do
  use DistributedPhoenixChatWeb, :controller

  alias Phoenix.LiveView
  alias DistributedPhoenixChatWeb.Live.Chat

  def index(conn, _) do
    # opts = [
    # session: %{cookies: conn.cookies}
    # ]

    # LiveView.Controller.live_render(conn, Chat, opts)
    LiveView.Controller.live_render(conn, Chat)
  end
end
