extends Node

export var interactionDistance: float
onready var player = get_node("/root/PlayerVariables") as KinematicBody2D

func _process(delta):
	var interactors : Array = get_tree().get_nodes_in_group("Interactors")

	var reachableInteractorDistances: Array
	var reachableInteractors: Array

	for interactor in interactors:
		#get distance to interactor
		interactor.interactable = false
		var distance = interactor.global_position.distance_to(player.node.global_position)
		
		#if player is close enough, add to reachable interactor lists
		if distance < interactionDistance:
			reachableInteractors.append(interactor)
			reachableInteractorDistances.append(distance)
	
	#find which of the reachable interactors is closes and check call interact
	if reachableInteractorDistances.size() > 0:
		var closestInteractorIndex = reachableInteractorDistances.find(reachableInteractorDistances.min())
		var closestInteractor = reachableInteractors[closestInteractorIndex]
		
		check_call_interactor(closestInteractor)
		closestInteractor.interactable = true;
		
	#if press interact and no interactors are near then drop cable
	if Input.is_action_just_pressed("interact") and reachableInteractors.size() == 0 && player.powerline != null:
		player.powerline.stop_generation()

func check_call_interactor(interactor):
	if !interactor:
		return
	
	if Input.is_action_just_pressed("interact"):
		interactor.interact()
