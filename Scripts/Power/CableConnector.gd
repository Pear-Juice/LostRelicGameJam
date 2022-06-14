extends Node

var connected: bool
onready var player = get_node("/root/PlayerVariables") as KinematicBody2D
var powerline: Line2D
var connectedPowerline: Line2D

onready var animatedSprite: AnimatedSprite = find_node("AnimatedSprite")

func _process(delta):
	
	if connected:
		animatedSprite.frame = 1
	else:
		animatedSprite.frame = 0

	if powerline && !powerline.generator.isGenerating:
		disconnect_line()
		
	#print(str(player.powerline) + "   " + str(powerline) + "  " + str(connectedPowerline))
		
func _on_interact():
	powerline = player.powerline
	check_on_off()
	
func check_on_off():
	if powerline:
		if !connectedPowerline:
			connect_line()
		else:
			connectedPowerline.stop_generation()
			connectedPowerline.generator.isGenerating = false
			connectedPowerline = null
			connect_line()
	else:
		if connectedPowerline:
			 disconnect_line()
	
func connect_line():
	connected = true
	powerline.attachmentNode = self
	connectedPowerline = powerline
	
	player.powerline = null
	

func disconnect_line():
	connected = false
	
	if connectedPowerline:
		connectedPowerline.attachmentNode = player.node
	connectedPowerline = null
	
