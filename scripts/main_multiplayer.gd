extends Control

const PORT:int = 42069

@onready var gm_usrnm: LineEdit = $Login/GM/GMVbox/GMUsrnm
@onready var player_usrnm: LineEdit = $Login/Player/PlayerVbox/PlayerUsrnm
@onready var ip_address: LineEdit = $Login/Player/PlayerVbox/IPAddress

@onready var login_win: HBoxContainer = $Login #The entire Login window
@onready var main_ui: Control = $MainUI
var username: String

signal user_joined(uname)

func _on_gm_login_pressed() -> void:
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(PORT)
	get_tree().set_multiplayer(SceneMultiplayer.new(), self.get_path())
	multiplayer.multiplayer_peer = peer
	joined(true)


func _on_player_login_pressed() -> void:
	var peer = ENetMultiplayerPeer.new()
	var IP_ADDRESS = ip_address.text
	peer.create_client(IP_ADDRESS, PORT)
	get_tree().set_multiplayer(SceneMultiplayer.new(), self.get_path())
	multiplayer.multiplayer_peer = peer
	joined(false)
	

func joined(is_GM:bool):
	if is_GM:
		username = gm_usrnm.text
	else:
		username = player_usrnm.text
	user_joined.emit(username)
	login_win.hide()
	main_ui.visible = true
