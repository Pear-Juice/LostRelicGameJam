extends Node2D

onready var _kinematicBody = get_parent() as KinematicBody2D
onready var _player = get_node("/root/PlayerVariables").node as KinematicBody2D


export (int) var speed = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(_delta):
	var direction = (_player.global_position - global_position).normalized()
	_kinematicBody.move_and_slide(direction * speed)

func get_nav_path():
	pass

func _on_Area2D_body_entered(body: KinematicBody2D):
	if (body.has_method("receive_damage")):
		body.call("receive_damage", 1)
	print_debug("damage")
