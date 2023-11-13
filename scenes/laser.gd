extends Line2D

func _ready():
	add_point(get_child(0).position)
	add_point(get_global_mouse_position(), 0)

func _process(_delta):
	set_point_position(0, get_global_mouse_position())
