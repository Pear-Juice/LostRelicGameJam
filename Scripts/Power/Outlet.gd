extends Node2D

export var defaultAttachmentNodePath : NodePath
onready var powerline = $Powerline as Node2D
onready var animatedSprite = $AnimatedSprite as AnimatedSprite

onready var audioPlayer = $AudioStreamPlayer as AudioStreamPlayer

export var plugSound: AudioStream
export var unplugSound: AudioStream

func _ready() -> void:
	if defaultAttachmentNodePath:
		powerline.set_default_attachment_node(get_node(defaultAttachmentNodePath))

func _on_give_power():
	powerline.electrified = true
	animatedSprite.frame = 1
	
func _on_take_power():
	powerline.electrified = false
	animatedSprite.frame = 0
