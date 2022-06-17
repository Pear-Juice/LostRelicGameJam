extends Node2D

onready var player = PlayerVariables

export var pointName : String
# Called when the node enters the scene tree for the first time.
func initialize():
	if (!Spawn.spawnpoints.has([pointName, global_position])):
		Spawn.spawnpoints.append([pointName,global_position])
		print("Initialize spawn point: " + pointName)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
