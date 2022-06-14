extends Node2D

onready var powerline = get_node("Powerline")
#onready var player = get_node("/root/PlayerVariables")

func _ready() -> void:
	powerline.electrified = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
