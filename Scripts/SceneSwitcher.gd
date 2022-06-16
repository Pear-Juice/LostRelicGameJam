extends Area2D

export var scene : PackedScene
export var spawnPoint : String
onready var player = get_node("/root/PlayerVariables")

func _ready() -> void:
	connect("body_entered", self, "switch_scene")

func switch_scene(body):
	if body == player.node:
		get_tree().change_scene_to(scene)
