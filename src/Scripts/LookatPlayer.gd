extends Node2D

onready var route = get_tree().root.get_child(2).name
onready var player = get_tree().root.get_node(route + "/BeepBoop")
export (PackedScene) var bullet
onready var gun = $GunSprite
var cooldown: bool = false
export var raynge: int = 400


func _process(_delta):
	if !gun.flip_v and int(abs(rotation_degrees))%360>90 and int(abs(rotation_degrees))%360<270:
		gun.flip_v = true
	if gun.flip_v and int(abs(rotation_degrees))%360<90 or int(abs(rotation_degrees))%360>270:
		gun.flip_v = false
	look_at(player.global_position)
	
func fireBullet():
	if global_position.distance_to(player.global_position) <= raynge: 
		$shootsound.play()
		print(abs(player.global_position.x - global_position.x))
		var b = bullet.instance()
		get_tree().root.get_child(0).add_child(b)
		b.global_position = $muzzle.global_position
		b.scale = scale
		b.rotation_degrees = rotation_degrees
		cooldown = true
	$cooldowntimer.start()
