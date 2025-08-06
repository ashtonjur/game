extends Node2D

var sort_timer := 0.0

func _process(delta):
	sort_timer += delta
	if sort_timer >= 0.1:  # Sort every 0.1s instead of every frame
		_sort_by_y_and_reorder()
		sort_timer = 0

func _sort_by_y_and_reorder():
	var children = get_children()
	children.sort_custom(Callable(self, "_sort_by_y"))

	for i in range(children.size()):
		var child = children[i]
		if child is CanvasItem:
			child.z_index = 0
			child.z_as_relative = false
			if get_child(i) != child:
				move_child(child, i)
