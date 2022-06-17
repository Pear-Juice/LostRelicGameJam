extends KinematicBody2D

onready var node = get_tree().get_nodes_in_group("Player")[0] as KinematicBody2D
onready var playerVariables = get_node("/root/PlayerVariables")
onready var animationPlayer = node.get_node("AnimationPlayer") as AnimationPlayer
onready var motor = node.get_node("Movement") as Node

#null if you arent holding
var powerline: Line2D

export (int) var baseHealth = 4
var health = 4

export var currentSpawnPoint : String
var spawnpoints : Array
var spawnpointNames : Array

func _ready() -> void:
	get_node("/root/PlayerVariables").node = get_tree().get_nodes_in_group("Player")[0] as KinematicBody2D
	
	if (node == self):
		initSpawnpoints()
		yield(get_tree().create_timer(.1), "timeout")
		node.spawn(currentSpawnPoint)

func receive_damage(dmg):
	node.health -= dmg
	if (node.health <= 0):
		die()

func die():
	animationPlayer.play("Death 1")
	
	if powerline:
		powerline.stop_generation()
	
	yield(get_tree().create_timer(0.5), "timeout")
	node.spawn(currentSpawnPoint)
	health = baseHealth

func add_force(force: Vector2):
	motor.ext_velocity = force
	
func initSpawnpoints():
	get_tree().call_group("Spawnpoint", "initialize")
	
func spawn(pointName: String):
	var pointPos : Vector2
	print("spawn")
	
	for i in range(0, spawnpoints.size()):
		if (spawnpointNames[i] == pointName):
			pointPos = spawnpoints[i]
			break
	
	global_position = pointPos
