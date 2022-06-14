extends Line2D
onready var player = get_node("/root/PlayerVariables")
onready var generator = get_parent()

export var distanceToDelete: float
var deleteSecondLastPoint: bool

var attachmentNode: Node2D
var attachmentPos: Vector2
var generatorPos: Vector2

var attachedToPlayer: bool

func _ready():
	set_as_toplevel(true)

func start_generation(generatePos: Vector2, attachNode = null):
	delete_point_recursive(0)
	self.generatorPos = generatePos
	attachmentNode = attachNode

func stop_generation():
	delete_point_recursive(0)
	attachmentNode = null
	deleteSecondLastPoint = false
	player.powerline = null

# warning-ignore:unused_argument
func _process(delta):
	if (!attachmentNode || !generator.isGenerating):
		return
		
	if get_point_count() == 0 || get_point_count() == 1:
		if get_point_count() == 1:
			delete_point_recursive(0)
		
		add_point(generatorPos)
		place_point()
		return
		
	check_attached_to_player()
	attachmentPos = get_attachment_position()
	
	if attachedToPlayer:
		player.powerline = self
	
	if attachedToPlayer and Input.is_action_just_pressed("add_point"):
		deleteSecondLastPoint = false
		place_point()
		
	if points.size() > 1:
		points[points.size() - 1] = attachmentPos
		check_point_deletion()
		
		
func place_point():
	add_point(attachmentPos)
	
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
# warning-ignore:unassigned_variable_op_assign
		index += 1

func check_attached_to_player():
	if attachmentNode == player.node:
		attachedToPlayer = true
	else:
		attachedToPlayer = false

func delete_point_recursive(index):
	for _i in range(index, points.size()):
		remove_point(index)

func get_attachment_position() -> Vector2:
	return attachmentNode.global_position
