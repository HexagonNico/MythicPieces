extends Node


# Signals
signal activate
signal deactivate

# Exported variables
export var lower_walls_tilemap_path: NodePath
export var walls_border_tilemap_path: NodePath
export var grass_tilemap_path: NodePath
export var tilemap_size: Vector2

# Onready variables
onready var lower_walls_tilemap: TileMap = self.get_node(self.lower_walls_tilemap_path)
onready var walls_border_tilemap: TileMap = self.get_node(self.walls_border_tilemap_path)
onready var grass_tilemap: TileMap = self.get_node(self.grass_tilemap_path)

# Temporary
var moving: bool = false


func _ready():
	self.deactivate_pieces()


# Temporary
func _input(event):
	if event.is_pressed() and event.is_action("pieces_mode"):
		if not self.moving:
			self.activate_pieces()
			self.moving = true
		else:
			self.deactivate_pieces()
			self.moving = false


func activate_pieces():
	self.emit_signal("activate")
	for piece in self.get_children():
		if piece is MapPiece:
			piece.toggle(true)


func deactivate_pieces():
	self.emit_signal("deactivate")
	for piece in self.get_children():
		if piece is MapPiece:
			piece.toggle(false)
	self.copy_tilemap()


func copy_tilemap():
	for piece in self.get_children():
		if piece is MapPiece:
			piece.copy_tilemap(self.walls_border_tilemap, self.grass_tilemap, self.lower_walls_tilemap)
	self.walls_border_tilemap.update_bitmask_region(Vector2.ZERO, self.tilemap_size)
	self.lower_walls_tilemap.update_bitmask_region(Vector2.ZERO, self.tilemap_size)
	for piece in self.get_children():
		if piece is MapPiece:
			piece.copy_overlay_tilemap(self.walls_border_tilemap, self.lower_walls_tilemap)
