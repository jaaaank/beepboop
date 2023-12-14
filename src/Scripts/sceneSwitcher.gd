extends Area2D

export var nextScenePath: String  = ""


func _ready():
	set_physics_process(false)
	
func _physics_process(delta):
	$CanvasLayer/ColorRect.color.a += .75 * delta
	if $CanvasLayer/ColorRect.color.a >= 2:
			get_tree().change_scene(nextScenePath)
	

func _on_sceneswitcher_body_entered(body):
	set_physics_process(true)

