extends Node2D

onready var player = get_node("/root/PlayerVariables") as KinematicBody2D

export var pointName : String
# Called when the node enters the scene tree for the first time.
func initialize():
	print("init")
	player.node.spawnpointNames.append(pointName)
	player.node.spawnpoints.append(global_position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
