tool

extends KinematicBody2D

onready var connector = get_node("Cable Connector") as Node2D
onready var player = PlayerVariables

export (int) var speed
enum ConnectorDirection{Front, Back, Left, Right}
export (ConnectorDirection) var connectorDirection

onready var audioPlayer : AudioStreamPlayer2D = $AudioStreamPlayer2D

export var startNoise : AudioStream
export var continueNoise : AudioStream
export var endNoise : AudioStream


var move: bool = false
func custom_attach(node):
	yield(get_tree().create_timer(.1), "timeout")
	connector.custom_attach(node)

func _on_give_power():
	move = true
	audioPlayer.stream = startNoise
	audioPlayer.play()
	
func _on_take_power():
	move = false
	audioPlayer.stream = endNoise
	audioPlayer.play()

func _ready():
	if (connector):
			if connectorDirection == ConnectorDirection.Front:
				connector.rotation_degrees = 0
			elif connectorDirection == ConnectorDirection.Back:
				connector.rotation_degrees = 180
			elif connectorDirection == ConnectorDirection.Left:
				connector.rotation_degrees = 90
			elif connectorDirection == ConnectorDirection.Right:
				connector.rotation_degrees = -90
	
func _process(delta: float) -> void:
	if Engine.editor_hint:
		if (connector):
			if connectorDirection == ConnectorDirection.Front:
				connector.rotation_degrees = 0
			elif connectorDirection == ConnectorDirection.Back:
				connector.rotation_degrees = 180
			elif connectorDirection == ConnectorDirection.Left:
				connector.rotation_degrees = 90
			elif connectorDirection == ConnectorDirection.Right:
				connector.rotation_degrees = -90
		
		if connectorDirection == ConnectorDirection.Front:
			pass

func collide_move(dir: Vector2):
	if !Engine.editor_hint:
		move_and_collide(dir)

var hasJustMoved: bool
var isMoving: bool
func _physics_process(delta: float) -> void:
	if not Engine.editor_hint:
		var dir = Vector2(0,0)
		if move:
			dir = Vector2(0,speed).rotated(rotation)
			isMoving = true
		else:
			if (isMoving):
				dir = -Vector2(0,speed).rotated(rotation)
				isMoving = false	
				hasJustMoved = true
			else:
				dir = Vector2(0,0)
		
		var collision = move_and_collide(dir)
		
		if collision && collision.collider.is_class("KinematicBody2D"):
			#if is player
			if collision.collider.get_script() == player.node.get_script():
				player.node.move_and_collide(dir)
				
				if !move && hasJustMoved:
					yield(get_tree().create_timer(.1), "timeout")
					move_and_collide(-Vector2(0,speed).rotated(rotation) / 4)
			if collision.collider.get_script() == self.get_script():
				collision.collider.move_and_collide(dir)
			
	hasJustMoved = false	

func check_stuck(node: KinematicBody2D) -> bool:
	var pos = node.global_position
	if node.test_move(node.transform, Vector2(0,0)):
		return true
		
	return false
