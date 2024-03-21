extends CharacterBody2D

const SPEED = 700.0
const JUMP_VELOCITY = -400.0

@onready var wall_detector := $wall_detector as RayCast2D
@onready var texture := $animated as AnimatedSprite2D
@onready var anim := $anim as AnimationPlayer

var direction := 1
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var dead := false

func _physics_process(delta: float) -> void:
	if not dead:
		if not is_on_floor():
			velocity.y += gravity * delta
		
		if wall_detector.is_colliding():
			direction *= -1
			wall_detector.scale.x *= -1
			
		if direction == 1:
			texture.flip_h = false
		else:
			texture.flip_h = true
			
		velocity.x = direction * SPEED * delta
		
		move_and_slide()
	else:
		texture.play("die")


func _on_animated_animation_finished():
		queue_free()
