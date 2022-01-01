extends HBoxContainer


func button_play():
	print("Play")


func button_credits():
	print("Credits")


func button_quit():
	self.get_tree().quit(0)
