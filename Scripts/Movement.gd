extends Node2D
export (NodePath) var animatorPath: NodePath
onready var _animator = get_node(animatorPath) as AnimatedSprite
onready var _kinematicBody = get_parent() as KinematicBody2D
onready var audioPlayer = get_node("../AudioStreamPlayer2D") as AudioStreamPlayer2D

export var stepSounds : AudioStream

export (int) var speed

var velocity = Vector2()
var ext_velocity = Vector2()

var que_atk = false

func _ready() -> void:
	audioPlayer.stream = stepSounds

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
	
	if Input.is_action_just_pressed("attack"):
		attack()

var playStepSound : bool = false

func _physics_process(_delta):
	get_input()
	velocity += ext_velocity
	ext_velocity *= 0.5
	
	if velocity != Vector2(0,0):
		if !playStepSound:
			audioPlayer.play()
			playStepSound = true
	else:
		audioPlayer.stop()
		playStepSound = false
		
	velocity = _kinematicBody.move_and_slide(velocity)
	animate()

	# animation
func animate():
	var a_table = [["walk-l", "idle-l"], ["walk-r", "idle-r"], ["walk-u", "idle-u"], ["walk-d", "idle-d"]]
	if (velocity == Vector2()):
		for a in a_table:
			if (_animator.animation == a[0]):
				_animator.animation = a[1]
				break
				
	if (velocity.x != 0 && velocity.y != 0):
		return
	
	elif (velocity.y < 0):
		_animator.animation = "walk-u"
	elif (velocity.y > 0):
		_animator.animation = "walk-d"
	elif (velocity.x > 0):
		_animator.animation = "walk-r"
	elif (velocity.x < 0):
		_animator.animation = "walk-l"

func attack():
	pass
