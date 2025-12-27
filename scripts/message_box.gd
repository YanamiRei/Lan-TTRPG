extends VBoxContainer

@onready var messages: TextEdit = $Messages
@onready var message: TextEdit = $Message
@onready var username: String



func _on_send_pressed() -> void:
	rpc("msg_rpc", username, message.text, false)
	
func _on_main_user_joined(uname: Variant) -> void:
	username = uname
	rpc("msg_rpc", uname, str(uname, " has joined the party!"), true)


@rpc("any_peer","call_local")
func msg_rpc(uname,data, is_server_message):
	print_debug("sup")
	if not is_server_message:
		messages.text += str(uname, ": ", data, "\n")
		messages.scroll_vertical = INF
		message.text = ""
	else:
		messages.text += str(data, "\n")
		messages.scroll_vertical = INF
