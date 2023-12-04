extends Actor
onready var sprite = $Walkingenemyplaceholder

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
		body.call("damage")
		print(("damaged player"))

func damage(dmg):
	health -= dmg
	print("enemyhealth:" + String(health))
	if health<=0:
		die()
		
	
func die():
	queue_free()
