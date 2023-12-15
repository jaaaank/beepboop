extends KinematicBody2D

var left: bool = false
export var movementSpeed: float = 100

func _physics_process(_delta):
	translate(Vector2(movementSpeed,0) * _delta)
	if is_on_wall():
		_on_Timer_timeout()
func _on_Timer_timeout():
	if !left:
		movementSpeed = -movementSpeed
	else:
		movementSpeed = abs(movementSpeed)
	left = !left
