extends StaticBody2D

var health = 21

func damage(dmg):
	health -= dmg
	print("enemyhealth:" + String(health))
	if health<=0:
		die()


func die():
	queue_free()
