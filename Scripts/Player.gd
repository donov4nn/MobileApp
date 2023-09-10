extends CharacterBody2D

@export var speed = 300
@export var jump_force = 220
@export var gravity = 300

@onready var ap = get_node("AnimationPlayer")
@onready var sprite = get_node("Sprite2D")

func _physics_process(delta):
	
	# gravity
	if not is_on_floor():  
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("Jump") && is_on_floor():
		velocity.y = -jump_force

	# Get the input direction and handle the movement/deceleration.
	var horizontal_direction = Input.get_axis("Left", "Right")
	velocity.x = horizontal_direction * speed
	
	if horizontal_direction != 0:
		set_character_direction(horizontal_direction)

	move_and_slide()
	update_animations(horizontal_direction)

func update_animations(horizontal_direction):
	if is_on_floor() && horizontal_direction == 0:
		idle()
	elif is_on_floor():
		run()
	elif velocity.y < 0:
		jump()
	else:
		fall()

# moves
func fall():
	ap.play("fall")

func idle():
	ap.play("idle")

func jump():
	ap.play("jump")

func run():
	ap.play("run")

func set_character_direction(direction):
	sprite.flip_h = (direction == -1)
