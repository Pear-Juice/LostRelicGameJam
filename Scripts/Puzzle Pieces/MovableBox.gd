tool

extends KinematicBody2D

onready var connector = get_node("Cable Connector") as Node2D

export (int) var speed
enum ConnectorDirection{Front, Back, Left, Right}
export (ConnectorDirection) var connectorDirection


var move: bool

func _on_give_power():
	move = true
	
func _on_take_power():
	move = false
	
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
			move_and_collide(Vector2(0,speed).rotated(rotation))
		
	
