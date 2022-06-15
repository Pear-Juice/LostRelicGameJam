extends KinematicBody2D

export (int) var speed

var move: bool

func _on_give_power():
	move = true
	
func _on_take_power():
	move = false
	
func _process(delta: float) -> void:
	if move:
		move_and_collide(Vector2(0, speed))
	
