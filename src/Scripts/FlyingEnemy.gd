extends Actor

var left: bool = false
var schpeed: int = 300

func _physics_process(_delta):
	move_and_slide(Vector2(schpeed,0))
	if is_on_wall():
		_on_Timer_timeout()
		
func _on_Timer_timeout():
	if !left:
		schpeed = -300
	else:
		schpeed = 300
	left = !left

func damage(dmg):
	health -= dmg
	print("enemyhealth:" + String(health))
	if health<=0:
		die()

func _on_hitbox_body_entered(body):
	if body.get_collision_layer_bit(0):
		body.call("damage", 1)
		print(("damaged player"))
	
func die():
	queue_free()
