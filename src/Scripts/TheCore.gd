extends Actor

var x: int = 60
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func damage(dmg):
	health -= dmg
	$CanvasLayer/ProgressBar.value = health/150*100
	if health <= 0:
		$CanvasLayer/ProgressBar.queue_free()
		$FullTimer.start(60)
		$SecTimer.start(1)
		$CanvasLayer/Label.bbcode_text = "[center][color=#ff2d00]TIME LEFT UNTIL FACTORY SELF-DESTRUCT: 60[/color]"


func _on_SecTimer_timeout():
	$SecTimer.start(1)
	x-=1
	$CanvasLayer/Label.bbcode_text = "[center][color=#ff2d00]TIME LEFT UNTIL FACTORY SELF-DESTRUCT: "+String(x) +"[/color]"


func _on_FullTimer_timeout():
	#she loses
	pass
