extends KinematicBody2D

onready var node = get_tree().get_nodes_in_group("Player")[0] as KinematicBody2D
onready var animationPlayer = node.get_node("AnimationPlayer") as AnimationPlayer


#null if you arent holding
var powerline: Line2D
var spawnPoint: Vector2

func _process(delta: float) -> void:
	node.powerline = powerline

func die():
	animationPlayer.play("Death 1")
	
	if powerline:
		node.powerline.stop_generation()
	
	yield(get_tree().create_timer(0.5), "timeout")
	node.global_position = spawnPoint

