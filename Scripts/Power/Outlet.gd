extends Node

onready var powerline = $Powerline as Node2D

func _on_give_power():
	powerline.electrified = true
	
func _on_take_power():
	powerline.electrified = false
