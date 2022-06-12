extends Node

signal interact
var interactable: bool

func _ready():
	add_to_group("Interactors")
	
func interact():
	print("Interacted with: " + self.name)
	emit_signal("interact")
	
