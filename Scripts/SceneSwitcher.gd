extends Area2D

export var scene : PackedScene
export var spawnPoint : String

func _ready() -> void:
	connect("body_entered", self, "switch_scene")

func switch_scene(body):
	if body == PlayerVariables.node:
		Spawn.currentSpawnPoint = spawnPoint
		get_tree().change_scene_to(scene)
