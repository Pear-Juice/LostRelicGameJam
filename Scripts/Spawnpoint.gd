extends Node2D

onready var player = get_node("/root/PlayerVariables") as KinematicBody2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.node.spawnPoint = global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
