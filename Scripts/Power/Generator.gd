extends Node2D

export var defaultAttachmentNodePath : NodePath
onready var powerline = get_node("Powerline")

func _ready() -> void:
	if defaultAttachmentNodePath:
		powerline.set_default_attachment_node(get_node(defaultAttachmentNodePath))
	powerline.electrified = true
