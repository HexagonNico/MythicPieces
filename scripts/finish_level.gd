extends Sprite


signal enter_area
signal exit_area

export var next_level_scene: String

var is_in_area: bool


func _input(event):
	if self.is_in_area and event.is_action("interact"):
		self.get_tree().change_scene(self.next_level_scene)


func _on_InteractionArea_body_entered(body):
	self.emit_signal("enter_area")
	self.is_in_area = true


func _on_InteractionArea_body_exited(body):
	self.emit_signal("exit_area")
	self.is_in_area = false
