tool

extends KinematicBody2D

onready var connector = get_node("Cable Connector") as Node2D
onready var player = get_node("/root/PlayerVariables")

export (int) var speed
enum ConnectorDirection{Front, Back, Left, Right}
export (ConnectorDirection) var connectorDirection


var move: bool

func _on_give_power():
	move = true
	
func _on_take_power():
	move = false

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
		else:
			connector = get_node("Cable Connector") as Node2D
		
		if connectorDirection == ConnectorDirection.Front:
			pass

	
func _physics_process(delta: float) -> void:
	if not Engine.editor_hint:
		if move:
			var collision = move_and_collide(Vector2(0,speed).rotated(rotation))
			if collision:
				if collision.collider.is_class("KinematicBody2D"):
					collision.collider.move_and_collide(Vector2(0,speed).rotated(rotation))
					if collision.collider.get_script() == player.node.get_script() && check_stuck(collision.collider):
						player.node.die()
					
func check_stuck(node: KinematicBody2D) -> bool:
	var pos = node.global_position
	if node.test_move(node.transform, Vector2(0,0)):
		return true
		
	return false
