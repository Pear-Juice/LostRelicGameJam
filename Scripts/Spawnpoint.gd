extends Node2D

onready var player = PlayerVariables

export var pointName : String
# Called when the node enters the scene tree for the first time.
func initialize():
	print("init")
	Spawn.spawnpointNames.append(pointName)
	Spawn.spawnpoints.append(global_position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
