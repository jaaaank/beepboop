extends Actor
onready var sprite = $sprite
onready var animp = $AnimationPlayer

func _ready():
	speed = Vector2(100,0)
	health = 11
	_velocity.x = -speed.x + 200.0

func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	if is_on_wall():
		_velocity.x *= -1.0
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
	if _velocity.x< 0:
		sprite.flip_h = true
	elif _velocity.x> 0:
		sprite.flip_h = false
		
		
func _on_hitbox_body_entered(body):
	if body.get_collision_layer_bit(0):
		animp.play("attack")
		body.call("damage", 1)

func damage(dmg):
	health -= dmg
	print("enemyhealth:" + String(health))
	if health<=0:
		animp.play("die")

func _on_walktimer_timeout():
	_velocity.x *= -1.0
	
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "die":
		set_process(false)
		$hitbox/CollisionShape2D.disabled = true
		$CollisionShape2D.disabled = true
		queue_free()
	if anim_name != "walk":
		animp.play("walk")
