extends Node


export var main_menu_scene: String = "res://ui/title_screen.tscn"


func _input(event):
	if event.is_pressed() and event.is_action("ui_cancel"):
		self.back_button()


func back_button():
	self.get_tree().change_scene(self.main_menu_scene)
