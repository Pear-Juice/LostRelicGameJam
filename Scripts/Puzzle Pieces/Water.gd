extends Area2D

onready var player = get_node("/root/PlayerVariables") as KinematicBody2D

func _on_body_entered(area: Area2D) -> void:
	if player.powerline && player.powerline.electrified:
		player.node.die()
