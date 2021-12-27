extends Node2D


# Private variables
var active: bool = false

# Onready variables
onready var player: PlayerScript = $Player
onready var player_camera: Camera2D = $Player/PlayerCamera
onready var wide_camera: Camera2D = $WideCamera
onready var map_pieces: YSort = $MapPieces


func _ready():
	self.toggle_map_pieces(false)


# Called when there is an input event
func _input(event: InputEvent):
	if event.is_action("pieces_mode") and event.is_pressed():
		if not self.active:
			self.wide_camera.make_current()
			self.player.input_enabled = false
			self.toggle_map_pieces(true)
			self.active = true
		else:
			self.player_camera.make_current()
			self.player.input_enabled = true
			self.toggle_map_pieces(false)
			self.active = false


func toggle_map_pieces(value: bool):
	for piece in self.map_pieces.get_children():
		piece.toggle(value)
	self.map_pieces.visible = value
