extends StaticBody2D




func _on_Hitbox_body_entered(body):
	if body.get_collision_layer_bit(0):
		body.call("damage")
		print("hit bb")
