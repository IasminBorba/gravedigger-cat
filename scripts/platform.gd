extends AnimatableBody2D

var rotation_speed = 200

func _ready():
	pass

func _process(delta):
	var rotation_amount = rotation_speed * delta
	rotation_degrees += rotation_amount
