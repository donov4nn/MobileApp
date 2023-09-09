extends Area2D

var start_position
var end_position

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Write"):
		start_position = get_mouse_position()
	
	if Input.is_action_just_released("Write"):
		end_position = get_mouse_position()
		write_line(start_position, end_position)
	

func write_line(start, end):
	print("%s & %s" % [start, end])

func get_mouse_position():
	return get_viewport().get_mouse_position()
