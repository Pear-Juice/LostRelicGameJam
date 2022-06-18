extends Node2D

onready var powerline = $Powerline as Node2D
onready var animatedSprite = $AnimatedSprite as AnimatedSprite

func _on_give_power():
	powerline.electrified = true
	animatedSprite.frame = 1
	
func _on_take_power():
	powerline.electrified = false
	animatedSprite.frame = 0
