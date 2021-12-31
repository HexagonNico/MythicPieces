extends Sprite


# Signals
signal activate

# Exported variables
export var tween_time: float = 1.0

# Onready variables
onready var runes = [$"Runes/Up", $"Runes/Down", $"Runes/Left", $"Runes/Right"]
onready var tween: Tween = $Tween

# Variables
var current_color: Color
var signal_emitted: bool


func _ready():
	self.current_color = Color(1.0, 1.0, 1.0, 0.0)
	for rune in runes:
		rune.modulate = self.current_color


# Called every frame
func _process(delta: float):
	for rune in runes:
		rune.modulate = self.current_color
	if self.current_color.a == 1.0 and not self.signal_emitted:
		self.emit_signal("activate")
		self.signal_emitted = true


func _on_Area2D_body_entered(_body):
	self.tween.interpolate_property(self, "current_color", self.current_color, Color(1.0, 1.0, 1.0, 1.0), self.tween_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	self.tween.start()
	self.signal_emitted = false


func _on_Area2D_body_exited(_body):
	self.tween.interpolate_property(self, "current_color", self.current_color, Color(1.0, 1.0, 1.0, 0.0), self.tween_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	self.tween.start()
