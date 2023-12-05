extends Area2D
class_name projectile
var speed := Vector2(1000,1000)

export var layer: int

func _physics_process(delta):
	position += transform.x * speed * delta
	#make the sprites symmetrical so i dont have to flip them


func _on_Bullet_body_entered(body):
	if body.get_collision_layer_bit(layer):
		body.call("damage")
		print("hitbeep")
	queue_free()

func _on_Bullet_area_entered(area):
	if area.get_collision_layer_bit(layer):
		area.owner.call("damage", 10)
	queue_free()
