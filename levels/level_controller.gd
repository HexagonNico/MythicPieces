extends Node2D


# Exported variables
export var tilemap_size: Vector2

# Private variables
var active: bool = false

# Onready variables
onready var player: PlayerScript = $Player
onready var player_camera: Camera2D = $Player/PlayerCamera
onready var wide_camera: Camera2D = $WideCamera
onready var map_pieces: YSort = $MapPieces
onready var tilemap_walls: TileMap
onready var tilemap_grass: TileMap
onready var tilemap_walls_lower: TileMap


func _ready():
	self.toggle_map_pieces(false)


# Called when there is an input event
func _input(event: InputEvent):
	if event.is_action("pieces_mode") and event.is_pressed():
		if not self.active:
			self.wide_camera.make_current()
			self.player.input_enabled = false
			self.toggle_map_pieces(true)
			self.erease_tilemap()
			self.active = true
		else:
			self.player_camera.make_current()
			self.player.input_enabled = true
			self.toggle_map_pieces(false)
			self.copy_tilemap()
			self.active = false


func toggle_map_pieces(value: bool):
	for piece in self.map_pieces.get_children():
		piece.toggle(value)


func copy_tilemap():
	for piece in self.map_pieces.get_children():
		piece.copy_tilemap(self.tilemap_walls, self.tilemap_grass, self.tilemap_walls_lower)
	self.tilemap_walls.update_bitmask_region(Vector2.ZERO, self.tilemap_size)
	self.tilemap_walls_lower.update_bitmask_region(Vector2.ZERO, self.tilemap_size)
	for piece in self.map_pieces.get_children():
		piece.copy_overlay_tilemap(self.tilemap_walls, self.tilemap_walls_lower)


func erease_tilemap():
	for x in range(self.tilemap_size.x):
		for y in range(self.tilemap_size.y):
			self.tilemap_walls.set_cell(x, y, -1)
			self.tilemap_grass.set_cell(x, y, -1)
			self.tilemap_walls_lower.set_cell(x, y, -1)
