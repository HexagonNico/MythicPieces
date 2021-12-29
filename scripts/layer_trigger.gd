extends Area2D


# Exported variables
export var upper_collision_layer: int = 9
export var lower_collision_layer: int = 8
export var upper_layer_y_sort_path: NodePath
export var lower_layer_y_sort_path: NodePath

# Onready variables
onready var upper_layer_y_sort: YSort = self.get_node(self.upper_layer_y_sort_path)
onready var lower_layer_y_sort: YSort = self.get_node(self.lower_layer_y_sort_path)


func _on_LayerTrigger_body_exited(body: KinematicBody2D):
	if body.global_position.y < self.global_position.y:
		body.set_collision_mask_bit(self.upper_collision_layer, true)
		body.set_collision_mask_bit(self.lower_collision_layer, false)
		self.lower_layer_y_sort.remove_child(body)
		self.upper_layer_y_sort.add_child(body)
	else:
		body.set_collision_mask_bit(self.lower_collision_layer, true)
		body.set_collision_mask_bit(self.upper_collision_layer, false)
		self.upper_layer_y_sort.remove_child(body)
		self.lower_layer_y_sort.add_child(body)
