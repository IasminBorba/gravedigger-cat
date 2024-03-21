extends CharacterBody2D


const SPEED = 200.0
const JUMP_FORCE = -350.0





# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 1100
var is_jumping := false
var is_attacking_shovel := false
var is_attacking_light := false
var player_life := 5
var knockback_vector := Vector2.ZERO

var can_track_input: bool = true
@onready var animation:= $anim as AnimatedSprite2D

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_FORCE
		is_jumping = true
	elif is_on_floor():
		is_jumping = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right") 
	if direction:
		velocity.x = direction * SPEED
		animation.scale.x = direction
		if !is_jumping:
			animation.play("run")
	elif is_jumping:
		animation.play("jump")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
		if !is_attacking_light and !is_attacking_shovel:
			animation.play('cat')

	if Input.is_action_just_pressed("attackq") and is_on_floor():
		animation.play('attackShovel')
		is_attacking_shovel = true

	if Input.is_action_just_pressed("attacke") and is_on_floor():
		animation.play('attackLight')
		is_attacking_light = true

	if knockback_vector != Vector2.ZERO:
		velocity = knockback_vector

	move_and_slide()


func _on_hitbox_body_entered(body):
	if body.is_in_group("enemies"):
		body.anim.play("attackShould")


func take_damage(knockback_force := Vector2.ZERO, duration := 0.25):
	player_life -= 1
	
	if knockback_force != Vector2.ZERO:
		knockback_vector = knockback_force
		
		var knockback_tween := get_tree().create_tween()
		knockback_tween.tween_property(self, "knockback_vector", Vector2.ZERO, duration)


func _on_hurtbox_body_entered(body):
	if player_life < 0:
		# alterar cena para de game over
		queue_free()
	else:
		take_damage(Vector2(200, -200))
		



func _on_anim_animation_finished():
	if animation.animation == 'attackShovel':
		is_attacking_shovel = false
	if animation.animation == 'attackLight':
		is_attacking_light = false
