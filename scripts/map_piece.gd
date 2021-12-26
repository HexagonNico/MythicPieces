extends Node2D

# Inspector variables
export var red_tint: float = 0.15
export var green_tint: float = 0.15
export var blue_tint: float = 0.15


# Receives signal from Area2D
func _on_mouse_entered():
	var color_tint: Color = Color(self.red_tint, self.green_tint, self.blue_tint, 0.0)
	self.material.set_shader_param("color_additive", color_tint)
	print("Mouse entered")


# Receives signal from Area2D
func _on_mouse_exited():
	self.material.set_shader_param("color_additive", Color(0.0, 0.0, 0.0, 0.0))
	print("Mouse exited")
