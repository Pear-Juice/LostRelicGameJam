extends Line2D
onready var player = PlayerVariables
export var generationPoitionNodePath: NodePath
onready var generationPositionNode = get_node(generationPoitionNodePath) as Node2D

export var distanceToDelete: float
var deleteSecondLastPoint: bool

var attachmentNode: Node2D
var attachmentPos: Vector2
var generatorPos: Vector2

var attachedToPlayer: bool
var isGenerating: bool
var electrified: bool

onready var audioPlayer = $AudioStreamPlayer as AudioStreamPlayer

export var unplugSound: AudioStream
export var plugSound: AudioStream


func _ready():
	set_as_toplevel(true)
	self.visible = false

func set_default_attachment_node(node):
	stop_generation()
	start_generation(node)
	attachmentNode.custom_attach(self)
		
func _on_interact():
	if !isGenerating && player.powerline == null:
		isGenerating = true
		print("IIIIIIII")

		start_generation(player.node)
	elif isGenerating:
		isGenerating = false
		stop_generation()
	
func _process(_delta):
	update_generation()

func start_generation(attachNode):
	audioPlayer.stream = unplugSound
	audioPlayer.play()
	
	delete_point_recursive(0)
	attachmentNode = attachNode
	isGenerating = true
	generatorPos = get_generation_position()
	
	yield(get_tree().create_timer(0.05), "timeout")
	self.visible = true

func stop_generation():
	audioPlayer.stream = unplugSound
	audioPlayer.stop()
	
	self.visible = false
	delete_point_recursive(0)
	attachmentNode = null
	deleteSecondLastPoint = false
	isGenerating = false
	player.powerline = null

func update_generation():
	if (!attachmentNode || !isGenerating):
		return
		
	if get_point_count() == 0 || get_point_count() == 1:
		if get_point_count() == 1:
			delete_point_recursive(0)
		
		generatorPos = get_generation_position()
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
		if point.distance_to(attachmentPos) < distanceToDelete && points.size() > 0 && point != points[points.size() - 1]:
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
	
func get_generation_position() -> Vector2:
	return generationPositionNode.global_position
