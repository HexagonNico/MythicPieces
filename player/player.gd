class_name PlayerScript
extends KinematicBody2D


# Exported variables
export var speed: int = 200 # Pixels / second

# Varying variables
var input: Vector2
var pieces_mode: bool = false

# Onready variables
onready var sprite: AnimatedSprite = $AnimatedSprite
onready var camera: Camera2D = $PlayerCamera


# Called every frame
func _process(_delta_time: float):
	# Movement input
	self.input.x = Input.get_axis("move_left", "move_right")
	self.input.y = Input.get_axis("move_up", "move_down")
	
	# Animation
	if not self.pieces_mode:
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
func _physics_process(delta_time: float):
	if not self.pieces_mode:
		var velocity : Vector2 = self.input.normalized() * self.speed
		self.move_and_slide(velocity)
	else:
		self.camera.position += self.input.normalized() * self.speed * delta_time


func _on_MapPieces_activate():
	self.camera.zoom = Vector2.ONE
	self.pieces_mode = true


func _on_MapPieces_deactivate():
	self.camera.zoom = Vector2.ONE / 2
	self.camera.position = Vector2.ZERO
	self.pieces_mode = false
