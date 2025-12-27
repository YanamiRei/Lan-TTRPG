extends Control

const PORT:int = 42069
const IP_ADDRESS: String = "localhost"

@onready var host_btn = $HostButton
@onready var join_btn = $JoinButton
@onready var usrnm = $Username
@onready var send = $Send
@onready var message = $Message
@onready var messages = $Messages

var username: String

var msg: String


func _on_host_button_pressed() -> void:
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(PORT)
	get_tree().set_multiplayer(SceneMultiplayer.new(), self.get_path())
	multiplayer.multiplayer_peer = peer
	joined()


func _on_join_button_pressed() -> void:
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(IP_ADDRESS, PORT)
	get_tree().set_multiplayer(SceneMultiplayer.new(), self.get_path())
	multiplayer.multiplayer_peer = peer
	joined()



func _on_send_pressed() -> void:
	rpc("msg_rpc", MainMultiplayer.username, message.text)

@rpc("any_peer","call_local")

func msg_rpc(uname, data):
	messages.text += str(uname, ": ", data, "\n")
	messages.scroll_vertical = INF
	message.text = ""

func joined():
	host_btn.hide()
	join_btn.hide()
	usrnm.hide()
	username = usrnm.text
