extends Area2D

onready var player = PlayerVariables

func _on_body_entered(area: Area2D) -> void:
	if player.powerline && player.powerline.electrified:
		player.node.die()
