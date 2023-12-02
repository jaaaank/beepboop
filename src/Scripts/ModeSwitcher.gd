extends Area2D


var canswitch: bool = false
var player


func _input(event):
	if Input.is_action_just_pressed("1") and canswitch:
		player.call("switchMode",1)
	elif Input.is_action_just_pressed("3") and canswitch:
		player.call("switchMode",3)

func _on_ModeSwitcher_body_entered(body):
	player = body
	canswitch = true

func _on_ModeSwitcher_body_exited(body):
	canswitch = false
