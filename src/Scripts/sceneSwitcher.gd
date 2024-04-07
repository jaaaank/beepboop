extends Area2D

export var levelToUnlock: int


func _ready():
	set_physics_process(false)
	
func _physics_process(delta):
	$CanvasLayer/ColorRect.color.a += .55 * delta
	if $CanvasLayer/ColorRect.color.a >= 1:
			get_tree().change_scene("res://src/Scenes/LevelSelect.tscn")
			Autoload.levelsUnlocked[levelToUnlock] = true
	

func _on_sceneswitcher_body_entered(_body):
	set_physics_process(true)

