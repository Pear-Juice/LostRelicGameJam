extends Area2D

export var scene : String
export var spawnPoint : String

func _ready() -> void:
	connect("body_entered", self, "switch_scene")

func switch_scene(body):
	if body == PlayerVariables.node:
		PlayerVariables.node.get_node("Movement").speed = 0
		PlayerVariables.animationPlayer.play("StartSceneSwitch")
		yield(get_tree().create_timer(.5), "timeout")
		
		Spawn.currentSpawnPoint = spawnPoint
		get_tree().change_scene(scene)
