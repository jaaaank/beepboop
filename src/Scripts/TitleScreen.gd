extends Control

func _on_Button_pressed():
	get_tree().change_scene("res://src/Scenes/LevelSelect.tscn")


func _on_Button2_pressed():
	OS.shell_open("https://dippostudios.itch.io/")


func _on_Button3_pressed():
	get_tree().change_scene("res://src/Scenes/Credits.tscn")
