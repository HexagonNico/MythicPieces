class_name PlayerScript
extends KinematicBody2D


# Exported variables
export var speed: int = 200 # Pixels / second

# Varying variables
var input: Vector2
var input_enabled: bool = true

# Onready variables
onready var sprite: AnimatedSprite = $AnimatedSprite


# Called every frame
func _process(_delta_time: float):
	# Movement input
	if self.input_enabled:
		self.input.x = Input.get_axis("move_left", "move_right")
		self.input.y = Input.get_axis("move_up", "move_down")
	else:
		self.input = Vector2(0, 0)
	
	# Animation
	match self.input:
		Vector2(0, -1):
			self.sprite.animation = "up"
		Vector2(1, -1):
			self.sprite.animation = "up_right"
		Vector2(-1, -1):
			self.sprite.animation = "up_left"
		Vector2(0, 1):
			self.sprite.animation = "down"
		Vector2(-1, 1):
			self.sprite.animation = "down_left"
		Vector2(1, 1):
			self.sprite.animation = "down_right"
		Vector2(-1, 0):
			self.sprite.animation = "left"
		Vector2(1, 0):
			self.sprite.animation = "right"
	if self.input != Vector2(0, 0):
		self.sprite.play()
	else:
		self.sprite.stop()


# Called during physics processing of the main loop
func _physics_process(_delta_time: float):
	# Movement
	var velocity : Vector2 = self.input.normalized() * self.speed
	self.move_and_slide(velocity)


func _on_MapPieces_activate():
	$PlayerCamera.zoom = Vector2.ONE
	self.input_enabled = false


func _on_MapPieces_deactivate():
	$PlayerCamera.zoom = Vector2.ONE / 2
	self.input_enabled = true
