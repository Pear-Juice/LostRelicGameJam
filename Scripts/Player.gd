extends KinematicBody2D

onready var node = get_tree().get_nodes_in_group("Player")[0] as KinematicBody2D
onready var animationPlayer = node.get_node("AnimationPlayer") as AnimationPlayer
onready var motor = node.get_node("Movement") as Node

var audioSource : AudioStreamPlayer2D
export var spawnSound: AudioStream
export var deathSound: AudioStream

#null if you arent holding
var powerline: Line2D

export (int) var baseHealth = 4
var health = 4

func _ready() -> void:
	PlayerVariables.node = get_tree().get_nodes_in_group("Player")[0] as KinematicBody2D
	PlayerVariables.animationPlayer = node.get_node("AnimationPlayer") as AnimationPlayer
	animationPlayer.get_node("CanvasModulate").color = Color.black
	node.audioSource = node.get_node("AudioStreamPlayer2D") as AudioStreamPlayer2D
	
	Spawn.spawn()

func receive_damage(dmg):
	node.health -= dmg
	if (node.health <= 0):
		die()

func die():
	print(str(node.deathSound) + "  " + str(node.audioSource))
	node.audioSource.stream = node.deathSound
	node.audioSource.play()
	animationPlayer.play("Death 1")
	
	if powerline:
		powerline.stop_generation()
	powerline = null
	if PlayerVariables.powerline:
		PlayerVariables.powerline.stop_generation()
		PlayerVariables.powerline = null
		
	
	yield(get_tree().create_timer(0.5), "timeout")
	health = baseHealth
	get_tree().reload_current_scene()

func add_force(force: Vector2):
	motor.ext_velocity = force
	
func move_player(pos: Vector2):
	if (self == node):
		global_position = pos
	else:
		node.global_position = pos
		
