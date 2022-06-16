extends KinematicBody2D

onready var node = get_tree().get_nodes_in_group("Player")[0] as KinematicBody2D
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
	node = get_tree().get_nodes_in_group("Player")[0] as KinematicBody2D
	
	if (self == node):
		node.spawn(currentSpawnPoint)

func _process(_delta: float) -> void:
	if node && powerline:
		node.powerline = powerline

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
	
func spawn(pointName: String):
	var pointPos : Vector2
	
	for i in range(0, spawnpoints.size()):
		if (spawnpointNames[i] == pointName):
			pointPos = spawnpoints[i]
			break
	
	node.global_position = pointPos
