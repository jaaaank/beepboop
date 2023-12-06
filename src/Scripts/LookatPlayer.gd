extends Node2D


onready var player = get_tree().root.get_node("TestLevel/BeepBoop")
export (PackedScene) var bullet
onready var gun = $Sprite
var cooldown: bool = false

func _process(delta):
	if !gun.flip_v and int(abs(rotation_degrees))%360>90 and int(abs(rotation_degrees))%360<270:
		gun.flip_v = true
	if gun.flip_v and int(abs(rotation_degrees))%360<90 or int(abs(rotation_degrees))%360>270:
		gun.flip_v = false
	look_at(player.position)
	
func fireBullet():
	var b = bullet.instance()
	get_tree().root.add_child(b)
	b.position = global_position
	b.scale = scale
	b.rotation_degrees = rotation_degrees
	cooldown = true
	$cooldowntimer.start()
