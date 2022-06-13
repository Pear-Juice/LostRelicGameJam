extends KinematicBody2D

onready var node = get_tree().get_nodes_in_group("Player")[0]

#null if you arent holding
var powerline: Node2D
