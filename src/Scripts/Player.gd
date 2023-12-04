extends Actor

export (float, 0, 1.0) var friction = 0.1
export (float, 0, 1.0) var acceleration = 0.25

#0 = normal mode
#1 = jump mode (moves a bit faster and jumps much higher)
#2 = defense mode (moves slow but can move over obstacles)
#3 = attack mode (gets attack guns)
#4 = BIG mode (final boss only)
export var mode: int = 0
onready var sprite: Sprite = $Sprite
onready var AnimP: = $AnimationPlayer
onready var AudioHurt = $PlayerHurt
onready var AudioDeath = $PlayerDead

func ready():
	health = 5
	
func _physics_process(_delta: float):
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var dir: = get_direction() 
	_velocity = calculate_move_velocity(_velocity, dir, speed, is_jump_interrupted)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
	if _velocity.x< 0:
		sprite.flip_h = true
	elif _velocity.x> 0:
		sprite.flip_h = false
	if not Input.is_action_pressed("moveLeft") and not Input.is_action_pressed("moveRight"):
		_velocity.x =0
	if Input.is_action_just_pressed("jump"):
		dir.y = -1.0
	
func get_direction() -> Vector2:
	return Vector2 (
		Input.get_action_strength("moveRight") - Input.get_action_strength("moveLeft"), 
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0)

func calculate_move_velocity(
		linear_velocity: Vector2,
		dir: Vector2,
		speed: Vector2,
		is_jump_interrupted: bool
	 ) -> Vector2:
	var out: = linear_velocity
	out.x = lerp(_velocity.x, dir.x * speed.x, acceleration)
	out.y += gravity * get_physics_process_delta_time()
	if dir.y == -1.0:
		out.y = speed.y * dir.y
	if is_jump_interrupted:
		out.y = 0.0
	return out

func damage():
	health -=1
	print("beepdamaged")
	if health <= 0:
		die()
	
func switchMode(newMode):
	mode = newMode
	match mode:
		0:
			pass # normal mode
		1:
			speed = Vector2(400, 900)
			print("jump mode")
		2:
			pass # defense mode
			print("defense mode")
		3: 
			pass # attack mode
			$GUN.visible = true
			print("attack mode")
		4: 
			pass # BIGMODE
	if mode !=1:
		speed = Vector2(350,700)
		print("not jump mode")
	elif mode !=3:
		$GUN.visible = false
		print("not attack mode")
	print(mode)
	
func die() -> void:
	queue_free()
