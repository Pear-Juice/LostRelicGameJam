extends Node2D

onready var powerLine = get_node("Powerline")
onready var player = get_node("/root/PlayerVariables").node	
	
func _on_interact():
	powerLine.startStop(global_position, player)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
