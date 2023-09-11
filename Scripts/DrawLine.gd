extends StaticBody2D

const util = preload("res://Scripts/Util.gd")
var is_drawing = false
var current_point_index = -1

@onready var line : Line2D = get_node("Line2D")
@onready var undraw_timer : Timer = get_node("UndrawTimer")

func _ready():
	pass 
	
func _process(delta):
	if Input.is_action_just_pressed("Draw"):
		start_drawing()
		
	if Input.is_action_just_released("Draw"):
		is_drawing = false	
	
	if is_drawing:
		draw()

func start_drawing():
	_undraw()
	undraw_timer.start()
	add_point_and_collision()
	is_drawing = true

func draw():
	var length = get_line_length()
	if (length < 100):
		add_point_and_collision()
	
func _undraw():
	current_point_index = -1
	line.clear_points()
	remove_collisions()
	undraw_timer.stop()
	
func get_line_length():
	var total_distance = 0
	
	if line.get_point_count() < 2:
		return total_distance
	
	for index in line.get_point_count() - 1:
		var point1 = line.get_point_position(index)
		var point2 = line.get_point_position(index + 1)
		total_distance += point1.distance_to(point2) 

	return total_distance

func add_point_and_collision():
	line.add_point(get_global_mouse_position())
	current_point_index += 1
	
	if (current_point_index < 1):
		return
	
	var collision = CollisionShape2D.new()
	var segment = SegmentShape2D.new()
	segment.a = line.get_point_position(current_point_index -1)
	segment.b = line.get_point_position(current_point_index)
	collision.shape = segment
	add_child(collision)

func remove_collisions():
	for child in get_children():
		if child is CollisionShape2D:
			remove_child(child)
