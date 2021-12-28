extends TileMap


# Exported variables
export var tilemap_size: Vector2

func clear():
	for x in range(self.tilemap_size.x):
		for y in range(self.tilemap_size.y):
			self.set_cell(x, y, -1)
