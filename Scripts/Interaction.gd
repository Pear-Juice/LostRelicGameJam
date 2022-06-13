extends Node

export var interactionDistance: float

func _process(delta):
	var interactors : Array = get_tree().get_nodes_in_group("Interactors")

	var reachableInteractorDistances: Array
	var reachableInteractors: Array

	for interactor in interactors:
		#get distance to interactor
		interactor.interactable = false
		var distance = interactor.global_position.distance_to(owner.global_position)
		
		#if plaer is close enough, add to reachable interactor lists
		if distance < interactionDistance:
			reachableInteractors.append(interactor)
			reachableInteractorDistances.append(distance)
	
	#find which of the reachable interactors is closes and check call interact
	if reachableInteractorDistances.size() > 0:
		var closestInteractorIndex = reachableInteractorDistances.find(reachableInteractorDistances.min())
		var closestInteractor = reachableInteractors[closestInteractorIndex]
		
		check_call_interactor(closestInteractor)
		closestInteractor.interactable = true;

func check_call_interactor(interactor):
	if !interactor:
		return
	
	if Input.is_action_just_pressed("interact"):
		interactor.interact(get_parent())
