extends Node

signal interact
var interactable: bool

func _ready():
	add_to_group("Interactors")
	
func interact():
	print("Interacted with: " + get_parent().name)
	emit_signal("interact")
	
