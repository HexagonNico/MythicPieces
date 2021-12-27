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
export var first_tile: Vector2
export var tilemap_size: Vector2

# Variables
var status = Status.DEFAULT
var drag_delta: Vector2 = Vector2(0, 0)
var position_before: Vector2 = Vector2(0, 0)


# Called every frame
func _process(_delta: float):
	# Dragging
	if self.status == Status.DRAGGING or self.status == Status.ERROR:
		var mouse_pos: Vector2 = self.get_viewport().get_mouse_position()
		var unmodulated: Vector2 = mouse_pos - self.drag_delta
		self.position = Vector2(round(unmodulated.x / 32) * 32, round(unmodulated.y / 32) * 32)
	
	# Color tint
	var color_tint: Color = Color(0.0, 0.0, 0.0, 0.0)
	match self.status:
		Status.SELECTED, Status.DRAGGING:
			color_tint = Color(self.selection_color.r, self.selection_color.g, self.selection_color.b, 0.0)
		Status.ERROR:
			color_tint = Color(self.error_color.r, self.error_color.g, self.error_color.b, 0.0)
	self.material.set_shader_param("color_additive", color_tint)


# Called at every input event
func _input(event: InputEvent):
	if event.is_action("select_map_piece"):
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
	$WallsLower.set_collision_layer_bit(8, value)
	$Walls.set_collision_layer_bit(9, value)


func copy_tilemap(walls: TileMap, grass: TileMap, walls_lower: TileMap):
	var this_walls: TileMap = $Walls
	var this_grass: TileMap = $Grass
	var this_walls_lower: TileMap = $WallsLower
	var origin: Vector2 = self.position / 32
	for x in range(self.first_tile.x, self.first_tile.x + self.tilemap_size.x):
		for y in range(self.first_tile.y, self.first_tile.y + self.tilemap_size.y):
			walls.set_cell(int(origin.x + x), int(origin.y + y), this_walls.get_cell(x, y), false, false, false, this_walls.get_cell_autotile_coord(x, y))
			grass.set_cell(int(origin.x + x), int(origin.y + y), this_grass.get_cell(x, y), false, false, false, this_grass.get_cell_autotile_coord(x, y))
			walls_lower.set_cell(int(origin.x + x), int(origin.y + y), this_walls_lower.get_cell(x, y), false, false, false, this_walls_lower.get_cell_autotile_coord(x, y))

