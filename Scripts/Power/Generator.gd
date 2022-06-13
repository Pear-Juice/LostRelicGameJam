extends Node2D

onready var powerLine = get_node("Powerline")
	
func _on_interact(player):
	powerLine.startStop(global_position, player)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
