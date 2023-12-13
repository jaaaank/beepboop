extends Area2D

var canswitch: bool = false
var player

onready var point:= $point
onready var animp:= $AnimationPlayer
onready var text:= $ModeText

func _input(_event):
	if Input.is_action_just_pressed("1") and canswitch:
		player.call("switchMode",1)
	if Input.is_action_just_pressed("2") and canswitch:
		player.call("switchMode",2)
	elif Input.is_action_just_pressed("3") and canswitch:
		player.call("switchMode",3)

func _on_ModeSwitcher_body_entered(body):
	player = body
	if player.respawnpoint != point.global_position:
		animp.play("activate")
	player.respawnpoint = point.global_position
	canswitch = true
	text.visible = true

func _on_ModeSwitcher_body_exited(_body):
	canswitch = false
	$ModeText.visible = false
