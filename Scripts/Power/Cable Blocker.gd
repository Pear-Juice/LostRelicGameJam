extends Node2D

onready var collider = get_node("CollisionShape2D")

func _process(delta: float) -> void:
	if PlayerVariables.powerline:
		collider.disabled = true
	else:
		collider.disabled = false
