extends StaticBody2D

var is_drawing = false
var start_position
var end_position

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Draw"):
		is_drawing = true
		start_position = get_mouse_position()
	
	if Input.is_action_just_released("Draw"):
		end_position = get_mouse_position()
		draw_line_with_collision(start_position, end_position)
		is_drawing = false

func draw_line_with_collision(start, end):
	var line = Line2D.new()
	line.texture = load("res://Ressources/SunnyLand/sunny-land/assets/environment/collision.png")
	line.width = 5
	line.add_point(start)
	line.add_point(end)
	var collision = get_collision(line)
	add_child(collision)
	add_child(line)
	add_timer_to_destroy([line, collision])

func add_timer_to_destroy(arr):
	var timer = Timer.new()
	arr.append(timer)
	timer.set_wait_time(1)
	timer.connect("timeout", remove_children.bind(arr))
	
	add_child(timer)
	timer.start()
	
func remove_children(children):
	for child in children:
		remove_child(child)
	
func get_collision(line):
	for i in line.points.size() - 1:
		var collision_shape = CollisionShape2D.new()
		var segment = SegmentShape2D.new()
		segment.a = line.points[i]
		segment.b = line.points[i + 1]
		collision_shape.shape = segment
		return collision_shape

func get_mouse_position():
	return get_global_mouse_position()
