extends Area2D


# Exported variables
export var upper_collision_layer: int = 9
export var lower_collision_layer: int = 8
export var upper_z_index: int = 3
export var lower_z_index: int = 0

# TODO - This needs to change because we are no longer using Z indexes
func _on_LayerTrigger_body_exited(body: KinematicBody2D):
	body.set_collision_mask_bit(self.upper_collision_layer, body.global_position.y < self.global_position.y)
	body.set_collision_mask_bit(self.lower_collision_layer, body.global_position.y > self.global_position.y)
	body.z_index = self.upper_z_index if body.global_position.y < self.global_position.y else self.lower_z_index
