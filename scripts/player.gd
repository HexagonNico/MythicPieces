extends Node2D

# Inspector valus
export var speed: int = 200 # Pixels / second

# Varying variables
var input: Vector2


# Called every frame
func _process(_delta_time: float):
	# Movement input
	self.input.x = Input.get_axis("move_left", "move_right")
	self.input.y = Input.get_axis("move_up", "move_down")


# Called during physics processing of the main loop
func _physics_process(delta_time: float):
	# Movement
	var velocity : Vector2 = self.input.normalized() * self.speed
	self.position += velocity * delta_time
