extends Node2D

onready var powerline = get_node("Powerline")
onready var player = get_node("/root/PlayerVariables")

var isGenerating: bool
	
func _on_interact():
	print(player.powerline)
	if !isGenerating && player.powerline == null:
		isGenerating = true
		powerline.start_generation(global_position, player.node)
	elif isGenerating:
		isGenerating = false
		powerline.stop_generation()
		
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
