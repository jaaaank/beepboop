extends Actor

var left: bool = false
onready var animp:= $AnimationPlayer
var schpeed: int = 300

func _physics_process(_delta):
	move_and_slide(Vector2(schpeed,0))
	if is_on_wall():
		_on_Timer_timeout()
		
func _on_Timer_timeout():
	if !left:
		schpeed = -300
		$Flyingenemy.flip_h = true
	else:
		schpeed = 300
		$Flyingenemy.flip_h = false
	left = !left

func damage(dmg):
	health -= dmg
	print("enemyhealth:" + String(health))
	if health<=0:
		set_physics_process(false)
		$hitbox/CollisionShape2D.set_deferred("disabled",false)
		$CollisionShape2D.set_deferred("disabled",false)
		$hitbox.set_deferred("monitorable", false)
		$hitbox.set_deferred("monitoring", false)
		animp.play("die")

func _on_hitbox_body_entered(body):
	if body.get_collision_layer_bit(0):
		animp.play("attack")
		body.call("damage", 1)
		print(("damaged player"))

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "die":
		queue_free()
