extends KinematicBody2D
onready var _animator = $AnimatedSprite

export (int) var speed = 200

var velocity = Vector2()

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("left"):
		velocity.x += 1
	if Input.is_action_pressed("right"):
		velocity.x -= 1
	
	velocity = velocity.normalized() * speed
	velocity = velocity.normalized() * speed
	
func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
	
	# animation
	var a_table = [["walk-l", "idle-l"], ["walk-r", "idle-r"], ["walk-u", "idle-u"], ["walk-d", "idle-d"]]
	if (velocity == Vector2()):
		for a in a_table:
			if (_animator.animation == a[0]):
				_animator.animation = a[1]
	elif (velocity.y < 0):
		_animator.animation = "walk-u"
	elif (velocity.y > 0):
		_animator.animation = "walk-d"
	elif (velocity.x > 0):
		_animator.animation = "walk-r"
	elif (velocity.x < 0):
		_animator.animation = "walk-l"
