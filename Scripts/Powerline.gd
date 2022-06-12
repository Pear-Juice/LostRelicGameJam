extends Line2D

export var initialPoint: Vector2
export var distanceToDelete: float
var deleteSecondLastPoint: bool
var playerPos: Vector2

func _ready():
	set_as_toplevel(true)
	add_point(initialPoint)

func _process(delta):
	playerPos = get_parent().global_position
	
	if Input.is_action_just_pressed("add_point"):
		deleteSecondLastPoint = false
		place_point()
		
	if points.size() > 0:
		points[points.size() - 1] = get_parent().global_position
		check_point_deletion()
		
	

func place_point():
	add_point(get_parent().global_position)
	
func check_point_deletion():
	if !deleteSecondLastPoint && points[points.size() - 2]:
		if points[points.size() - 2].distance_to(playerPos) > distanceToDelete:
			deleteSecondLastPoint = true
	
	var index: int
	for point in points:
		if point.distance_to(playerPos) < distanceToDelete && point != points[points.size() - 1]:
			if deleteSecondLastPoint:
				delete_point_recursive(index)
			elif point != points[points.size() - 2]:
				delete_point_recursive(index)
		index += 1

func delete_point_recursive(index):
	for i in range(index, points.size() - 1):
		remove_point(index)
