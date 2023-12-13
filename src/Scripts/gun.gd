extends Node2D

export (PackedScene) var bullet
onready var gun = $GunSprite
var cooldown: bool = false

func _process(_delta):
	if !gun.flip_v and int(abs(rotation_degrees))%360>90 and int(abs(rotation_degrees))%360<270:
		gun.flip_v = true
	if gun.flip_v and int(abs(rotation_degrees))%360<90 or int(abs(rotation_degrees))%360>270:
		gun.flip_v = false
	look_at(get_global_mouse_position())

func _input(_event):
	if Input.is_action_just_pressed("shoot") and !cooldown and visible:
		$Lasershoot.play()
		var b = bullet.instance()
		get_tree().root.add_child(b)
		b.position = $GunSprite/muzzle.global_position
		b.scale = scale
		b.rotation_degrees = rotation_degrees
		cooldown = true
		$cooldowntimer.start()

func _on_cooldowntimer_timeout():
	cooldown = false
