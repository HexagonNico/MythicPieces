extends HBoxContainer


# Exported variables
export var level_1_scene: String = "res://levels/test_level.tscn"
export var credits_scene: String = "res://ui/credits.tscn"


func button_play():
	self.get_tree().change_scene(self.level_1_scene)


func button_credits():
	self.get_tree().change_scene(self.credits_scene)


func button_quit():
	self.get_tree().quit(0)
