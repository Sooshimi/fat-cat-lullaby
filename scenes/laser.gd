extends Line2D

func _ready():
	add_point(get_parent().position)
	add_point(get_global_mouse_position(), 0)

func _process(delta):
	set_point_position(0, get_global_mouse_position())
