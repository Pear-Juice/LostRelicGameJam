extends Node2D

export (NodePath) var animatorPath: NodePath
onready var _animator = get_node(animatorPath) as AnimatedSprite

onready var _kinematicBody = get_parent() as KinematicBody2D
onready var _player = get_node("/root/PlayerVariables").node as KinematicBody2D

var velocity = Vector2()
export (int) var speed = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(_delta):
	velocity = (_player.global_position - global_position).normalized()
	_kinematicBody.move_and_slide(velocity * speed)
	animate()

	# animation
func animate():
	print(velocity)
	var a_table = [["walk-l", "idle-l"], ["walk-r", "idle-r"], ["walk-u", "idle-u"], ["walk-d", "idle-d"]]
	if (velocity == Vector2()):
		for a in a_table:
			if (_animator.animation == a[0]):
				_animator.animation = a[1]
				
	if (abs(velocity.x) < abs(velocity.y)):
		if (velocity.y < 0):
			_animator.animation = "walk-u"
		elif (velocity.y > 0):
			_animator.animation = "walk-d"
	else:
		if (velocity.x > 0):
			_animator.animation = "walk-r"
		elif (velocity.x < 0):
			_animator.animation = "walk-l"


func get_nav_path():
	pass

func _on_Area2D_body_entered(body: KinematicBody2D):
	if body != get_parent():
		_player.receive_damage(1)
	
