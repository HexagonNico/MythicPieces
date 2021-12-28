extends Node2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	for node in self.get_children():
		node.z_index = node.global_position.y
