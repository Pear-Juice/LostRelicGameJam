extends StaticBody2D

onready var collider = $CollisionShape2D as CollisionShape2D
onready var sprite = $AnimatedSprite as AnimatedSprite

func _on_give_power():
	collider.disabled = true
	sprite.frame = 1
	

func _on_take_power():
	collider.disabled = false
	sprite.frame = 0
