extends CharacterBody2D


const SPEED = 200.0
const JUMP_FORCE = -350.0



# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 1100
var is_jumping := false

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
		animation.play("cat")
	if Input.is_action_just_pressed("attackq") and is_on_floor():
		animation.play("atackpa")
	if Input.is_action_just_pressed("attacke") and is_on_floor():
		animation.play("atackluz")
	

	move_and_slide()
