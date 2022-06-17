extends Node2D

onready var powerline = get_node("Powerline")

func _ready() -> void:
	powerline.electrified = true
