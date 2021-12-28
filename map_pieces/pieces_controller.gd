extends Node


# Signals
signal activate
signal deactivate

# Temporary
var moving: bool = false


func _ready():
	self.deactivate_pieces()


# Temporary
func _input(event):
	if event.is_pressed() and event.is_action("pieces_mode"):
		if not self.moving:
			self.activate_pieces()
			self.moving = true
		else:
			self.deactivate_pieces()
			self.moving = false


func activate_pieces():
	self.emit_signal("activate")
	for piece in self.get_children():
		if piece is MapPiece:
			piece.toggle(true)


func deactivate_pieces():
	self.emit_signal("deactivate")
	for piece in self.get_children():
		if piece is MapPiece:
			piece.toggle(false)
