extends Node2D


onready var tilemap = $TileMap

var temp_wait: float = 0.0
var updated: bool = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	self.temp_wait += delta
	if self.temp_wait > 5.0 and !self.updated:
		self.tilemap.set_cell(13, 5, 0)
		self.tilemap.set_cell(13, 6, 0)
		self.tilemap.set_cell(13, 7, 0)
		self.tilemap.update_bitmask_region(Vector2(12, 5), Vector2(14, 7))
		self.updated = true
