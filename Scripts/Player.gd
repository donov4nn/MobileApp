extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = get_node("AnimationPlayer")
@onready var sprite = get_node("AnimatedSprite2D")

func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump()

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("Left", "Right")
	
	if direction:
		velocity.x = direction * SPEED
		set_character_direction(direction)
		
		if velocity.y == 0:
			run()
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			idle()
	
	if velocity.y > 0:
		fall()
		
	move_and_slide()

# moves
func fall():
	anim.play("Fall")

func idle():
	anim.play("Idle")

func jump():
	anim.play("Jump")

func run():
	anim.play("Run")

# to make the character move from left to right	
func set_character_direction(direction):
	if direction == -1:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
