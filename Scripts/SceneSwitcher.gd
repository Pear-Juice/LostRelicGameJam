extends Node

export var scene : PackedScene
onready var player = get_node("/root/PlayerVariables")

func switch_scene(body):
	if body == player.node:
		get_tree().change_scene_to(scene)
