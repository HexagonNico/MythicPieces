extends Control


export var start_visible: bool = true


func _ready():
	self.visible = self.start_visible


func make_visible():
	self.visible = true


func make_invisible():
	self.visible = false
