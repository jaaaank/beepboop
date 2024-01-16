extends KinematicBody2D
class_name Actor

const FLOOR_NORMAL: = Vector2.UP

export var speed: = Vector2(350.0, 700.0)
export var gravity: = 2500.0
export var sprint_mult: = Vector2(1.1, 1.1)
export var health: = 3.0

var _velocity: = Vector2.ZERO
