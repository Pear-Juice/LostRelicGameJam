extends StaticBody2D

onready var collider = $CollisionShape2D as CollisionShape2D
onready var sprite = $AnimatedSprite as AnimatedSprite
onready var audioPlayer = $AudioStreamPlayer as AudioStreamPlayer
export var openSound : AudioStream
export var openSpecialSound : AudioStream
export var closeSound : AudioStream

func _on_give_power():
	collider.disabled = true
	sprite.frame = 1
	if !openSpecialSound:
		audioPlayer.stream = openSound
	else:
		audioPlayer.stream = openSpecialSound
	audioPlayer.play()
	

func _on_take_power():
	collider.disabled = false
	sprite.frame = 0
	audioPlayer.stream = closeSound
	audioPlayer.play()
