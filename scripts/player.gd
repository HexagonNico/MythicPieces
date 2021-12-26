extends KinematicBody2D


# Inspector valus
export var speed: int = 200 # Pixels / second

# Nodes
onready var sprite: AnimatedSprite = $AnimatedSprite

# Varying variables
var input: Vector2


# Called every frame
func _process(_delta_time: float):
	# Movement input
	self.input.x = Input.get_axis("move_left", "move_right")
	self.input.y = Input.get_axis("move_up", "move_down")
	
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
