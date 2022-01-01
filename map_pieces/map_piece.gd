class_name MapPiece
extends Node2D


enum Status {
	DEFAULT,
	SELECTED,
	DRAGGING,
	ERROR,
}

# Exported variables
export var selection_color: Color = Color(0.15, 0.15, 0.15, 1)
export var error_color: Color = Color(0.2, 0.0, 0.0, 1)
export var tilemap_size: Vector2
export var immovable: bool

# Variables
var enabled: bool = false
var status = Status.DEFAULT
var drag_delta: Vector2 = Vector2(0, 0)
var position_before: Vector2 = Vector2(0, 0)
var drag_limit: Vector2

# Called every frame
func _process(_delta: float):
	# Dragging
	if self.status == Status.DRAGGING or self.status == Status.ERROR:
		var mouse_pos: Vector2 = self.get_viewport().get_mouse_position()
		var unmodulated: Vector2 = mouse_pos - self.drag_delta
		self.position = Vector2(round(unmodulated.x / 32) * 32, round(unmodulated.y / 32) * 32)
		self.position.x = clamp(self.position.x, 0.0, (self.drag_limit.x - self.tilemap_size.x) * 32)
		self.position.y = clamp(self.position.y, 0.0, (self.drag_limit.y - self.tilemap_size.y) * 32)
	
	# Color tint
	var color_tint: Color = Color(0.0, 0.0, 0.0, 0.0)
	if self.enabled and (self.status == Status.SELECTED or self.status == Status.DRAGGING):
		color_tint = Color(self.selection_color.r, self.selection_color.g, self.selection_color.b, 0.0)
	elif self.enabled and self.status == Status.ERROR:
		color_tint = Color(self.error_color.r, self.error_color.g, self.error_color.b, 0.0)
	self.material.set_shader_param("color_additive", color_tint)


# Called at every input event
func _input(event: InputEvent):
	if self.enabled and not self.immovable and event.is_action("select_map_piece"):
		if event.is_pressed():
			if self.status == Status.SELECTED:
				self.status = Status.DRAGGING
				self.drag_delta = self.get_viewport().get_mouse_position() - self.position
				self.position_before = self.position
		else:
			if self.status == Status.ERROR:
				self.position = self.position_before
				self.status = Status.DEFAULT
			elif self.status == Status.DRAGGING:
				self.status = Status.SELECTED


# Receives mouse_entered signal from SelectionArea
func _on_SelectionArea_mouse_entered():
	if self.status == Status.DEFAULT:
		self.status = Status.SELECTED


# Receives mouse_exited signal from SelectionArea
func _on_SelectionArea_mouse_exited():
	if self.status == Status.SELECTED:
		self.status = Status.DEFAULT


# Receives area_entered signal from CollisionArea
func _on_CollisionArea_area_entered(_area: Area2D):
	if self.status == Status.DRAGGING:
		self.status = Status.ERROR


# Receives area_exited signal from CollisionArea
func _on_CollisionArea_area_exited(_area: Area2D):
	if self.status == Status.ERROR:
		self.status = Status.DRAGGING


func toggle(value: bool):
	$Tilemap/WallsLower.set_collision_layer_bit(8, value)
	$Tilemap/Walls.set_collision_layer_bit(9, value)
	$Tilemap.visible = value
	self.enabled = value
	self.status = Status.DEFAULT


func copy_tilemap(walls: TileMap, grass: TileMap, walls_lower: TileMap):
	var this_walls: TileMap = $Tilemap/Walls
	var this_grass: TileMap = $Tilemap/Grass
	var this_walls_lower: TileMap = $Tilemap/WallsLower
	var origin: Vector2 = self.position / 32
	for x in range(self.tilemap_size.x):
		for y in range(self.tilemap_size.y):
			var wall_tile = this_walls.get_cell(x, y)
			var grass_tile = this_grass.get_cell(x, y)
			var wall_lower_tile = this_walls_lower.get_cell(x, y)
			if wall_tile != -1:
				walls.set_cell(int(origin.x + x), int(origin.y + y), wall_tile, false, false, false, this_walls.get_cell_autotile_coord(x, y))
			if grass_tile != -1:
				grass.set_cell(int(origin.x + x), int(origin.y + y), grass_tile, false, false, false, this_grass.get_cell_autotile_coord(x, y))
			if wall_lower_tile != -1:
				walls_lower.set_cell(int(origin.x + x), int(origin.y + y), wall_lower_tile, false, false, false, this_walls_lower.get_cell_autotile_coord(x, y))


func copy_overlay_tilemap(overlay_above: TileMap, overlay_below: TileMap):
	var this_overlay_below: TileMap = $Tilemap/OverlayLower
	var this_overlay_above: TileMap = $Tilemap/OverlayUpper
	var origin: Vector2 = self.position / 32
	for x in range(self.tilemap_size.x):
		for y in range(self.tilemap_size.y):
			var tile_below = this_overlay_below.get_cell(x, y)
			if tile_below != -1:
				overlay_below.set_cell(int(origin.x + x), int(origin.y + y), tile_below, false, false, false, this_overlay_below.get_cell_autotile_coord(x, y))
			var tile_above = this_overlay_above.get_cell(x, y)
			if tile_above != -1:
				overlay_above.set_cell(int(origin.x + x), int(origin.y + y), tile_above, false, false, false, this_overlay_above.get_cell_autotile_coord(x, y))
