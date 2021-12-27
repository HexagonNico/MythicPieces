extends Area2D


func _on_Temporary_body_entered(body: CollisionObject2D):
	body.set_collision_mask_bit(9, body.position.y > self.position.y)
	body.set_collision_mask_bit(8, body.position.y < self.position.y)
	body.z_index = 3 if body.position.y > self.position.y else 0
