extends Actor

export (float, 0, 1.0) var friction = 0.1
export (float, 0, 1.0) var acceleration = 0.25
export var respawnpoint: Vector2 = Vector2(0,0)
export var normalSprite: Texture
export var runSprite: Texture
export var gunSprite: Texture
export var jumpSprite: Texture
export var deathSprite: Texture

#0 = normal mode
#1 = jump mode (moves a bit faster and jumps much higher)
#2 = run mode (moves much faster and jumps a bit higher)
#3 = attack mode (gets attack guns)
#4 = BIG mode (final boss only)
export var mode: int = 0
onready var sprite: Sprite = $Sprite
onready var AnimP: = $AnimationPlayer
onready var onehp: Sprite = $UI/Control/Node2D/onehp
onready var twohp: Sprite = $UI/Control/Node2D/twohp
onready var threehp: Sprite = $UI/Control/Node2D/threehp

var dead:bool = false

func _ready():
	health = 3
	$Sprite.texture = normalSprite
	
func _physics_process(_delta: float):
	var was_on_floor:bool = is_on_floor()
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var dir: = get_direction() 
	_velocity = calculate_move_velocity(_velocity, dir, speed, is_jump_interrupted)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
	if was_on_floor and !is_on_floor():
		$CoyoteTimer.start()
	if _velocity.x< 0:
		sprite.flip_h = true
	elif _velocity.x> 0:
		sprite.flip_h = false
	if not Input.is_action_pressed("moveLeft") and not Input.is_action_pressed("moveRight"):
		_velocity.x =0
	#animations
	if _velocity.x !=0 and is_on_floor():
		AnimP.play("walk")
	elif !is_on_floor():
		AnimP.play("fall")
	else:
		AnimP.play("idle")


func get_direction() -> Vector2:
	return Vector2 (
		Input.get_action_strength("moveRight") - Input.get_action_strength("moveLeft"), 
		-1.0 if Input.is_action_just_pressed("jump") and (is_on_floor() or !$CoyoteTimer.is_stopped()) else 1.0)

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

#func _input(event):
#	if Input.is_action_just_pressed("dash"):
#		_velocity.x *= 20
#		if _velocity.x ==0:
#			_velocity.x = 3000

func damage(dmg):
	if !dead:
		health -=dmg
		updateinterface()
		$beepdamaged.play()
		if health <= 0:
			die()
	
func switchMode(newMode):
	mode = newMode
	match mode:
		0:
			speed = Vector2(350, 700)
			sprite.texture = normalSprite
			$GUN.visible = false
		1:
			speed = Vector2(400, 1000)
			print("jump mode")
			sprite.texture = jumpSprite
		2:
			pass # run mode
			speed = Vector2(700,700)
			print("run mode")
			sprite.texture = runSprite
		3: 
			pass # attack mode
			$GUN.visible = true
			print("attack mode")
			sprite.texture = gunSprite
		4: 
			pass # BIGMODE
	if mode !=1 and mode !=2:
		speed = Vector2(350,700)
		print("not jump or run mode")
	elif mode !=3:
		$GUN.visible = false
		print("not attack mode")
	print(mode)
	
func die():
	Autoload.deaths +=1
	dead = true
	$Sprite.texture = deathSprite
	AnimP.play("death")
	set_physics_process(false)
	set_process_input(false)
	$diesound.play()
	
func respawn():
	dead = false
	switchMode(0)
	set_process_input(true)
	set_physics_process(true)
	global_position = respawnpoint
	health = 3
	updateinterface()
	
func updateinterface():
	match health:
		3.0:
			onehp.frame = 0
			twohp.frame = 0
			threehp.frame = 0
		2.0:
			onehp.frame = 0
			twohp.frame = 0
			threehp.frame = 1
		1.0:
			onehp.frame = 0
			twohp.frame = 1
			threehp.frame = 1
