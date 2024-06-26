extends ColorRect


var paused: = false setget set_paused

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		set_paused(!paused)
		get_tree().set_input_as_handled()

func set_paused(value: bool) -> void:
	paused = value
	get_tree().paused = value
	visible = value


func _on_RsuemButton_button_down():
	set_paused(!paused)


func _on_menuButton_pressed():
	set_paused(!paused)
	get_tree().change_scene("res://src/Scenes/TitleScreen.tscn")
