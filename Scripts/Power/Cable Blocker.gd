extends Node2D

onready var collider = get_node("CollisionShape2D")
onready var animator = get_node("AnimatedSprite")

func _process(delta: float) -> void:
	if PlayerVariables.powerline:
		collider.disabled = false
		animator.frame = 1
	else:
		collider.disabled = true
		animator.frame = 0
