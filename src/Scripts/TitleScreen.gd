extends Control

func _on_Button_pressed():
	print("wa")
	get_tree().change_scene("res://src/Scenes/LevelSelect.tscn")


func _on_Button2_pressed():
	OS.shell_open("https://dippostudios.itch.io/")
