extends Area2D

var canswitch: bool = false
var player

export var jumpEnabled = true
export var runEnabled = true
export var attackEnabled = true
onready var text:= $ModeText
onready var point:= $point
onready var animp:= $AnimationPlayer
onready var txt:= $ModeText

func _ready():
	txt.bbcode_text = "[center]"
	if jumpEnabled:
		txt.bbcode_text += "1 = Jump Mode\n"
	if runEnabled:
		txt.bbcode_text += "2 = Run Mode\n"
	if attackEnabled:
		txt.bbcode_text += "3 = Attack Mode\n"
		
func _input(_event):
	if Input.is_action_just_pressed("1") and canswitch and jumpEnabled:
		player.call("switchMode",1)
	elif Input.is_action_just_pressed("2") and canswitch and runEnabled:
		player.call("switchMode",2)
	elif Input.is_action_just_pressed("3") and canswitch and attackEnabled:
		player.call("switchMode",3)

func _on_ModeSwitcher_body_entered(body):
	player = body
	if player.respawnpoint != point.global_position:
		animp.play("activate")
	if player.health != 3:
		player.health = 3
		player.updateinterface()
	player.respawnpoint = point.global_position
	canswitch = true
	text.visible = true

func _on_ModeSwitcher_body_exited(_body):
	canswitch = false
	$ModeText.visible = false
