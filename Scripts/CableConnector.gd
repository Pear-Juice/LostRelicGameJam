extends Node

var connected: bool

onready var animatedSprite: AnimatedSprite = find_node("AnimatedSprite")

func _process(delta):
	if connected:
		animatedSprite.frame = 1
	else:
		animatedSprite.frame = 0
		
func _on_interact():
	if !connected:
		connected = true
	else:
		connected = false
	
