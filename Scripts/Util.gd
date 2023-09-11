extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

static func delete_children(node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()
