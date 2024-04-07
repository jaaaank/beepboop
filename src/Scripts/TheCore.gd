extends Actor

var x: int = 60
var ded:bool = false

#the following variable and related code is a horrible and lazy way to make the 
	# text color switch between red and white
var red:bool = true

signal murked

func _physics_process(delta):
	connect("murked", get_parent().find_node("doorthatsdefnotjustaplatform"), "open")
	if get_node_or_null("Laser"):
		$Laser.rotate(.75*delta)
	if ded: 
		$CanvasLayer/explodeness.color.a+=.40*delta
	if $CanvasLayer/explodeness.color.a>=1:
		get_tree().change_scene("res://src/Scenes/badEnding.tscn")
		
func damage(dmg):
	health -= dmg
	$CanvasLayer/ProgressBar.value = health/150*100
	if health <= 0:
		emit_signal("murked")
		$explosionsound.play()
		$Laser.queue_free()
		$CanvasLayer/ProgressBar.queue_free()
		$FullTimer.start(60)
		$SecTimer.start(1)
		$CanvasLayer/Label.bbcode_text = "[center][color=#ff2d00]TIME LEFT UNTIL FACTORY SELF-DESTRUCT: 60[/color]"
		for i in get_children():
			if i.get_name().begins_with("Turr"):
				i.queue_free()

func _on_SecTimer_timeout():
	if ded:
		$explosionsound.play()
	$SecTimer.start(1)
	x-=1
	if red:
		$CanvasLayer/Label.bbcode_text = "[center][color=#ff2d00]TIME LEFT UNTIL FACTORY SELF-DESTRUCT: "+String(x) +"[/color]"
	if !red:
		$CanvasLayer/Label.bbcode_text = "[center][color=#ffffff]TIME LEFT UNTIL FACTORY SELF-DESTRUCT: "+String(x) +"[/color]"
	red = !red
func _on_FullTimer_timeout():
	ded = true


func _on_Laser_body_entered(body):
	if body.get_collision_layer_bit(0):
		body.call("damage",1)
