defmodule DistributedPhoenixChatWeb.RoomChannel do
  use Phoenix.Channel

  def join("room:" <> _room_id, _payload, socket) do
    {:ok, socket}
  end

  def handle_in("new_msg", %{"uid" => uid, "body" => body}, socket) do
    broadcast!(socket, "new_msg", %{uid: uid, body: body})
    {:reply, :ok, socket}
  end

  # client asks for their current user_id, push sent directly as a new event.
  def handle_in("current_user_id", _, socket) do
    push(socket, "current_user_id", %{user_id: socket.assigns.user_id})
    {:noreply, socket}
  end

  # intercept ["new_msg", "user_joined"]

  # for every socket subscribing to this topic, append an `is_editable`
  # value for client metadata.
  # def handle_out("new_msg", msg, socket) do
  #   updated_message = Map.merge(
  #     msg,
  #     %{is_editable: User.can_edit_message?(socket.assigns.user_id, msg)}
  #   )
  #   push(socket, "new_msg", updated_message)

  #   {:noreply, socket}
  # end

  # do not send broadcasted `"user_joined"` events if this socket's user
  # is ignoring the user who joined.
  # def handle_out("user_joined", msg, socket) do
  #   unless User.ignoring?(socket.assigns.user_id, msg.user_id) do
  #     push(socket, "user_joined", msg)
  #   end

  #   {:noreply, socket}
  # end
end
