extends Line2D

export var initialPoint: Vector2
export var distanceToDelete: float
var deleteSecondLastPoint: bool

var attachmentNode: Node2D
var attachmentPos: Vector2

func _ready():
	set_as_toplevel(true)
	add_point(initialPoint)

func _process(delta):
	attachmentPos = get_attachment_position()
	
	if Input.is_action_just_pressed("add_point"):
		deleteSecondLastPoint = false
		place_point()
		
	if points.size() > 0:
		points[points.size() - 1] = get_parent().global_position
		check_point_deletion()
		

func get_attachment_position() -> Vector2:
	return attachmentNode.global_position
	
func set_attachment_node(node: Node2D):
	attachmentNode = node

func place_point():
	add_point(get_parent().global_position)
	
func check_point_deletion():
	if !deleteSecondLastPoint && points[points.size() - 2]:
		if points[points.size() - 2].distance_to(attachmentPos) > distanceToDelete:
			deleteSecondLastPoint = true
	
	var index: int
	for point in points:
		if point.distance_to(attachmentPos) < distanceToDelete && point != points[points.size() - 1]:
			if deleteSecondLastPoint:
				delete_point_recursive(index)
			elif point != points[points.size() - 2]:
				delete_point_recursive(index)
		index += 1

func delete_point_recursive(index):
	for i in range(index, points.size() - 1):
		remove_point(index)
