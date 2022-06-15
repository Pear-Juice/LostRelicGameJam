extends KinematicBody2D

onready var node = get_tree().get_nodes_in_group("Player")[0] as KinematicBody2D
onready var animationPlayer = node.get_node("AnimationPlayer") as AnimationPlayer


#null if you arent holding
var powerline: Line2D
export var spawnPoint: Vector2

export (int) var baseHealth = 4
var health = 4

func _process(_delta: float) -> void:
	node.powerline = powerline

func receive_damage(dmg):
	node.health -= dmg
	if (node.health <= 0):
		die()

func die():
	animationPlayer.play("Death 1")
	
	if powerline:
		node.powerline.stop_generation()
	
	yield(get_tree().create_timer(0.5), "timeout")
	node.global_position = node.spawnPoint
	
	node.health = node.baseHealth

