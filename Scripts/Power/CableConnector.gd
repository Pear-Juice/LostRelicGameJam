extends Node

var connected: bool
onready var player = get_node("/root/PlayerVariables")

onready var animatedSprite: AnimatedSprite = find_node("AnimatedSprite")

func _process(delta):
	if connected:
		animatedSprite.frame = 1
	else:
		animatedSprite.frame = 0
		
func _on_interact():
	
	if player.powerline == null:
		return
		
	# if is not connected and is connected to player then connect to this cable connector
	if !connected && player.powerline.attachmentNode == player.node:
		connected = true
		player.powerline.attachmentNode = self	
	elif connected:
		#if is connected then connect back to player
		connected = false
		player.powerline.attachmentNode = player.node
	
