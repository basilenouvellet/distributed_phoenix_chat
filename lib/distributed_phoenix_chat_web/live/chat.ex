defmodule DistributedPhoenixChatWeb.Live.Chat do
  @moduledoc """
  Main module, contains the entry point for the live view socket
  """

  use Phoenix.LiveView

  alias DistributedPhoenixChatWeb.{Endpoint, PageView}

  @tick_interval 3000

  def render(assigns) do
    PageView.render("index.html", assigns)
  end

  defp initial_state(),
    do: %{
      messages: [],
      input_value: ""
    }

  def mount(_session, socket) do
    socket =
      socket
      |> assign(initial_state())

    if connected?(socket) do
      {:ok, schedule_tick(socket)}
    else
      {:ok, socket}
    end
  end

  def schedule_tick(socket) do
    Process.send_after(self(), :tick, @tick_interval)
    socket
  end

  def handle_info(:tick, socket) do
    new_socket =
      socket
      |> add_message("### TICK ###")
      |> schedule_tick()

    {:noreply, new_socket}
  end

  def handle_event("new:msg", %{"message" => message} = payload, socket) do
    Endpoint.broadcast!("room:123", "new:msg", payload)

    {:noreply,
     socket
     |> add_message(message)}
  end

  defp add_message(socket, text) do
    new_messages = socket.assigns.messages ++ [%{body: text}]

    socket
    |> assign(:messages, new_messages)
  end
end
