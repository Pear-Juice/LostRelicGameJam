extends Node

signal give_power
signal take_power

var connected: bool
onready var player = PlayerVariables
onready var connectionPositionNode = $"Connection Position"
onready var audioPlayer = $AudioStreamPlayer as AudioStreamPlayer
var powerline: Line2D
var connectedPowerline: Line2D
var electrified: bool

export var plugSound: AudioStream
export var unplugSound: AudioStream

onready var animatedSprite: AnimatedSprite = find_node("AnimatedSprite")

func _process(delta):
	
	if connected && connectedPowerline.electrified:
		set_powered()
	else:
		set_unpowered()

	if powerline && !powerline.isGenerating:
		disconnect_line()
		
func set_powered():
	if !electrified:
		electrified = true
		animatedSprite.frame = 1
		
		audioPlayer.stream = plugSound
		audioPlayer.play()
		
		emit_signal("give_power")
		
		print("Powered on: " + str(self.name))
		
func set_unpowered():
	if electrified:
		electrified = false
		animatedSprite.frame = 0
		
		audioPlayer.stream = unplugSound
		audioPlayer.play()
		
		emit_signal("take_power")
		
		print("Powered off: " + str(self.name))
	
func _on_interact():
	powerline = player.powerline
	check_connected()
	
func custom_attach(node):
	powerline = node
	check_connected()
	
func check_connected():
	if powerline:
		if !connectedPowerline:
			connect_line()
		else:
			connectedPowerline.stop_generation()
			connectedPowerline = null
			connect_line()
	else:
		if connectedPowerline:
			 disconnect_line()
	
func connect_line():
	connected = true
	powerline.attachmentNode = connectionPositionNode
	connectedPowerline = powerline
	
	player.powerline = null
	

func disconnect_line():
	connected = false
	
	if connectedPowerline:
		connectedPowerline.attachmentNode = player.node
	connectedPowerline = null
	


func _on_give_power():
	pass # Replace with function body.


func _on_take_power():
	pass # Replace with function body.
