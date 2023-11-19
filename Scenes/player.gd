extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var hasDoubledJumped = false
var isDashing = false
var isTurnedLeft = false

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			hasDoubledJumped = false
		elif not hasDoubledJumped:
			velocity.y = JUMP_VELOCITY
			hasDoubledJumped = true
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		animated_sprite_2d.play("run")
		if direction < 0:
			animated_sprite_2d.flip_h = true
			isTurnedLeft = true
		else:
			animated_sprite_2d.flip_h = false
			isTurnedLeft = false
	else:
		animated_sprite_2d.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if Input.is_action_just_pressed("ui_dash") and not isDashing:
		#isDashing = true
		if isTurnedLeft:
			velocity.x = -1 * SPEED * 10
		else:
			velocity.x = SPEED * 10
		#await get_tree().create_timer(0.3).timeout
		#isDashing = false
		
	move_and_slide()
