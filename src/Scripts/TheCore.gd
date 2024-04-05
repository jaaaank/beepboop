extends Actor



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func damage(dmg):
	health -= dmg
	$CanvasLayer/ProgressBar.value = health/15
	if health <= 0:
		queue_free()
