extends TileMap


# Exported variables
export var tilemap_size: Vector2

var original_tilemap


func _ready():
	self.original_tilemap = []
	for x in range(self.tilemap_size.x):
		self.original_tilemap.append([])
		for y in range(self.tilemap_size.y):
			self.original_tilemap[x].append(self.get_cell(x, y))


func clear():
	for x in range(self.tilemap_size.x):
		for y in range(self.tilemap_size.y):
			self.set_cell(x, y, self.original_tilemap[x][y])
	self.update_bitmask_region(Vector2.ZERO, self.tilemap_size)
