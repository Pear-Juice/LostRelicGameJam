extends KinematicBody2D

onready var node = get_tree().get_nodes_in_group("Player")[0] as KinematicBody2D
onready var animationPlayer = node.get_node("AnimationPlayer") as AnimationPlayer
onready var motor = node.get_node("Movement") as Node

#null if you arent holding
var powerline: Line2D

export (int) var baseHealth = 4
var health = 4

func _ready() -> void:
	PlayerVariables.node = get_tree().get_nodes_in_group("Player")[0] as KinematicBody2D
	Spawn.spawn()

func receive_damage(dmg):
	node.health -= dmg
	if (node.health <= 0):
		die()

func die():
	animationPlayer.play("Death 1")
	
	if powerline:
		powerline.stop_generation()
	
	yield(get_tree().create_timer(0.5), "timeout")
	health = baseHealth

func add_force(force: Vector2):
	motor.ext_velocity = force
	
func move_player(pos: Vector2):
	if (self == node):
		global_position = pos
	else:
		node.global_position = pos
		
